import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return await auth.currentUser;
  }

  Future<void> deleteUser() async {
    try {
      await auth.currentUser!.delete(); // Delete the currently logged-in user
    } catch (e) {
      print('Delete account error: $e');
      // Handle error gracefully, e.g., show error message
      throw e; // Optionally re-throw or handle the error further
    }
  }

  // Add other authentication methods like signOut() if not already implemented
  Future<void> signOut() async {
    try {
      await auth.signOut(); // Sign out the currently logged-in user
    } catch (e) {
      print('Sign out error: $e');
      // Handle error gracefully, e.g., show error message
      throw e; // Optionally re-throw or handle the error further
    }
  }
}
