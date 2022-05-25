import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes/screen/note_reader.dart';
import 'package:fire_notes/style/app_style.dart';
import 'package:fire_notes/widgets/note_card.dart';
import 'package:flutter/material.dart';

import 'note_editor.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({Key? key}) : super(key: key);

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  TextEditingController searchController = TextEditingController();

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
