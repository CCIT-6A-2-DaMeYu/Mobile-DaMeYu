
import 'package:dameyu_project/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeTextStyle {
  TextStyle welcome = GoogleFonts.leagueSpartan(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: ThemeColor().pinkColor,
  );

  TextStyle welcomeUsername = GoogleFonts.istokWeb(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: ThemeColor().pinkColor,
  );

  TextStyle profile = GoogleFonts.istokWeb(
    fontSize: 23,
    fontWeight: FontWeight.w800,
    color: ThemeColor().pinkColor,
  );

  TextStyle login = GoogleFonts.leagueSpartan(
    fontSize: 25,
    fontWeight: FontWeight.w700,
    color: ThemeColor().whiteColor,
  );

  TextStyle changeProfile = GoogleFonts.leagueSpartan(
    fontSize: 21,
    fontWeight: FontWeight.w600,
    color: ThemeColor().whiteColor,
  );
  

  TextStyle artikel = GoogleFonts.leagueSpartan(
    fontSize: 25,
    fontWeight: FontWeight.w700,
    color: ThemeColor().pinkColor,
  );

  TextStyle applePredict = GoogleFonts.leagueSpartan(
    fontSize: 21,
    fontWeight: FontWeight.w700,
    color: ThemeColor().whiteColor,
  );

  TextStyle resultPredict = GoogleFonts.istokWeb(
    fontSize: 19,
    fontWeight: FontWeight.w700,
    color: ThemeColor().whiteColor,
  );

  TextStyle chatBotHeader = GoogleFonts.leagueSpartan(
    fontSize: 21,
    fontWeight: FontWeight.w600,
    color: ThemeColor().blackColor,
  );

  TextStyle chatBot = GoogleFonts.leagueSpartan(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: ThemeColor().blackColor,
  );
  TextStyle chatBotText = GoogleFonts.leagueSpartan(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: ThemeColor().greyColor
  );
}
