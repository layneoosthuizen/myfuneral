import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myfuneral/common_classes/appBar.dart';
import 'package:myfuneral/common_classes/drawer.dart';
import 'package:myfuneral/screens/LoginScreen.dart';

import '../main.dart';


class Home extends StatefulWidget {
  final String phoneNumber;
  const Home({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        GlobalContextService.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => const LoginScreen()));
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(title: 'Home', phoneNumber: widget.phoneNumber),
        drawer: MainDrawer(phoneNumber: widget.phoneNumber,),
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
                ElevatedButton(
                  onPressed: _signOut, 
                  child: const Text('Sign Out'))
            ],
          ),
        ), 
      ),
    );
  }
}



