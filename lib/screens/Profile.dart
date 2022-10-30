import 'package:flutter/material.dart';
import 'package:myfuneral/common_classes/appBar.dart';
import 'package:myfuneral/common_classes/drawer.dart';


class Profile extends StatefulWidget {
  final String phoneNumber;
  const Profile({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: myAppBar(title: 'Profile', phoneNumber: widget.phoneNumber),
          drawer: MainDrawer(phoneNumber: widget.phoneNumber,),
          body: Container(
            color: Colors.amber,
            child: Container(
              color: Colors.grey,
              padding: const EdgeInsets.all(15),
            ),
          ),
        )
    );
  }
}
