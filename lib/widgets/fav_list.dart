import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes/screen/note_reader.dart';
import 'package:fire_notes/widgets/note_card.dart';
import 'package:flutter/material.dart';

StreamBuilder<QuerySnapshot<Object?>> favCardList(bool isRefresh) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection("Notes").snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
      if (snapshots.connectionState == ConnectionState.waiting) {
        if (isRefresh == true) {
          isRefresh = !isRefresh;
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          isRefresh = !isRefresh;
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }

      if (snapshots.hasData) {
        var favList = <QueryDocumentSnapshot<Object?>>[];
        for (var favoriteList in snapshots.data!.docs.toList()) {
          bool favcheck = favoriteList["favorite"];
          if (favcheck == true) {
            favList.add(favoriteList);
          }
        }
        return GridView.count(
          crossAxisCount: 2,
          children: favList
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
