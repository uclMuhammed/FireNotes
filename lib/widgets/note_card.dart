import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes/style/app_style.dart';
import 'package:flutter/material.dart';

Widget noteCard(
  Function()? onTap,
  QueryDocumentSnapshot doc,
) {
  return InkWell(
    onTap: onTap,
    onLongPress: () {
      if (doc["ischecking"] == false) {
        FirebaseFirestore.instance
            .collection("Notes")
            .doc(doc["id"])
            .update({"ischecking": true});
      } else {
        FirebaseFirestore.instance
            .collection("Notes")
            .doc(doc["id"])
            .update({"ischecking": false});
      }
    },
    child: Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppStyle.cardColors[doc["color_id"]],
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 2, spreadRadius: 1)
        ],
      ),
      // decoration: BoxDecoration(
      //   color: AppStyle.cardColors[doc["color_id"]],
      //   borderRadius: BorderRadius.circular(8),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc["creation_date"],
            style: AppStyle.dateTile,
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            doc["note_tile"],
            style: AppStyle.mainTile,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            doc["note_content"],
            style: AppStyle.mainContetnt,
            overflow: TextOverflow.ellipsis,
          ),
          Checkbox(
            value: doc["ischecking"],
            onChanged: (value) {},
          ),
        ],
      ),
    ),
  );
}
