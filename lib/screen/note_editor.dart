import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes/constructer/constructer.dart';
import 'package:fire_notes/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import 'home_screen.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController tileController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
            size: 25,
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
                  controller: tileController,
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
                  keyboardType: TextInputType.name,
                  controller: passwordController,
                  obscureText: true,
                  maxLength: 16,
                  decoration:
                      textFormFieldDecoration(colorId, "", "Note Password"),
                  style: AppStyle.mainContetnt,
                  validator: (val) {
                    if (val!.isNotEmpty && val.length < 6) {
                      return 'Your password must be 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: contentController,
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
                note_tile: tileController.text,
                note_content: contentController.text,
                password: passwordController.text,
                color_id: colorId,
                creation_date: dates.toString(),
                favorite: favorite);
            createNote(note);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TabBarHomeScreen()));
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

  OutlineInputBorder textFormFieldBorderStyle(int colorId) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
      borderSide: BorderSide(color: AppStyle.contentColors[colorId]),
    );
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
}
