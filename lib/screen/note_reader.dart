import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes/style/app_style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteReaderScreen extends StatefulWidget {
  const NoteReaderScreen(this.doc, {Key? key}) : super(key: key);
  final QueryDocumentSnapshot doc;
  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    String d = widget.doc.reference.toString();
    String dos = d.replaceRange(0, 46, "");
    String doc = dos.replaceRange(20, null, "");
    int color_id = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardColors[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardColors[color_id],
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.doc["note_tile"],
          style: GoogleFonts.roboto(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 4,
            ),
            Text(
              widget.doc["creation_date"],
              style: AppStyle.dateTile,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.doc["note_content"],
              style: AppStyle.mainContetnt,
              overflow: TextOverflow.clip,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          FirebaseFirestore.instance.collection("Notes").doc(doc).delete();
          Navigator.pop(context);
        }),
        child: Icon(Icons.delete),
      ),
    );
  }
}
