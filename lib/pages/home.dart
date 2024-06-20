import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/pages/details.dart';
import 'package:food/service/database.dart';
import 'package:food/service/shared_pref.dart';
import 'package:food/widgets/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false, milktea = false, burger = false, chicken = false;
  Stream? fooditemStream;
  String userName = "";

  ontheload() async {
    fooditemStream = await DatabaseMethods().getFoodItem("Ice-Cream");
    setState(() {});
  }

  void loadUserName() async {
    String? name = await SharedPreferenceHelper().getUserName();
    if (name != null && name.isNotEmpty) {
      setState(() {
        userName = name;
      });
    }
  }

  @override
  void initState() {
    loadUserName();

    ontheload();
    super.initState();
  }

  Widget allItemsVertically() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(
                                      detail: ds["Detail"],
                                      name: ds["Name"],
                                      price: ds["Price"],
                                      image: ds["Image"],
                                    )));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            right: 10.0, bottom: 30.0, left: 10.0),
                        child: Material(
                          elevation: 9.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    ds["Image"],
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ds["Name"],
                                        style:
                                            AppWidget.semiBooldTextFeildStyle(),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        "Honey good cheese",
                                        style: AppWidget.LightTextFeildStyle(),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        "\$" + ds["Price"],
                                        style:
                                            AppWidget.semiBooldTextFeildStyle(),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator();
        });
  }

  Widget allItems() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(
                                      detail: ds["Detail"],
                                      name: ds["Name"],
                                      price: ds["Price"],
                                      image: ds["Image"],
                                    )));
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(ds["Image"],
                                      width: 190,
                                      height: 150,
                                      fit: BoxFit.cover),
                                ),
                                Text(
                                  ds["Name"],
                                  style: AppWidget.semiBooldTextFeildStyle(),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Fresh and Healthy",
                                  style: AppWidget.LightTextFeildStyle(),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "\$" + ds["Price"],
                                  style: AppWidget.semiBooldTextFeildStyle(),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Welcome $userName,',
                      style: AppWidget.boldTextFeildStyle()),
                  Container(
                    margin: EdgeInsets.only(right: 20.0),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Text("Food Ngon", style: AppWidget.HeadlineTextFeildStyle()),
              Text("Spice things up and discover ",
                  style: AppWidget.LightTextFeildStyle()),
              SizedBox(height: 20.0),
              Container(
                  margin: EdgeInsets.only(right: 20.0), child: showItem()),
              SizedBox(
                height: 30.0,
              ),
              Container(height: 290, child: allItems()),
              SizedBox(
                height: 30.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  // Wrap content in a Column
                  children: [
                    // Add another container with similar structure here if needed
                    allItemsVertically(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            icecream = true;
            milktea = false;
            burger = false;
            chicken = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Ice-cream");

            setState(() {});
          },
          child: Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                  color: icecream
                      ? const Color.fromARGB(255, 190, 87, 98)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Image.asset(
                "images/ice-cream.png",
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            icecream = false;
            milktea = true;
            burger = false;
            chicken = false;
            fooditemStream = await DatabaseMethods().getFoodItem("MilkTea");

            setState(() {});
          },
          child: Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                  color: milktea
                      ? const Color.fromARGB(255, 190, 87, 98)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Image.asset(
                "images/bubble-tea.png",
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            icecream = false;
            milktea = false;
            burger = true;
            chicken = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Taco");
            setState(() {});
          },
          child: Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                  color: burger
                      ? const Color.fromARGB(255, 190, 87, 98)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Image.asset(
                "images/burger.png",
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            icecream = false;
            milktea = false;
            burger = false;
            chicken = true;
            fooditemStream = await DatabaseMethods().getFoodItem("Chicken");

            setState(() {});
          },
          child: Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                  color: chicken
                      ? const Color.fromARGB(255, 190, 87, 98)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Image.asset(
                "images/chicken.png",
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
