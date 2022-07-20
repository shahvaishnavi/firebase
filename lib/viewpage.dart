import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class viewpage extends StatefulWidget {
  const viewpage({Key? key}) : super(key: key);

  @override
  State<viewpage> createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {
  List vv = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataevent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  Future<void> dataevent() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("CREATIVE");
    DatabaseEvent de = await ref.once();
    Map map = de.snapshot.value as Map;
    Map().forEach((key, value) {
      print("===k==${key}");
      print("===v==${value}");
      vv.add(value);
    });
  }
}
