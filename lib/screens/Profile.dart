import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfuneral/common_classes/adList.dart';
import 'package:myfuneral/common_classes/leftList.dart';
import '../common_classes/appBar.dart';
import '../common_classes/drawer.dart';
import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'Claims.dart';

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

  final double breakPoint = 600;
  final double menuWidth = 240;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _fName = TextEditingController();
  final TextEditingController _lName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _policy = TextEditingController();
  final TextEditingController _id = TextEditingController();
  final updateFormKey = GlobalKey<FormState>();
  bool spinnerLoading = false;
  String? selectedUserType = "Consumer";
  String userType = "Consumer";

  String docID = "";
  String newFName = "";
  String newLName = "";
  String newPolicy = "";
  String newEmail = "";
  String newUT = "";
  String newID = "";
  bool processed = false;

  @override
  void initState() {
    ///Test variables
    print(widget.phoneNumber);
    super.initState();
  }

  _validateID() {
    final idCheck = FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: _id)
        .get()
        .then((QuerySnapshot qs) => {
              if (qs.docs.isNotEmpty)
                {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('This ID number is already in use.'),
                  ))
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(
      context,
    ).size.width;
    if (screenWidth >= widget.breakPoint) {
      return SafeArea(
          child: Scaffold(
              appBar: AdaptiveNavBar(
                screenWidth: screenWidth,
                title: const Text('Profile'),
                navBarItems: [
                  NavBarItem(
                    text: 'Home',
                    onTap: () {
                      Navigator.push(
                          context,
                          //GlobalContextService.navigatorKey.currentContext!,
                          MaterialPageRoute(
                              builder: (context) => Home(
                                    uUID: widget.uUID,
                                    fName: widget.fName,
                                    lName: widget.lName,
                                    policy: widget.policy,
                                    phoneNumber: widget.phoneNumber,
                                    email: widget.email,
                                    utValue: widget.utValue,
                                    id: newID,
                                  )));
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
                                children: <Widget>[
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const SizedBox(
                                    height: 55,
                                    width: 300,
                                    child: Text(
                                      'Create your new account',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 55,
                                    width: 300,
                                    child: TextField(
                                      controller: _fName,
                                      autofocus: true,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'First Name',
                                      ),
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 55,
                                    width: 300,
                                    child: TextField(
                                      controller: _lName,
                                      autofocus: true,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Sur/Last Name',
                                      ),
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 55,
                                    width: 300,
                                    child: TextField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _email,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'email',
                                      ),
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 55,
                                    width: 300,
                                    child: TextField(
                                      // TextField(
                                      keyboardType: TextInputType.number,
                                      controller: _policy,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Policy Number',
                                      ),
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 55,
                                    width: 300,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: _id,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'ID Number',
                                      ),
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      validator: _validateID(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        key: updateFormKey,
                                        width: 300,
                                        child: StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection("userType")
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            if (snapshot.hasError) {
                                              print(
                                                  'Layne: No Data Retrieved. ${snapshot.error}');
                                              const snackBarUserType = SnackBar(
                                                content:
                                                    Text('No Data Retrieved'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                      snackBarUserType);
                                            }
                                            if (!snapshot.hasData) {
                                              return const Text('Loading...');
                                            }
                                            // else {
                                            // if (snapshot.hasData) {
                                            final userTypeDatabaseSnapshot =
                                                snapshot.data!.docs;
                                            return DropdownButtonFormField(
                                              decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          10, 5.5, 0, 0),
                                                  border: OutlineInputBorder(),
                                                  labelStyle: TextStyle(),
                                                  labelText: 'User Type'),
                                              value: selectedUserType,
                                              onChanged: (snap) {
                                                setState(() {
                                                  selectedUserType =
                                                      snap.toString();
                                                });
                                                final snackBarUserType =
                                                    SnackBar(
                                                  content: Text(
                                                      'User type selected: $selectedUserType'),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        snackBarUserType);
                                              },
                                              items: userTypeDatabaseSnapshot
                                                  .map((DocumentSnapshot
                                                      document) {
                                                return DropdownMenuItem<String>(
                                                  value:
                                                      document['utDescription'],
                                                  child: Text(document[
                                                      'utDescription']),
                                                );
                                              }).toList(),
                                              isExpanded: true,
                                              isDense: false,
                                              hint: const Text(
                                                  'Select User Type'),
                                            );
                                            // }
                                          },
                                        ),
                                      )),
                                  spinnerLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : const SizedBox(
                                          height: 20.0,
                                        ),
                                  SizedBox(
                                      child: ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        spinnerLoading = true;
                                      });
                                      try {
                                        if (widget.fName == "Not Registered") {
                                          if (processed == false) {
                                            FirebaseFirestore.instance
                                                .collection("users")
                                                .add({
                                              "fName": _fName.text,
                                              "lName": _lName.text,
                                              "email": _email.text,
                                              "policy": _policy.text,
                                              "phone": widget.phoneNumber,
                                              "utValue": selectedUserType,
                                              "uUID": widget.uUID,
                                              "id": _id.text,
                                            });
                                            setState(() {
                                              processed = true;
                                            });
                                          }
                                        }
                                        // Else update existing user
                                        else {
                                          await FirebaseFirestore.instance
                                              .collection("users")
                                              .where("uUID",
                                                  isEqualTo: widget.uUID)
                                              .get()
                                              .then((value) {
                                            for (var element in value.docs) {
                                              docID = element.id;
                                            }
                                          });
                                          await FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(docID)
                                              .update({
                                            "fName": _fName.text,
                                            "lName": _lName.text,
                                            "email": _email.text,
                                            "policy": _policy.text,
                                            "utValue": selectedUserType,
                                            "id": _id.text,
                                          });
                                        }
                                      } on FirebaseException catch (e) {
                                        print(
                                            "Failed with Error: ${e.code} : ${e.message}");
                                      } finally {
                                        setState(() {
                                          spinnerLoading = false;
                                          newFName = _fName.text;
                                          newLName = _lName.text;
                                          newEmail = _email.text;
                                          newPolicy = _policy.text;
                                          newUT = selectedUserType!;
                                          newID = _id.text;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              'Profile for ${_fName.text} ${_lName.text} has been updated'),
                                          backgroundColor: Colors.green,
                                          behavior: SnackBarBehavior.floating,
                                          duration: const Duration(seconds: 5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          margin: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  300,
                                              right: 20,
                                              left: 20),
                                          action: SnackBarAction(
                                            label: 'Continue',
                                            textColor: Colors.white,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Home(
                                                            uUID: widget.uUID,
                                                            fName: newFName,
                                                            lName: newLName,
                                                            email: newEmail,
                                                            policy: newPolicy,
                                                            phoneNumber: widget
                                                                .phoneNumber,
                                                            utValue: newUT,
                                                            id: newID,
                                                          )));
                                            },
                                          ),
                                        ));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home(
                                                      uUID: widget.uUID,
                                                      fName: newFName,
                                                      lName: newLName,
                                                      email: newEmail,
                                                      policy: newPolicy,
                                                      phoneNumber:
                                                          widget.phoneNumber,
                                                      utValue: newUT,
                                                      id: newID,
                                                    )));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.grey.shade900),
                                    child: const Text("Submit"),
                                  )),
                                  const SizedBox(
                                    height: 100,
                                  )
                                ],
                              ),
                            ),
                          ),
                          AdList(
                            uUID: widget.uUID,
                            fName: widget.fName,
                            lName: widget.lName,
                            policy: widget.policy,
                            phoneNumber: widget.phoneNumber,
                            email: widget.email,
                            utValue: widget.utValue,
                            id: widget.id,
                          )
                        ],
                      ),
                    ),
                  ])));
    } else {
      return SafeArea(
          child: Scaffold(
              appBar: myAppBar(title: 'Profile', phoneNumber: widget.policy),
              resizeToAvoidBottomInset: false,
              body: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const SizedBox(
                          height: 30,
                          width: 300,
                          child: Text(
                            'Create/Update your new account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 55,
                          width: 300,
                          child: TextField(
                            controller: _fName,
                            autofocus: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'First Name',
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 55,
                          width: 300,
                          child: TextField(
                            controller: _lName,
                            autofocus: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Sir/Last Name',
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 55,
                          width: 300,
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            controller: _email,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Phone Number',
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 55,
                          width: 300,
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _policy,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 55,
                          width: 300,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _id,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'ID Number',
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                            flex: 1,
                            child: SizedBox(
                              key: updateFormKey,
                              width: 300,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("userType")
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    print(
                                        'Layne: No Data Retrieved. ${snapshot.error}');
                                    const snackBarUserType = SnackBar(
                                      content: Text('No Data Retrieved'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBarUserType);
                                  }
                                  if (!snapshot.hasData) {
                                    return const Text('Loading...');
                                  }
                                  final userTypeDatabaseSnapshot =
                                      snapshot.data!.docs;
                                  return DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(10, 5.5, 0, 0),
                                        border: OutlineInputBorder(),
                                        labelStyle: TextStyle(),
                                        labelText: 'User Type'),
                                    value: selectedUserType,
                                    onChanged: (snap) {
                                      setState(() {
                                        selectedUserType = snap.toString();
                                      });
                                      final snackBarUserType = SnackBar(
                                        content: Text(
                                            'User type selected: $selectedUserType'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBarUserType);
                                    },
                                    items: userTypeDatabaseSnapshot
                                        .map((DocumentSnapshot document) {
                                      return DropdownMenuItem<String>(
                                        value: document['utDescription'],
                                        child: Text(document['utDescription']),
                                      );
                                    }).toList(),
                                    isExpanded: true,
                                    isDense: false,
                                    hint: const Text('Select User Type'),
                                  );
                                  // }
                                },
                              ),
                            )),
                        spinnerLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : const SizedBox(
                                height: 20.0,
                              ),
                        SizedBox(
                            child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              spinnerLoading = true;
                            });
                            try {
                              if (widget.fName == "Not Registered") {
                                if (processed == false) {
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .add({
                                    "fName": _fName.text,
                                    "lName": _lName.text,
                                    "policy": _policy.text,
                                    "phone": widget.phoneNumber,
                                    "email": _policy.text,
                                    "utValue": selectedUserType,
                                    "uUID": widget.uUID,
                                    "id": _id.text,
                                  });
                                  setState(() {
                                    processed = true;
                                  });
                                }
                              }
                              // Else update existing user
                              else {
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .where("uUID", isEqualTo: widget.uUID)
                                    .get()
                                    .then((value) {
                                  for (var element in value.docs) {
                                    docID = element.id;
                                  }
                                });
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(docID)
                                    .update({
                                  "fName": _fName.text,
                                  "lName": _lName.text,
                                  "phone": widget.phoneNumber,
                                  "email": _email.text,
                                  "policy": _policy.text,
                                  "utValue": selectedUserType,
                                  "id": _id.text,
                                });
                              }
                            } on FirebaseException catch (e) {
                              print(
                                  "Failed with Error: ${e.code} : ${e.message}");
                            } finally {
                              setState(() {
                                spinnerLoading = false;
                                newFName = _fName.text;
                                newLName = _lName.text;
                                newPolicy = _policy.text;
                                newEmail = _email.text;
                                newUT = selectedUserType!;
                                newID = _id.text;
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    'Profile for ${_fName.text} ${_lName.text} has been updated'),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(seconds: 5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height -
                                        300,
                                    right: 20,
                                    left: 20),
                                action: SnackBarAction(
                                  label: 'Continue',
                                  textColor: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home(
                                                  uUID: widget.uUID,
                                                  fName: newFName,
                                                  lName: newLName,
                                                  email: newEmail,
                                                  policy: newPolicy,
                                                  phoneNumber:
                                                      widget.phoneNumber,
                                                  utValue: newUT,
                                                  id: newID,
                                                )));
                                  },
                                ),
                              ));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home(
                                            uUID: widget.uUID,
                                            fName: newFName,
                                            lName: newLName,
                                            email: newEmail,
                                            policy: newPolicy,
                                            phoneNumber: widget.phoneNumber,
                                            utValue: newUT,
                                            id: newID,
                                          )));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.grey.shade900),
                          child: const Text("Submit"),
                        )),
                        const SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ]))); //)));
    }
  }
}
