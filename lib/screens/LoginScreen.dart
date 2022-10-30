// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:myfuneral/screens/Home.dart';

import '../main.dart';
import 'Home.dart';
import 'Profile.dart';

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
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  late String verificationIDFromFirebase;
  bool spinnerLoading = false;
  bool profileExists = false;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  _verifyPhoneButton() async {
    setState(() {
      spinnerLoading = true;
    });
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneController.text,
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
    await FirebaseFirestore.instance.collection("users")
        .where("phone", isEqualTo: phoneController.text)
        .get()
        .then((value) => {
      if(value.size > 0) {
        profileExists = true,
      }});

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
    try {
      final authCredential =
      await _firebaseAuth.signInWithCredential(phoneAuthCredential);
      setState(() {
        spinnerLoading = false;
      });
      if (authCredential.user != null) {

        if(profileExists) {
          Navigator.push(
              GlobalContextService.navigatorKey.currentContext!,
              MaterialPageRoute(builder: (context) => Profile(phoneNumber: phoneController.text)));
        } else {
          Navigator.push(
              GlobalContextService.navigatorKey.currentContext!,
              MaterialPageRoute(builder: (context) => Home(phoneNumber: phoneController.text)));
        }
      } else {
        // Navigator.push(
        //     GlobalContextService.navigatorKey.currentContext!,
        //     MaterialPageRoute(builder: (context) => Home(phoneNumber: phoneController.text)));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        spinnerLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  getPhoneFormWidget(context) {
    return Column(
      children: [
        const Text(
          "Enter your mobile number",
          style: TextStyle(fontSize: 16.0),
        ),
        const Text(
          'Use country code and remove leading zero (e.g. (082) 853-6652 =  +27828536652)',
          style: (TextStyle(fontSize: 12.0)),
        ),
        const SizedBox(
          height: 40.0,
        ),
        SizedBox(
          width: 200.0,
          child: TextField(
            keyboardType: TextInputType.phone,
            maxLength: 12,
            //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: phoneController,
            textAlign: TextAlign.start,
            decoration: const InputDecoration(
                hintText: "Phone Number",
                prefixIcon: Icon(Icons.phone_android_rounded)),
          ),
        ),

        const SizedBox(
          height: 20.0,
        ),
        ElevatedButton(
            onPressed: () => _verifyPhoneButton(),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.grey.shade900, // foreground
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
          controller: otpController,
          textAlign: TextAlign.start,
          decoration: const InputDecoration(
              hintText: "OTP Number",
              prefixIcon: Icon(Icons.confirmation_number_rounded)),
        ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        ElevatedButton(
          onPressed: () => _verifyOTPButton(),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.grey.shade900, // foreground
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
                        "My Funeral Policies Login",
                        style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Image(image: AssetImage(
                            'assets/images/myfunerallogo.jpeg'),
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