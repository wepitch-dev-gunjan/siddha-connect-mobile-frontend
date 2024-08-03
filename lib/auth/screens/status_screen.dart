import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/utils/common_style.dart';
import 'package:siddha_connect/utils/cus_appbar.dart';
import 'package:siddha_connect/utils/sizes.dart';

class StatusScreen extends ConsumerWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                heightSizedBox(150.0.h),
                Center(
                  child: SvgPicture.asset(
                    "assets/images/splashlogo.svg",
                    height: 84,
                  ),
                ),
                heightSizedBox(8.0),
                Center(
                  child: SvgPicture.asset(
                    "assets/images/siddhaconnect.svg",
                    height: 18,
                  ),
                ),
                heightSizedBox(45.h),
                Center(
                  child: SvgPicture.asset(
                    "assets/images/status.svg",
                    width: 134.w, height: 135.h,
                    // height: 50,
                  ),
                ),
                heightSizedBox(20.0.h),
                Text(
                  "Verification Pending.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 20,
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                heightSizedBox(5.0.h),
                Text(
                  "Your verification request has been\nreceived. Please wait, your profile will be\nverified soon.....",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(0xff878787),
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
