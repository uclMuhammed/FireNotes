// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';

class Note extends ChangeNotifier {
  bool? ischecking;
  String? id;
  String? note_tile;
  String? creation_date;
  String? note_content;
  int? color_id;
  bool? favorite;

  Note(
      {this.ischecking = false,
      this.color_id,
      this.creation_date,
      this.note_content,
      this.note_tile,
      this.id,
      this.favorite});

  Map<String, dynamic> toJson() => {
        "id": id,
        "note_tile": note_tile,
        "creation_date": creation_date,
        "note_content": note_content,
        "color_id": color_id,
        "ischecking": ischecking,
        "favorite": favorite,
      };
}
