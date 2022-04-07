import 'package:flutter/material.dart';

class AppColor {
  static Map<int, Color> colorMap(Color color) {
    int r = color.red;
    int g = color.green;
    int b = color.blue;
    return {
      50: Color.fromRGBO(r, g, b, .1),
      100: Color.fromRGBO(r, g, b, .2),
      200: Color.fromRGBO(r, g, b, .3),
      300: Color.fromRGBO(r, g, b, .4),
      400: Color.fromRGBO(r, g, b, .5),
      500: Color.fromRGBO(r, g, b, .6),
      600: Color.fromRGBO(r, g, b, .7),
      700: Color.fromRGBO(r, g, b, .8),
      800: Color.fromRGBO(r, g, b, .9),
      900: Color.fromRGBO(r, g, b, 1)
    };
  }

  static MaterialColor primary = MaterialAppColor(0xff3D5A80);
  static MaterialAppColor secondary = MaterialAppColor(0xff98C1D9);
  static MaterialAppColor light = MaterialAppColor(0xffE0FBFC);
  static MaterialColor dark = MaterialAppColor(0xff3D5A80);
  static MaterialColor black = MaterialAppColor(0xff000000);
  static MaterialAppColor accent = MaterialAppColor(0xffEE6C4D);
}

class MaterialAppColor extends MaterialColor {
  MaterialAppColor(int primary)
      : super(primary, AppColor.colorMap(Color(primary)));
}
