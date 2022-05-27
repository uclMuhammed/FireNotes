import 'package:fire_notes/screen/alarm_notes.dart';
import 'package:fire_notes/screen/fav_notes_list.dart';

import 'package:fire_notes/screen/note_list_screen.dart';

import 'package:fire_notes/style/app_style.dart';

import 'package:flutter/material.dart';

import '../widgets/all_selected_delete_button.dart';

class TabBarHomeScreen extends StatefulWidget {
  const TabBarHomeScreen({Key? key}) : super(key: key);

  @override
  State<TabBarHomeScreen> createState() => _TabBarHomeScreenState();
}

class _TabBarHomeScreenState extends State<TabBarHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  bool showFavorite = false;
  bool isRefresh = false;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppStyle.mainColor,
        appBar: AppBar(
          backgroundColor: AppStyle.mainColor,
          title: const Text("Fire Notes"),
          centerTitle: true,
          actions: const [
            AllSelectedDeleteButton(),
          ],
          bottom: TabBar(
            controller: controller,
            tabs: const [
              Tab(
                text: "All Notes",
                icon: Icon(Icons.notes_rounded),
              ),
              Tab(
                text: "Fav Notes",
                icon: Icon(Icons.favorite),
              ),
              Tab(
                text: "Alarm Notes",
                icon: Icon(Icons.alarm),
              ),
            ],
          ),
        ),
        body: TabBarView(controller: controller, children: const [
          NoteListScreen(),
          FavNotesList(),
          AlarmNotes(),
        ]),
      ),
    );
  }
}
