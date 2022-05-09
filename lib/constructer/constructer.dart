// ignore_for_file: non_constant_identifier_names

class Note {
  String? id;
  String? note_tile;
  String? creation_date;
  String? note_content;
  int? color_id;

  Note(
      {this.color_id,
      this.creation_date,
      this.note_content,
      this.note_tile,
      this.id});

  Map<String, dynamic> toJson() => {
        "id": id,
        "note_tile": note_tile,
        "creation_date": creation_date,
        "note_content": note_content,
        "color_id": color_id,
      };
}
