import 'package:flutter/material.dart';

class AppColor {
  static const primaryColor = Color(0xff005BFF);
  static const whiteColor = Colors.white;
}

Color getColorFromPercentage(String p, Color startColor, Color endColor) {
  String percentage = p.replaceAll('%', '');
  double percent = double.parse(percentage);
  percent = percent.clamp(0, 100);
  double factor = percent / 100;
  int red = ((endColor.red - startColor.red) * factor + startColor.red).toInt();
  int green =
      ((endColor.green - startColor.green) * factor + startColor.green).toInt();
  int blue =
      ((endColor.blue - startColor.blue) * factor + startColor.blue).toInt();

  return Color.fromRGBO(red, green, blue, 1);
}

Color getColorFromPercentage1(String p, Color startColor, Color endColor) {
  // Remove '%' sign from the input percentage string
  String percentage = p.replaceAll('%', '');

  // Parse the string to double and clamp it between 0 and 100
  double percent = double.parse(percentage);
  percent = percent.clamp(0, 100);

  // Calculate the interpolation factor
  double factor = percent / 100;

  int red = ((endColor.red - startColor.red) * factor + startColor.red).toInt();
  int green =
      ((endColor.green - startColor.green) * factor + startColor.green).toInt();
  int blue =
      ((endColor.blue - startColor.blue) * factor + startColor.blue).toInt();

  return Color.fromRGBO(red, green, blue, 1);
}
