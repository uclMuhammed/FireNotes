class Note{
  String? note_tile;
  String? creation_date;
  String? note_content;
  int? color_id;

  Note({this.color_id,this.creation_date,this.note_content,this.note_tile});

  Map<String,dynamic> toJson() => {
    "note_tile": note_tile,
    "creation_date": creation_date,
    "note_content": note_content,
    "color_id":color_id,
  };
}