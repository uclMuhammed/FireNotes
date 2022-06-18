import 'package:fire_notes/main.dart';
import 'package:fire_notes/screen/fav_notes_list.dart';
import 'package:fire_notes/screen/note_editor.dart';
import 'package:fire_notes/screen/note_list_screen.dart';
import 'package:fire_notes/screen/note_lock_screen.dart';
import 'package:fire_notes/style/app_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/all_selected_delete_button.dart';

class TabBarHomeScreen extends StatefulWidget {
  const TabBarHomeScreen({Key? key}) : super(key: key);

  @override
  State<TabBarHomeScreen> createState() => _TabBarHomeScreenState();
}

class _TabBarHomeScreenState extends State<TabBarHomeScreen>
    with SingleTickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser!;
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
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: AppStyle.mainColor,
          drawer: Drawer(
            backgroundColor: AppStyle.mainColor,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  user.email!,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                ElevatedButton.icon(
                  onPressed: () => FirebaseAuth.instance.signOut().then(
                      (value) => navigatorKey.currentState!
                          .popUntil((route) => route.isFirst)),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Sing Out'),
                ),
              ],
            ),
          ),
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
                  text: "Locked Notes",
                  icon: Icon(Icons.lock),
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: controller,
            children: const [
              NoteListScreen(),
              FavNotesList(),
              LockedNotesList(),
            ],
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
        ),
      ),
    );
  }
}
