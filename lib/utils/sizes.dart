import 'package:flutter/material.dart';

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

Container verticalDivider(double height) {
  return Container(height: height, width: 1, color: Colors.black26);
}

Container horizontalDivider(width) {
  return Container(height: 0.2, width: width, color: Colors.black26);
}

SizedBox heightSizedBox(height) {
  return SizedBox(height: height);
}

SizedBox widthSizedBox(width) {
  return SizedBox(width: width);
}
