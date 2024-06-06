import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'common_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: AppColor.whiteColor,
      backgroundColor: AppColor.primaryColor,
      titleSpacing: 0,
      centerTitle: false,
      title: SvgPicture.asset("assets/images/logo.svg"),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: SvgPicture.asset(
            "assets/images/profile.svg",
            height: 28,
            width: 28,
          ),
        ),
      ],
    );
  }
}
