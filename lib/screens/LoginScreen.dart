import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'ConsumerLanding.dart';
import 'Profile.dart';

// ignore: constant_identifier_names
enum PhoneVerificationState { SHOW_PHONE_FORM_STATE, SHOW_OTP_FORM_STATE }

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKeyForSnackBar = GlobalKey();
  PhoneVerificationState currentState =
      PhoneVerificationState.SHOW_PHONE_FORM_STATE;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  late String verificationIDFromFirebase;
  bool spinnerLoading = false;
  bool profileExists = false;
  String capturedPhone = "111";
  String id = 'Not Found';
  String uUID = "Not Found";
  String docID = "Not Found";
  String name = "Not Registered";
  String fName = "Not Registered";
  String lName = "Not Registered";
  String email = "Not Found";
  String policy = "Not Found";
  String phoneNumber = "Not Found";
  String userType = "Not Found";
  String utValue = "Not Found";

  var map = {};

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _verifyPhoneButton() async {
    setState(() {
      spinnerLoading = true;
      capturedPhone = _phoneController.text;
    });
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: _phoneController.text,
        verificationCompleted: (phoneAuthCredential) async {
          setState(() {
            spinnerLoading = false;
          });
          signInWithPhoneAuthCredential(phoneAuthCredential);
        },
        verificationFailed: (verificationFailed) async {
          setState(() {
            spinnerLoading = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  "Verification Code Failed: ${verificationFailed.message}")));
        },
        codeSent: (verificationId, resendingToken) async {
          setState(() {
            spinnerLoading = false;
            currentState = PhoneVerificationState.SHOW_OTP_FORM_STATE;
            verificationIDFromFirebase = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) async {});
  }

  _verifyOTPButton() async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationIDFromFirebase,
        smsCode: otpController.text);
    signInWithPhoneAuthCredential(phoneAuthCredential);
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      spinnerLoading = true;
    });
    //Check if user has a profile
    getUserDetails();
    // await getUserDetails();
    try {
      final authCredential =
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
      setState(() {
        spinnerLoading = false;
        uUID = authCredential.user!.uid;
      });
      if (authCredential.user != null) {
        if (profileExists == true) {
          Navigator.push(
              GlobalContextService.navigatorKey.currentContext!,
              MaterialPageRoute(
                  builder: (context) => ConsumerLandingScreen(
                        uUID: uUID,
                        fName: fName,
                        lName: lName,
                        email: email,
                        policy: policy,
                        phoneNumber: capturedPhone,
                        utValue: utValue,
                        id: id,
                      )));
        } else {
          Navigator.push(
              GlobalContextService.navigatorKey.currentContext!,
              MaterialPageRoute(
                  builder: (context) => Profile(
                        uUID: uUID,
                        fName: fName,
                        lName: lName,
                        email: email,
                        policy: policy,
                        phoneNumber: capturedPhone,
                        utValue: utValue,
                        id: id,
                      )));
        }
      } else {}
    } on FirebaseAuthException catch (e) {
      setState(() {
        spinnerLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  getUserDetails() {
    setState(() {
      capturedPhone = _phoneController.text;
    });
    FirebaseFirestore.instance
        .collection("users")
        .where("phone", isEqualTo: capturedPhone)
        .get()
        .then((QuerySnapshot qs) => {
              if (qs.docs.isNotEmpty)
                {
                  map = qs.docs.first.data() as Map,
                  setState(() {
                    profileExists = true;
                    fName = map["fName"];
                    lName = map["lName"];
                    policy = map["policy"];
                    email = map["email"];
                    utValue = map["utValue"];
                  }),
                }
            });
  }

  getPhoneFormWidget(context) {
    return Column(
      children: [
        const Text(
          "Enter your mobile number",
          style: TextStyle(fontSize: 16.0),
        ),
        const Text(
          'Use country code and remove leading zero \n (e.g. (082) 853-6652 =  +27828536652)',
          style: (TextStyle(fontSize: 12.0)),
        ),
        const SizedBox(
          height: 40.0,
        ),
        SizedBox(
          width: 200.0,
          child: TextField(
            autofocus: true,
            keyboardType: TextInputType.phone,
            maxLength: 12,
            controller: _phoneController,
            textAlign: TextAlign.start,
            decoration: const InputDecoration(
                hintText: "Phone Number",
                border: OutlineInputBorder(),
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone_android_rounded)),
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        ElevatedButton(
            onPressed: () => _verifyPhoneButton(),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.grey.shade900, // foreground
            ),
            child: const Text("Verify Phone Number")),
      ],
    );
  }

  getOTPFormWidget(context) {
    return Column(
      children: [
        const Text(
          "Enter OTP Number",
          style: TextStyle(fontSize: 16.0),
        ),
        const SizedBox(
          height: 40.0,
        ),
        SizedBox(
          width: 200.0,
          child: TextField(
            autofocus: true,
            keyboardType: TextInputType.number,
            controller: otpController,
            textAlign: TextAlign.start,
            decoration: const InputDecoration(
                hintText: "OTP Number",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.confirmation_number_rounded)),
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        ElevatedButton(
          onPressed: () => _verifyOTPButton(),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey.shade900, // foreground
          ),
          child: const Text("Verify OTP Number"),
        ),
        const SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: 200.0,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                  context, //GlobalContextService.navigatorKey.currentContext!,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: const Text("Resend OTP"),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKeyForSnackBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Text(
                    "unLabled Login",
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Image(
                          image: AssetImage('assets/images/myfunerallogo.jpeg'),
                          // 'assets/images/hand_with_phone_127px.png'),
                          fit: BoxFit.fitWidth),
                      //   scale: 2,
                      // Image(image: AssetImage(
                      //     'assets/images/verified_127px.png'),
                      //     fit: BoxFit.fitWidth),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 40.0,
              ),
              spinnerLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : currentState == PhoneVerificationState.SHOW_PHONE_FORM_STATE
                      ? getPhoneFormWidget(context)
                      : getOTPFormWidget(context),
            ],
          ),
        ),
      ),
    ));
  }
}
