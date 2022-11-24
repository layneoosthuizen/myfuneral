import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/Profile.dart';

class MainDrawer extends StatefulWidget {
  final String uUID;
  final String fName;
  final String lName;
  final String policy;
  final String phoneNumber;
  final String email;
  final String utValue;
  final String id;

  const MainDrawer(
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
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  @protected
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Drawer(
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
                      "${widget.fName} ${widget.lName}",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Phone: ${widget.policy}",
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
                      "Email: ${widget.email}",
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
                      "User Type: ${widget.utValue}",
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            GlobalContextService.navigatorKey.currentContext!,
                            MaterialPageRoute(
                                builder: (context) => Profile(
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
                      child: const Text('Profile')),
                ],
              )
            ],
          ),
          conditionalLayout(),
        ],
      ),
    ));
  }

  conditionalLayout() {
    if (widget.utValue == "Consumer") {
      return ExpansionTile(
        title: const Text("My Stuff"),
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    GlobalContextService.navigatorKey.currentContext!,
                    MaterialPageRoute(
                        builder: (context) => Profile(
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
              child: const Text(
                'Profile',
              )),
          TextButton(
              onPressed: () {
                Navigator.push(
                    GlobalContextService.navigatorKey.currentContext!,
                    MaterialPageRoute(
                        builder: (context) => Profile(
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
              child: const Text(
                'Link Policies',
              )),
          TextButton(
              onPressed: () {
                Navigator.push(
                    GlobalContextService.navigatorKey.currentContext!,
                    MaterialPageRoute(
                        builder: (context) => Profile(
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
              child: const Text(
                'View/Update My Policies',
              )),
          TextButton(
              onPressed: () {
                Navigator.push(
                    GlobalContextService.navigatorKey.currentContext!,
                    MaterialPageRoute(
                        builder: (context) => Profile(
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
              child: const Text(
                'Pay My Policies',
              )),
          TextButton(
              onPressed: () {
                Navigator.push(
                    GlobalContextService.navigatorKey.currentContext!,
                    MaterialPageRoute(
                        builder: (context) => Profile(
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
              child: const Text(
                'Log a Claim',
              )),
          TextButton(
              onPressed: () {
                Navigator.push(
                    GlobalContextService.navigatorKey.currentContext!,
                    MaterialPageRoute(
                        builder: (context) => Profile(
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
              child: const Text(
                'Check Status of Existing Claim',
              )),
          TextButton(
              onPressed: () {
                Navigator.push(
                    GlobalContextService.navigatorKey.currentContext!,
                    MaterialPageRoute(
                        builder: (context) => Profile(
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
              child: const Text(
                'Buy a New Policy',
              )),
          TextButton(
              onPressed: () {
                Navigator.push(
                    GlobalContextService.navigatorKey.currentContext!,
                    MaterialPageRoute(
                        builder: (context) => Profile(
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
              child: const Text(
                'Add/Change Beneficiaries',
              )),
          TextButton(
              onPressed: () {
                Navigator.push(
                    GlobalContextService.navigatorKey.currentContext!,
                    MaterialPageRoute(
                        builder: (context) => Profile(
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
              child: const Text(
                'Confirm Death of Family Member',
              )),
        ],
      );
    } else if (widget.utValue == "Agent") {
      return ExpansionTile(
        title: const Text("Funeral Services"),
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    GlobalContextService.navigatorKey.currentContext!,
                    MaterialPageRoute(
                        builder: (context) => Profile(
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
                alignment: Alignment.centerLeft,
              ),
              child: const Text('Profile')),
        ],
      );
    } else if (widget.utValue == "FSP") {
      return ExpansionTile(
        title: const Text("Agent Services"),
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    GlobalContextService.navigatorKey.currentContext!,
                    MaterialPageRoute(
                        builder: (context) => Profile(
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
                alignment: Alignment.centerLeft,
              ),
              child: const Text('Profile')),
        ],
      );
    } else if (widget.utValue == "Insurer") {
      return ExpansionTile(
        title: const Text("FSP Services"),
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        GlobalContextService.navigatorKey.currentContext!,
                        MaterialPageRoute(
                            builder: (context) => Profile(
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
                    alignment: Alignment.centerLeft,
                  ),
                  child: const Text('Profile')),
            ],
          )
        ],
      );
    }
  }
}
