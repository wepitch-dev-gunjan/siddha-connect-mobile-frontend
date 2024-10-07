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
          // Check if 'data' is null
          if (data == null) {
            return const Center(child: Text("No data available"));
          }

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
                  data['name'] ??
                      "No Name", // Provide fallback if 'name' is null
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 22.sp,
                    ),
                  ),
                ),
                heightSizedBox(20.0),
                TxtField(
                  enabled: false,
                  readOnly: true,
                  contentPadding: contentPadding,
                  labelText: "Code",
                  maxLines: 1,
                  controller: TextEditingController(
                      text: data['code'] ?? "N/A"), // Handle 'code' being null
                  keyboardType: TextInputType.text,
                ),
                heightSizedBox(8.0),
                TxtField(
                  enabled: false,
                  readOnly: true,
                  contentPadding: contentPadding,
                  labelText: "Name",
                  maxLines: 1,
                  controller: TextEditingController(
                      text: data['name'] ?? "N/A"), // Handle 'name' being null
                  keyboardType: TextInputType.text,
                ),
                heightSizedBox(8.0),
                TxtField(
                  enabled: false,
                  readOnly: true,
                  contentPadding: contentPadding,
                  labelText: "Email",
                  maxLines: 1,
                  controller: TextEditingController(
                      text:
                          data['email'] ?? "N/A"), // Handle 'email' being null
                  keyboardType: TextInputType.text,
                ),
                heightSizedBox(8.0),
                TxtField(
                  enabled: false,
                  readOnly: true,
                  contentPadding: contentPadding,
                  labelText: "Role",
                  maxLines: 1,
                  controller: TextEditingController(
                      text: data['role'] ?? "N/A"), // Handle 'role' being null
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
      ),
    );
  }
}
