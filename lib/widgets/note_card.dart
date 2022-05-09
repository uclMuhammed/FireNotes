import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes/style/app_style.dart';
import 'package:flutter/material.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppStyle.cardColors[doc["color_id"]],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(doc["creation_date"],style: AppStyle.dateTile,),
          SizedBox(height: 8,),
          Text(doc["note_tile"],style: AppStyle.mainTile,),
          SizedBox(height: 8,),
          Text(doc["note_content"],style: AppStyle.mainContetnt,overflow: TextOverflow.ellipsis,),
        ],
      ),
    ),
  );
}
