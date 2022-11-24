import 'package:flutter/material.dart';
import '../common_classes/appBar.dart';
import '../common_classes/drawer.dart';

class Profile extends StatefulWidget {
  final String uUID;
  final String fName;
  final String lName;
  final String policy;
  final String phoneNumber;
  final String email;
  final String utValue;
  final String id;

  const Profile({
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
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: myAppBar(title: 'Profile', phoneNumber: widget.policy),
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
      body: Container(
        color: Colors.amber,
        child: Container(
          color: Colors.grey,
          padding: const EdgeInsets.all(15),
        ),
      ),
    ));
  }
}
