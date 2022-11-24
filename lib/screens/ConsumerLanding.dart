import 'dart:html';

import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myfuneral/common_classes/leftList.dart';
import 'package:myfuneral/screens/LoginScreen.dart';

class ConsumerLandingScreen extends StatefulWidget {
  final String uUID;
  final String fName;
  final String lName;
  final String policy;
  final String phoneNumber;
  final String email;
  final String utValue;
  final String id;
  const ConsumerLandingScreen({
    Key? key,
    required this.uUID,
    required this.fName,
    required this.lName,
    required this.policy,
    required this.phoneNumber,
    required this.email,
    required this.utValue,
    required this.id,
  }) : super(key: key);

  final double breakPoint = 600;
  final double menuWidth = 240;

  @override
  State<ConsumerLandingScreen> createState() => _ConsumerLandingScreenState();
}

class _ConsumerLandingScreenState extends State<ConsumerLandingScreen> {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(
      context,
    ).size.width;

    ///////Testing of handover of variables
    print("Landing: ${widget.uUID}");
    print("Landing: ${widget.fName}");
    print("Landing: ${widget.lName}");
    print("Landing: ${widget.policy}");
    print("Landing: ${widget.phoneNumber}");
    print("Landing: ${widget.email}");
    print("Landing: ${widget.utValue}");
    print("Landing: ${widget.id}");
    ///////

    if (screenWidth >= widget.breakPoint) {
      return SafeArea(
          child: Scaffold(
        appBar: AdaptiveNavBar(
          screenWidth: screenWidth,
          title: const Text('Home'),
          navBarItems: [
            NavBarItem(
              text: 'Logout',
              onTap: () {
                _signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    LeftList(
                        uUID: widget.uUID,
                        fName: widget.fName,
                        lName: widget.lName,
                        policy: widget.policy,
                        phoneNumber: widget.phoneNumber,
                        email: widget.email,
                        utValue: widget.utValue,
                        id: widget.id),
                    Expanded(
                        flex: 6,
                        child: Container(
                          color: Colors.grey[50],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const <Widget>[
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 55,
                                width: 300,
                                child: Text(
                                  'Navigation',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ))
          ],
        ),
      ));
    } else {
      return const Scaffold();
    }
  }
}
