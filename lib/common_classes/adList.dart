import 'package:flutter/material.dart';

class AdList extends StatefulWidget {
  final String uUID;
  final String fName;
  final String lName;
  final String policy;
  final String phoneNumber;
  final String email;
  final String utValue;
  final String id;

  const AdList(
      {Key? key,
      required this.uUID,
      required this.fName,
      required this.lName,
      required this.policy,
      required this.phoneNumber,
      required this.email,
      required this.utValue,
      required this.id})
      : super(key: key);

  @override
  State<AdList> createState() => _AdListState();
}

class _AdListState extends State<AdList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Container(
          color: Colors.blueGrey[50],
        ));
  }
}
