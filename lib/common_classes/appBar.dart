import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main.dart';

import '../screens/LoginScreen.dart';

class MyAppBar extends StatefulWidget {
  final String title;
  final String phoneNumber;

  const MyAppBar({Key? key, required this.title, required this.phoneNumber})
      : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  profile({required String phoneNumber, required String title}) {
    // myAppBar(title: title, phoneNumber: phoneNumber);
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(GlobalContextService.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    // var screenSize = MediaQuery.of(context).size;
    return AppBar(
      title: Text(widget.title),
      backgroundColor: Colors.blue,
      actions: <Widget>[
        IconButton(
            onPressed: () {
              signOut();
            },
            icon: const Icon(Icons.logout_sharp)),
      ],
    );
  }
}

AppBar myAppBar({required String title, required String phoneNumber}) {
  return AppBar(
    title: Text(title),
    backgroundColor: Colors.blue,
    actions: <Widget>[
      IconButton(
          onPressed: () => {
                Navigator.of(
                  GlobalContextService.navigatorKey.currentContext!,
                ).pop(),
              },
          icon: const Icon(Icons.arrow_back_sharp)),
    ],
  );
}
