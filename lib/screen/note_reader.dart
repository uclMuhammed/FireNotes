import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes/style/app_style.dart';
import 'package:flutter/material.dart';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;
  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardColors[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardColors[color_id],
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16 ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doc["note_tile"],
              style: AppStyle.mainTile,
            ),
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
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
