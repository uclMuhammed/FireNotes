import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes/screen/home_screen.dart';
import 'package:fire_notes/screen/reader_editor.dart';
import 'package:fire_notes/style/app_style.dart';
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
    int colorId = widget.doc['color_id'];
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppStyle.cardColors[colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardColors[colorId],
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.doc["note_tile"],
          style: GoogleFonts.roboto(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReaderEditorScreen(widget.doc)));
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.black,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 4,
            ),
            Center(
              child: Container(
                height: 20,
                width: width / 3,
                decoration: BoxDecoration(
                  color: AppStyle.contentColors[colorId],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: const [
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
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                child: Container(
                  width: width / 1.04,
                  decoration: BoxDecoration(
                    color: AppStyle.contentColors[colorId],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 5)
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
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          FirebaseFirestore.instance
              .collection("Notes")
              .doc(widget.doc.id)
              .delete();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TabBarHomeScreen()));
        }),
        child: const Icon(Icons.delete),
      ),
    );
  }
}
