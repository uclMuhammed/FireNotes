import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fire_notes/screen/note_editor.dart';
import 'package:fire_notes/screen/note_reader.dart';

import 'package:fire_notes/style/app_style.dart';
import 'package:fire_notes/widgets/fav_list.dart';
import 'package:fire_notes/widgets/note_card.dart';

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../widgets/all_list.dart';
import '../widgets/all_selected_delete_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  bool showFavorite = false;
  bool isRefresh = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppStyle.mainColor,
        title: const Text("Fire Notes"),
        centerTitle: true,
        actions: [
          const AllSelectedDeleteButton(),
          LikeButton(
            size: 30,
            onTap: (value) async {
              showFavorite = !showFavorite;

              return showFavorite;
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: showFavorite
                  ? favCardList(isRefresh)
                  : allCardList(isRefresh),
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

  GridView homeScreenCard(
      Iterable<QueryDocumentSnapshot<Object?>> myList, BuildContext context) {
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
}

OutlineInputBorder textFormFieldBorderStyle() {
  return const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
    borderSide: BorderSide(color: Colors.white),
  );
}
