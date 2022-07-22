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
  Key? snapshot;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataevent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${vv[index]}"),
            trailing: PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text("delete"),
                    onTap: () async {
                      Stream<DatabaseEvent> ref = await FirebaseDatabase
                          .instance
                          .ref("CREATIVE")
                          .onChildRemoved;
                    },
                  )
                ];
              },
            ),
          );
        },
      ),
    );

    //   PopupMenuItem(
    //     child: Text("delete"),
    //     onTap: () async {
    //       Stream<DatabaseEvent> ref =
    //       await FirebaseDatabase.instance.ref("CREATIVE").onChildRemoved;
    //     },
    //   )
    // ];);
  }

  Future<void> dataevent() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("CREATIVE");
    DatabaseEvent de = await ref.once();
    Map map = de.snapshot.value as Map;
    map.forEach((key, value) {
      print("===k==${key}");
      print("===v==${value}");
      vv.add(value);
    });
    print("====id==${vv[0]}");
    print("====msg==${de.snapshot.value}");
  }
}
