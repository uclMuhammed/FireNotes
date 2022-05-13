// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes/constructer/constructer.dart';
import 'package:fire_notes/screen/note_editor.dart';
import 'package:fire_notes/screen/note_reader.dart';
import 'package:fire_notes/stream/firebase_home_stream.dart';
import 'package:fire_notes/style/app_style.dart';
import 'package:fire_notes/widgets/note_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppStyle.mainColor,
        title: const Text("Fire Notes"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                var collection = FirebaseFirestore.instance.collection('Notes');
                var querySnapshot = await collection.get();
                var idList = [];
                for (var queryDocumentSnapshot in querySnapshot.docs) {
                  Map<String, dynamic> data = queryDocumentSnapshot.data();
                  bool ischecking = data["ischecking"];
                  var id = data["id"];
                  if (ischecking == true) {
                    idList.add(id);
                  }
                  print(idList);
                }
                for (var i = 0; i < idList.length; i++) {
                  FirebaseFirestore.instance
                      .collection("Notes")
                      .doc(idList[i])
                      .delete();
                }
              },
              icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Expanded(
            child: FireBaseStream(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NoteEditorScreen()));
        },
        label: const Text("Add Note"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
