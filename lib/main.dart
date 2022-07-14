import 'package:flutter/material.dart';

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
        ],
      ),
    );
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
}
