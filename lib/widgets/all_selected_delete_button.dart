import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllSelectedDeleteButton extends StatelessWidget {
  const AllSelectedDeleteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var collection = FirebaseFirestore.instance.collection('Notes');
        var querySnapshot = await collection.get();
        var idList = [];
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          bool ischecking = data["ischecking"];
          var id = data["id"];
          if (ischecking == true) {
            idList.add(id);
          }
        }
        for (var i = 0; i < idList.length; i++) {
          FirebaseFirestore.instance
              .collection("Notes")
              .doc(idList[i])
              .delete();
        }
      },
      onLongPress: () async {
        var collection = FirebaseFirestore.instance.collection('Notes');
        var querySnapshot = await collection.get();
        var noteList = [];
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          noteList.add(data);
        }
        for (var i = 0; i < noteList.length; i++) {
          if (noteList[i]["ischecking"] == false &&
              noteList[i]["password"].toString().isEmpty) {
            FirebaseFirestore.instance
                .collection("Notes")
                .doc(noteList[i]["id"])
                .update({"ischecking": true});
          }
          if (noteList[i]["ischecking"] == true &&
              noteList[i]["password"].toString().isEmpty) {
            FirebaseFirestore.instance
                .collection("Notes")
                .doc(noteList[i]["id"])
                .update({"ischecking": false});
          }
        }
      },
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Icon((Icons.delete_forever)),
      ),
    );
  }
}
