import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes/screen/home_screen.dart';
import 'package:fire_notes/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class ReaderEditorScreen extends StatefulWidget {
  const ReaderEditorScreen(this.doc, {Key? key}) : super(key: key);
  final QueryDocumentSnapshot doc;

  @override
  State<ReaderEditorScreen> createState() => _ReaderEditorScreenState();
}

class _ReaderEditorScreenState extends State<ReaderEditorScreen> {
  final formKey = GlobalKey<FormState>();
  String daet = DateTime.now().toString();
  get dates => daet.replaceRange(16, null, "");
  final TextEditingController tileController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    int colorId = widget.doc['color_id'];

    tileController.text = widget.doc["note_tile"];
    contentController.text = widget.doc["note_content"];

    return Scaffold(
      backgroundColor: AppStyle.cardColors[colorId],
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          LikeButton(
            size: 30,
            onTap: (value) async {
              isFav = !isFav;
              return isFav;
            },
          )
        ],
        title: Text(
          widget.doc["note_tile"],
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: AppStyle.cardColors[colorId],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
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
        onPressed: () {
          if (formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Progressing Data"),
              ),
            );
            FirebaseFirestore.instance
                .collection("Notes")
                .doc(widget.doc["id"])
                .update({
              "favorite": isFav,
              "color_id": widget.doc["color_id"],
              "creation_date": dates,
              "note_content": contentController.text,
              "note_tile": tileController.text,
              "ischecking": false,
            });
          }
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        },
        child: const Icon(Icons.save),
      ),
    );
  }
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
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(
      Radius.circular(20),
    ),
    borderSide: BorderSide(color: AppStyle.contentColors[colorId]),
  );
}
