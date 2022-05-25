import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes/screen/note_reader.dart';
import 'package:fire_notes/widgets/note_card.dart';
import 'package:flutter/material.dart';

StreamBuilder<QuerySnapshot<Object?>> allCardList(bool isRefresh) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection("Notes").snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
      if (snapshots.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (snapshots.hasData) {
        var myList = snapshots.data!.docs.toList().reversed;

        return GridView.count(
          crossAxisCount: 2,
          children: myList
              .map(
                (note) => noteCard(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteReaderScreen(note),
                    ),
                  );
                }, note),
              )
              .toList(),
        );
      }

      return const Center(
        child: Text("There's no Notes"),
      );
    },
  );
}
