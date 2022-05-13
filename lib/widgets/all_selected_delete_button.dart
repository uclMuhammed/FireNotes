import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllSelectedDeleteButton extends StatelessWidget {
  const AllSelectedDeleteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
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
        icon: const Icon(Icons.delete_forever));
  }
}
