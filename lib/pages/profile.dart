import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random_string/random_string.dart';
import 'package:food/pages/login.dart';
import 'package:food/service/auth.dart';
import 'package:food/service/shared_pref.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? profileUrl, name, email;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  bool _isImagePickerActive = false;

  @override
  void initState() {
    super.initState();
    loadProfileInfo();
  }

  Future<void> loadProfileInfo() async {
    final String? userProfile = await SharedPreferenceHelper().getUserProfile();
    final String? userName = await SharedPreferenceHelper().getUserName();
    final String? userEmail = await SharedPreferenceHelper().getUserEmail();

    setState(() {
      profileUrl = userProfile;
      name = userName;
      email = userEmail;
    });
  }


  Future<void> pickImageFromGallery() async {
    if (_isImagePickerActive) {
      return; // Prevent opening multiple image pickers
    }
    setState(() {
      _isImagePickerActive = true;
    });

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _isImagePickerActive = false;
    });

    if (image != null) {
      selectedImage = File(image.path);
      uploadImage();
    }
  }

  Future<void> uploadImage() async {
    if (selectedImage != null) {
      String imageName = randomAlphaNumeric(10);
      Reference storageReference =
          FirebaseStorage.instance.ref().child('profileImages/$imageName');
      UploadTask uploadTask = storageReference.putFile(selectedImage!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      await SharedPreferenceHelper().saveUserProfile(imageUrl);
      setState(() {
        profileUrl = imageUrl;
      });
    }
  }

  void navigateToSignInScreen() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LogIn()),
      (Route<dynamic> route) => false,
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: name == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue.shade900, Colors.blue.shade500],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: pickImageFromGallery,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                backgroundImage: selectedImage == null
                                    ? (profileUrl == null
                                        ? AssetImage("images/boy.png")
                                        : NetworkImage(profileUrl!))
                                    : FileImage(selectedImage!),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: Icon(Icons.camera_alt,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          name!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          email!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Name'),
                        subtitle: Text(name!),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.email),
                        title: Text('Email'),
                        subtitle: Text(email!),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await AuthMethods().deleteUser();
                          showSnackBar("Deleted account successfully");
                          navigateToSignInScreen();
                        } catch (e) {
                          print('Delete account error: $e');
                          showSnackBar("Failed to delete account");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Delete Account',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: OutlinedButton(
                      onPressed: () async {
                        try {
                          await AuthMethods().signOut();
                          showSnackBar("Logged out successfully");
                          navigateToSignInScreen();
                        } catch (e) {
                          print('Sign out error: $e');
                          showSnackBar("Failed to log out");
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(width: 2, color: Colors.blue),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
