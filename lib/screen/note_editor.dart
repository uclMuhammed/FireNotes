import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes/constructer/constructer.dart';
import 'package:fire_notes/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _tileController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool favorite = false;

  String daet = DateTime.now().toString();
  get dates => daet.replaceRange(16, null, "");

  validator(String value) {
    if (value.isEmpty) {
      return "Please enter some note content!";
    }
    return null;
  }

  int colorId = Random().nextInt(AppStyle.cardColors.length);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardColors[colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardColors[colorId],
        elevation: 0,
        actions: [
          LikeButton(
            size: 30,
            onTap: (value) async {
              favorite = !favorite;

              return favorite;
            },
          ),
        ],
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Add A New Note",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _tileController,
                  maxLength: 100,
                  decoration:
                      textFormFieldDecoration(colorId, "", "Note Title"),
                  style: AppStyle.mainTile,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter some note tile!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  dates,
                  style: AppStyle.dateTile,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _contentController,
                  keyboardType: TextInputType.multiline,
                  maxLength: 5000,
                  decoration:
                      textFormFieldDecoration(colorId, "", "Note Content"),
                  style: AppStyle.mainContetnt,
                  maxLines: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter some note content!";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: (() {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Progressing Data"),
              ),
            );
            final note = Note(
                ischecking: false,
                note_tile: _tileController.text,
                note_content: _contentController.text,
                color_id: colorId,
                creation_date: dates.toString(),
                favorite: favorite);
            createNote(note);

            Navigator.pop(context);
          }
        }),
        child: const Icon(Icons.save),
      ),
    );
  }

  Future createNote(Note note) async {
    final docNote = FirebaseFirestore.instance.collection("Notes").doc(daet);
    note.id = daet;
    final json = note.toJson();
    await docNote.set(json);
  }

  InputDecoration textFormFieldDecoration(
      int colorId, String hint, String label) {
    return InputDecoration(
      hintText: hint,
      labelText: label,
      fillColor: AppStyle.contentColors[colorId],
      filled: true,
      enabledBorder: textFormFieldBorderStyle(colorId),
      disabledBorder: textFormFieldBorderStyle(colorId),
      border: textFormFieldBorderStyle(colorId),
      focusedBorder: textFormFieldBorderStyle(colorId),
    );
  }

  OutlineInputBorder textFormFieldBorderStyle(int colorId) {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
      // borderSide: BorderSide(color: AppStyle.contentColors[colorId]),
    );
  }
}
