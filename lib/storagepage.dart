import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';

class storagepage extends StatefulWidget {
  const storagepage({Key? key}) : super(key: key);

  @override
  State<storagepage> createState() => _storagepageState();
}

class _storagepageState extends State<storagepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("image upload"))),
      body: Column(
        children: [
          InkWell(
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              // Pick an image
              final XFile? image =
                  await _picker.pickImage(source: ImageSource.gallery);
              myimage = image!.path;
            },
            child: Container(
              child: CircleAvatar(backgroundImage: FileImage(File(myimage))),
            ),
          ),
          Container(
            child: TextField(
              controller: name,
              decoration: InputDecoration(labelText: "ENTER UR NAME"),
            ),
          ),
          Container(
            child: TextField(
              controller: age,
              decoration: InputDecoration(labelText: "ENTER UR AGE"),
            ),
          ),
          Container(
            child: TextField(
              controller: dob,
              decoration: InputDecoration(labelText: "ENTER UR DOB"),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                final storageRef = FirebaseStorage.instance.ref();
                String name = "Images${Random().nextInt(1000)}.jpg";
                final spaceRef = storageRef.child("CREATIVE/$name");

                try {
                  spaceRef.putFile(File(myimage));
                  spaceRef.getDownloadURL().then((value) async {
                    print(value);

                    DatabaseReference ref =
                        FirebaseDatabase.instance.ref("CREATIVE").push();
                    String? id = ref.key;
                    await ref.set({
                      "id": id,
                      "name": "John",
                      "age": 18,
                      "address": {"line1": "100 Mountain View"}
                    });
                  });
                } catch (e) {
                  print(e);
                } finally {}
              },
              child: Text("SUBMIT"))
        ],
      ),
    );
  }

  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController dob = TextEditingController();

  String myimage = "";
}
