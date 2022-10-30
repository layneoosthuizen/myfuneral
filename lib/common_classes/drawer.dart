import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

import '../screens/Profile.dart';

class MainDrawer extends StatefulWidget {
  final String phoneNumber;

  const MainDrawer({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final uid = user?.uid;
String name = "";
String email = "";
String phone = "";
String userType = "";
String utValue = "";

var map = {};

class _MainDrawerState extends State<MainDrawer> {
  void getUserDetails() async {
    FirebaseFirestore.instance
        .collection("users")
        .where("phone", isEqualTo: widget.phoneNumber)
        .get()
        .then((QuerySnapshot qs) => {
              if (qs.docs.isNotEmpty)
                {
                  map = qs.docs.first.data() as Map,
                  setState(() {
                    name = map["name"];
                    phone = map["phone"];
                    email = map["email"];
                    userType = map["userType"];
                    utValue = map["utValue"];
                  })
                }
            });
  }

  @override
  @protected
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.lightBlue,
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Phone: $phone",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontStyle: FontStyle.normal),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Email: $email",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontStyle: FontStyle.normal),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "User Type: $utValue",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontStyle: FontStyle.normal),
                    ),
                  ],
                )
              ],
            ),
          ),
          ExpansionTile(
            title: const Text('Personal'),
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Profile(phoneNumber: widget.phoneNumber)));
                  },
                  style: const ButtonStyle(
                    alignment: Alignment.topLeft,
                  ),
                  child: const Text('Profile')),
            ],
          ),
          conditionalLayout(),
        ],
      ),
    );
  }

  conditionalLayout() {
    if (userType == "1") {
      return ExpansionTile(
        title: const Text("My Policies"),
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Profile(phoneNumber: widget.phoneNumber)));
              },
              style: const ButtonStyle(
                alignment: Alignment.topLeft,
              ),
              child: const Text('Profile')),
        ],
      );
    } else if (userType == "2") {
      return ExpansionTile(
        title: const Text("Funeral Services"),
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Profile(phoneNumber: widget.phoneNumber)));
              },
              style: const ButtonStyle(
                alignment: Alignment.centerLeft,
              ),
              child: const Text('Profile')),
        ],
      );
    } else if (userType == "3") {
      return ExpansionTile(
        title: const Text("Agent Services"),
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Profile(phoneNumber: widget.phoneNumber)));
              },
              style: const ButtonStyle(
                alignment: Alignment.centerLeft,
              ),
              child: const Text('Profile')),
        ],
      );
    } else if (userType == "4") {
      return ExpansionTile(
        title: const Text("FSP Services"),
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Profile(phoneNumber: widget.phoneNumber)));
              },
              style: const ButtonStyle(
                alignment: Alignment.centerLeft,
              ),
              child: const Text('Profile')),
        ],
      );
    } else if (userType == "5") {
      return ExpansionTile(
        title: const Text("Insurer"),
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Profile(phoneNumber: widget.phoneNumber)));
              },
              style: const ButtonStyle(
                alignment: Alignment.centerLeft,
              ),
              child: const Text('Profile')),
        ],
      );
    }
  }
}
