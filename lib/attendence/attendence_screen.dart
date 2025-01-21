import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:siddha_connect/attendence/geotag.dart';
import 'package:siddha_connect/utils/common_style.dart';
import 'package:siddha_connect/utils/cus_appbar.dart';
import 'package:siddha_connect/utils/sizes.dart';
import 'location_service.dart';

final imageProvider = StateProvider<XFile?>((ref) => null);

class AttendenceScreen extends ConsumerWidget {
  const AttendenceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getLetLong = ref.watch(coordinatesProvider);
    final locationMessage = ref.watch(locationMessageProvider);
    final address = ref.watch(addressProvider);
    final isLoading = ref.watch(isLoadingProvider);
    final capturedImage = ref.watch(imageProvider);

    log("Latitude and Longitude $getLetLong");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Attendance",
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.w600, fontSize: 22.sp),
            ),
            heightSizedBox(10.0),
            const MonthSelector(),
            // Text(
            //   locationMessage,
            //   textAlign: TextAlign.center,
            // ),
            const SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: width(context) * 0.8,
                  child: Text(
                    address,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                isLoading
                    ? const SpinKitCircle(
                        size: 30,
                        color: AppColor.primaryColor,
                      )
                    : const SizedBox()
              ],
            ),
           
          ],
        ),
      ),
      bottomNavigationBar: const PunchInButton(),
    );
  }
}

class PunchInButton extends ConsumerWidget {
  const PunchInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final capturedImage = ref.watch(imageProvider);
    return BottomAppBar(
      color: Colors.white,
      child: ElevatedButton(
        onPressed: () {
          CameraHelper cameraHelper = CameraHelper();
          cameraHelper.pickImage(context, ref);
          final locationService = LocationService(ref);
          locationService.getLocation();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primaryColor,
            foregroundColor: Colors.white,
            overlayColor: Colors.white,
            elevation: 2,
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shadowColor: Colors.grey),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.login),
            widthSizedBox(8.0),
            Text(
              'Punch In',
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final selectedDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

class MonthSelector extends ConsumerWidget {
  const MonthSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);

    String formattedMonth = DateFormat('MMM, yyyy').format(selectedDate);

    final currentDate = DateTime.now();

    bool isNextDisabled = selectedDate.year == currentDate.year &&
        selectedDate.month == currentDate.month;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: () {
            ref.read(selectedDateProvider.notifier).state = DateTime(
              selectedDate.year,
              selectedDate.month - 1,
            );
          },
        ),
        Text(
          formattedMonth,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        IconButton(
          icon: const Icon(
            Icons.arrow_forward_ios,
            size: 20,
          ),
          onPressed: isNextDisabled
              ? null
              : () {
                  ref.read(selectedDateProvider.notifier).state = DateTime(
                    selectedDate.year,
                    selectedDate.month + 1,
                  );
                },
        ),
      ],
    );
  }
}



// final pickedImageProvider = StateProvider<File?>((ref) => null);
// class CameraHelper {
//   final ImagePicker _picker = ImagePicker();

//   Future<void> pickImage(BuildContext context, WidgetRef ref) async {
//     try {
//       final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

//       if (photo != null) {
//         ref.read(imageProvider.notifier).state = photo;
//         ref.read(pickedImageProvider.notifier).state = photo.path;
//         log("Photo captured: ${photo.path}");
//       } else {
//         log("No photo was taken.");
//       }
//     } catch (e) {
//       log("Error while picking image: $e");
//     }
//   }
// }




final pickedImageProvider = StateProvider<File?>((ref) => null);

class CameraHelper {
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(BuildContext context, WidgetRef ref) async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        // Store the XFile object in imageProvider
        ref.read(imageProvider.notifier).state = photo;

        // Convert photo.path (String) to File and store it in pickedImageProvider
        ref.read(pickedImageProvider.notifier).state = File(photo.path);

        log("Photo captured: ${photo.path}");
      } else {
        log("No photo was taken.");
      }
    } catch (e) {
      log("Error while picking image: $e");
    }
  }
}

