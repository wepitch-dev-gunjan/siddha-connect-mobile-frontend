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
