import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {

  static Color bgColor = const Color(0xffe2e2ff);
  static Color mainColor = const Color(0xff000633);
  static Color accentColor = const Color(0xff0065ff);


  static List<Color> cardColors = [
    Colors.red.shade200,
    Colors.pink.shade200,
    Colors.orange.shade200,
    Colors.yellow.shade200,
    Colors.green.shade200,
    Colors.blue.shade200,
  ];

  static List<Color> contentColors = [
    Colors.red.shade300,
    Colors.pink.shade300,
    Colors.orange.shade300,
    Colors.yellow.shade300,
    Colors.green.shade300,
    Colors.blue.shade300,
  ];


  static TextStyle  mainTile = GoogleFonts.roboto(fontSize: 18,fontWeight: FontWeight.bold);
  static TextStyle  mainContetnt = GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.normal);
  static TextStyle  dateTile = GoogleFonts.roboto(fontSize: 13,fontWeight: FontWeight.w500);
}