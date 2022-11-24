import 'package:flutter/material.dart';

import '../screens/Claims.dart';

class LeftList extends StatefulWidget {
  final String uUID;
  final String fName;
  final String lName;
  final String policy;
  final String phoneNumber;
  final String email;
  final String utValue;
  final String id;

  const LeftList(
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
  State<LeftList> createState() => _LeftListState();
}

class _LeftListState extends State<LeftList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        color: Colors.blueGrey[50],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTile(
              title: const Text(
                "Side Menu",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home(
                                              uUID: widget.uUID,
                                              fName: widget.fName,
                                              lName: widget.lName,
                                              email: widget.email,
                                              policy: widget.policy,
                                              phoneNumber: widget.phoneNumber,
                                              utValue: widget.utValue,
                                              id: widget.id,
                                            )));
                              },
                              style: const ButtonStyle(
                                alignment: Alignment.topLeft,
                              ),
                              child: const Text('Home',
                                  style: TextStyle(color: Colors.black))),
                        ],
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  condLeftLayout() {
    if (widget.utValue == "Consumer") {}
  }
}
