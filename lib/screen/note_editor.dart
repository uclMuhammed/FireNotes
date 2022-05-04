import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes/style/app_style.dart';
import 'package:flutter/material.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  String date = DateTime.now().toString();
  TextEditingController _tileController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    int color_id = Random().nextInt(AppStyle.cardColors.length);
    return Scaffold(
      backgroundColor: AppStyle.cardColors[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardColors[color_id],
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Add a new note"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _tileController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Tile',
              ),
              style: AppStyle.mainTile,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              date,
              style: AppStyle.dateTile,
            ),
            SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLength: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Content',
              ),
              style: AppStyle.mainContetnt,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: (() {
          FirebaseFirestore.instance.collection("Notes").add({
            "note_tile":_tileController.text,
            "creation_date":date,
            "note_content":_mainController.text,
            "color_id":color_id
          }).then((value) {
            print(value.id);
             Navigator.pop(context);
             }).catchError((error)=>print("Failed to add new Note due to $error"));
        }),
        child: Icon(Icons.save),
      ),
    );
  }
}
