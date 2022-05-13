// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes/constructer/constructer.dart';
import 'package:fire_notes/screen/note_reader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/note_card.dart';

class FireBaseStream extends StatelessWidget {
  const FireBaseStream({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          return Stack(children: [
            GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
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
            ),
          ]);
        }
        return Center(
            child: Text(
          "There's no notes",
          style: GoogleFonts.nunito(color: Colors.white),
        ));
      },
    );
  }
}
