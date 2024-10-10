import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({super.key});

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 700;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 700;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
