import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/utils/common_style.dart';
import '../../../utils/drawer.dart';
import '../../../utils/fields.dart';
import '../../../utils/sizes.dart';

class EmployProfile extends ConsumerWidget {
  const EmployProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employData = ref.watch(userProfileProvider);
    return Scaffold(
        appBar: AppBar(
          foregroundColor: AppColor.whiteColor,
          backgroundColor: AppColor.primaryColor,
          titleSpacing: 0,
          centerTitle: false,
          title: SvgPicture.asset("assets/images/logo.svg"),
        ),
        backgroundColor: AppColor.whiteColor,
        body: employData.when(
          data: (data) {
            log("profileEmploy$data");
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  ClipOval(
                    child: Image.asset(
                      "assets/images/noImage.png",
                      height: 119,
                      width: 110,
                    ),
                  ),
                  Text(
                    data['name'],
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                      fontSize: 22.sp,
                    )),
                  ),
                  GestureDetector(
                      onTap: () {
                        // navigateTo(DelarProfileEditScreen());
                      },
                      child: Text(
                        "Edit Profile",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff3300FF))),
                      )),
                  heightSizedBox(20.0),
                  TxtField(
                    readOnly: true,
                    contentPadding: contentPadding,
                    labelText: "Code",
                    maxLines: 1,
                    controller: TextEditingController(text: data['code']),
                    keyboardType: TextInputType.text,
                  ),
                  heightSizedBox(8.0),
                  TxtField(
                    readOnly: true,
                    contentPadding: contentPadding,
                    labelText: "Name",
                    maxLines: 1,
                    controller: TextEditingController(text: data['name']),
                    keyboardType: TextInputType.text,
                  ),
                  heightSizedBox(8.0),
                  TxtField(
                    readOnly: true,
                    contentPadding: contentPadding,
                    labelText: "Email",
                    maxLines: 1,
                    controller: TextEditingController(text: data['email']),
                    keyboardType: TextInputType.text,
                  ),
                  heightSizedBox(8.0),
                  TxtField(
                    readOnly: true,
                    contentPadding: contentPadding,
                    labelText: "Role",
                    maxLines: 1,
                    controller: TextEditingController(text: data['role']),
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            );
          },
          error: (error, stackTrace) => const Center(
            child: Text("Something went wrong"),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
