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
    int color_id = widget.doc['color_id'];
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double size = double.infinity;
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
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 4,
          ),
          Center(
            child: Container(
              height: 20,
              width: width / 3,
              decoration: BoxDecoration(
                color: AppStyle.contentColors[color_id],
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 2, spreadRadius: 1)
                ],
              ),
              child: Center(
                child: Text(
                  widget.doc["creation_date"],
                  style: AppStyle.dateTile,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: SizedBox(
              child: Container(
                width: width / 1.04,
                decoration: BoxDecoration(
                  color: AppStyle.contentColors[color_id],
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, blurRadius: 10, spreadRadius: 5)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.doc["note_content"],
                        style: AppStyle.mainContetnt,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          FirebaseFirestore.instance
              .collection("Notes")
              .doc(widget.doc.id)
              .delete();
          Navigator.pop(context);
        }),
        child: Icon(Icons.delete),
      ),
    );
  }
}
