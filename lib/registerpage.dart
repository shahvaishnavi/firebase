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
        ],
      ),
    );
  }

  TextEditingController number = TextEditingController();
  TextEditingController OTP = TextEditingController();
}
