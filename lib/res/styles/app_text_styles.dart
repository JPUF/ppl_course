import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ppl_course/res/color/colors.dart';

class AppTextStyles {
  static TextStyle button = TextStyle(
      color: AppColor.black,
      fontSize: 17.0,
      height: 0.8,
      fontWeight: FontWeight.bold,
      fontFamily: AppFontFamilies.mont);

  static TextStyle barTitle = TextStyle(
      color: AppColor.dark,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: AppFontFamilies.mont);

  static TextStyle navBarItemText = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: AppColor.dark, fontSize: 10.0, fontWeight: FontWeight.normal));

  static TextStyle body14 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: AppColor.dark, fontSize: 14.0, fontWeight: FontWeight.normal));

  static TextStyle body17 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: AppColor.dark, fontSize: 17.0, fontWeight: FontWeight.normal));

  static TextStyle headline2 = TextStyle(
      color: AppColor.dark, fontSize: 32.0, fontFamily: AppFontFamilies.mont);

  static TextStyle headline3 = TextStyle(
      color: AppColor.dark, fontSize: 24.0, fontFamily: AppFontFamilies.mont);

  static TextStyle headline4 = TextStyle(
      color: AppColor.dark, fontSize: 20.0, fontFamily: AppFontFamilies.mont);
}

class AppFontFamilies {
  static String poetsen = 'Poetsen One';
  static String mont = 'Mont';
  static String andala = 'Andala';
}
