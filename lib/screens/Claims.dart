import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../common_classes/appBar.dart';
import '../common_classes/drawer.dart';
import 'LoginScreen.dart';

import '../main.dart';

class Home extends StatefulWidget {
  final String uUID;
  final String fName;
  final String lName;
  final String policy;
  final String phoneNumber;
  final String email;
  final String utValue;
  final String id;
  const Home({
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

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(GlobalContextService.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(title: 'Home', phoneNumber: widget.policy),
        drawer: MainDrawer(
          uUID: widget.uUID,
          fName: widget.fName,
          lName: widget.lName,
          policy: widget.policy,
          phoneNumber: widget.phoneNumber,
          email: widget.email,
          utValue: widget.utValue,
          id: widget.id,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/hand_with_phone_127px.png',
                height: 100,
                width: 100,
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Text(
                'My Funeral Policies',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Text(
                'Welcome',
                style: TextStyle(fontSize: 22.0),
              ),
              const SizedBox(
                height: 40.0,
              ),
              ElevatedButton(onPressed: _signOut, child: const Text('Sign Out'))
            ],
          ),
        ),
      ),
    );
  }
}
