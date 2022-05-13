import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static Color bgColor = const Color(0xffe2e2ff);
  static Color mainColor = const Color(0xff000633);
  static Color accentColor = const Color(0xff0065ff);

  static List<Color> cardColors = [
    Colors.red.shade100,
    Colors.pink.shade100,
    Colors.orange.shade100,
    Colors.yellow.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.grey.shade100,
    Colors.amber.shade100,
    Colors.cyan.shade100
  ];

  static List<Color> contentColors = [
    Colors.red.shade200,
    Colors.pink.shade200,
    Colors.orange.shade200,
    Colors.yellow.shade200,
    Colors.green.shade200,
    Colors.blue.shade200,
    Colors.grey.shade200,
    Colors.amber.shade200,
    Colors.cyan.shade200
  ];

  static TextStyle mainTile =
      GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold);
  static TextStyle mainContetnt =
      GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.normal);
  static TextStyle dateTile =
      GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w500);
}
