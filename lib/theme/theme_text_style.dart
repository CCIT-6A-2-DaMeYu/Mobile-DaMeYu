
import 'package:dameyu_project/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeTextStyle {
  TextStyle welcome = GoogleFonts.poppins(
    fontSize: 35,
    fontWeight: FontWeight.w600,
    color: ThemeColor().pinkColor,
  );

  TextStyle welcomeUsername = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: ThemeColor().pinkColor,
  );

  TextStyle login = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: ThemeColor().white2Color,
  );

  TextStyle artikel = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: ThemeColor().pinkColor,
  );
}
