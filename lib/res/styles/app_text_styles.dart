import 'package:flutter/material.dart';
import 'package:ppl_course/res/color/colors.dart';

class AppTextStyles {
  static TextStyle button = TextStyle(
      color: AppColor.black,
      fontSize: 17.0,
      fontWeight: FontWeight.bold,
      fontFamily: AppFontFamilies.poetsen);

  static TextStyle body15 = TextStyle(
      color: AppColor.dark,
      fontSize: 15.0,
      fontWeight: FontWeight.normal,
      height: 1.2,
      fontFamily: AppFontFamilies.andala);

  static TextStyle body12 = TextStyle(
      color: AppColor.dark,
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      fontFamily: AppFontFamilies.andala);

  static TextStyle headline3 = TextStyle(
      color: AppColor.dark,
      fontSize: 24.0,
      fontFamily: AppFontFamilies.poetsen);

  static TextStyle headline2 = TextStyle(
      color: AppColor.dark,
      fontSize: 32.0,
      fontFamily: AppFontFamilies.poetsen);
}

class AppFontFamilies {
  static String poetsen = 'Poetsen One';
  static String andala = 'Andala';
}
