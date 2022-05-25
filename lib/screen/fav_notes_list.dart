import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes/screen/note_editor.dart';
import 'package:fire_notes/screen/note_reader.dart';
import 'package:fire_notes/style/app_style.dart';
import 'package:fire_notes/widgets/note_card.dart';
import 'package:flutter/material.dart';

class FavNotesList extends StatefulWidget {
  const FavNotesList({Key? key}) : super(key: key);

  @override
  State<FavNotesList> createState() => _FavNotesListState();
}

class _FavNotesListState extends State<FavNotesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("Notes").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshots.hasData) {
                    var favList = [];
                    for (var fav in snapshots.data!.docs.toList().reversed) {
                      if (fav["favorite"] == true) {
                        favList.add(fav);
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
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NoteEditorScreen()));
        },
        label: const Text("Add Note"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
