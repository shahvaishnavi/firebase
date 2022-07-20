import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class registerpage extends StatefulWidget {
  const registerpage({Key? key}) : super(key: key);

  @override
  State<registerpage> createState() => _registerpageState();
}

class _registerpageState extends State<registerpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REGISTER"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(30),
            child: TextField(
              controller: number,
              decoration: InputDecoration(
                hintText: "phneno",
                labelText: "ENTER UR NUMBER",
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(30),
            child: TextField(
              controller: OTP,
              decoration: InputDecoration(
                hintText: "ENTER UR CURRENT OTP",
                labelText: "ENTER OTP",
              ),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: '+91${number.text}',
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException e) {},
                  codeSent: (String verificationId, int? resendToken) {
                    setState(() {
                      varid = verificationId;
                    });
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );
              },
              icon: Icon(Icons.phone),
              label: Text("number")),
          ElevatedButton.icon(
              onPressed: () async {
                FirebaseAuth auth = FirebaseAuth.instance;
                String smsCode = '${OTP.text}';
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: varid, smsCode: smsCode);

                // Sign the user in (or link) with the credential
                await auth.signInWithCredential(credential);
              },
              icon: Icon(Icons.message_outlined),
              label: Text("otp")),
        ],
      ),
    );
  }

  String varid = "";
  TextEditingController number = TextEditingController();
  TextEditingController OTP = TextEditingController();
}
