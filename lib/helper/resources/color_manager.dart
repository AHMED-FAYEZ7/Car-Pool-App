import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#7BCB96");
  static Color lightPrimary = HexColor.fromHex("#93DAAB");
  static Color grey = HexColor.fromHex("#9B9999");
  static Color darkGrey = HexColor.fromHex("#B1ACAC");

  // new colors
  static Color backgroundColor = HexColor.fromHex("#EBF3F9");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color blueWithOpacity = HexColor.fromHex("#A9C1D3");
  static Color black= HexColor.fromHex("#000000"); // red color
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}