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
  final _formKey = GlobalKey<FormState>();

  TextEditingController _tileController = TextEditingController();
  TextEditingController _mainController = TextEditingController();

  String daet = DateTime.now().toString();
  get date => daet.replaceRange(16, null, "");

  validator(String value) {
    if (value == null || value.isEmpty) {
      return "Please enter some note content!";
    }
    return null;
  }

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
        title: Text(
          "Add A New Note",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _tileController,
                decoration: textFormFieldDecoration(color_id, "", "Note Title"),
                style: AppStyle.mainTile,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter some note content!";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 24,
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
                maxLength: 5000,
                decoration:
                    textFormFieldDecoration(color_id, "", "Note Content"),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: (() {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Progressing Data"),
              ),
            );
            FirebaseFirestore.instance.collection("Notes").add({
              "note_tile": _tileController.text,
              "creation_date": date,
              "note_content": _mainController.text,
              "color_id": color_id
            });
            Navigator.pop(context);
          }
        }),
        child: Icon(Icons.save),
      ),
    );
  }

  InputDecoration textFormFieldDecoration(
      int color_id, String hint, String label) {
    return InputDecoration(
      hintText: hint,
      labelText: label,
      fillColor: AppStyle.contentColors[color_id],
      filled: true,
      enabledBorder: textFormFieldBorderStyle(color_id),
      disabledBorder: textFormFieldBorderStyle(color_id),
      border: textFormFieldBorderStyle(color_id),
      focusedBorder: textFormFieldBorderStyle(color_id),
    );
  }

  OutlineInputBorder textFormFieldBorderStyle(int color_id) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
      borderSide: BorderSide(color: AppStyle.contentColors[color_id]),
    );
  }
}
