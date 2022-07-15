import 'package:firebase/registerpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MaterialApp(
    home: frbase(),
  ));
}

class frbase extends StatefulWidget {
  const frbase({Key? key}) : super(key: key);

  @override
  State<frbase> createState() => _frbaseState();
}

class _frbaseState extends State<frbase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WELCOME TO MY APP"), centerTitle: true),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(30),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                  labelText: "ENTER UR EMAIL", hintText: "ENTER EMAIL"),
            ),
          ),
          Container(
            margin: EdgeInsets.all(30),
            child: TextField(
              controller: password,
              decoration: InputDecoration(
                  labelText: "ENTER UR PASSWORD", hintText: "ENTER PASSWORD"),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email.text,
                    password: password.text,
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }

                Fluttertoast.showToast(
                    msg: "login",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);

                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return registerpage();
                  },
                ));
              },
              child: Center(
                  child: Text(
                "REGISTER",
              )))
        ],
      ),
    );
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
}
