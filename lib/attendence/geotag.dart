import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/attendence/repo/attendence_repo.dart';
import '../extraction/components/dealer_dropdown.dart';
import '../extraction/screens/data_upload_form.dart';
import '../utils/common_style.dart';
import '../utils/cus_appbar.dart';
import '../utils/sizes.dart';
import 'attendence_screen.dart';
import 'location_service.dart';

class GeoTagScreen extends ConsumerWidget {
  const GeoTagScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getLetLong = ref.watch(coordinatesProvider);
    final locationMessage = ref.watch(locationMessageProvider);
    final address = ref.watch(addressProvider);
    final isLoading = ref.watch(isLoadingProvider);
    final dealerList = ref.watch(getDealerListProvider);
    final selectedDealer = ref.watch(selectedDealerProvider);
    final capturedImage = ref.watch(imageProvider);

    log("Latitude and Longitude ${getLetLong['latitude'].runtimeType}");
    return dealerList.when(
      data: (data) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(),
          body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightSizedBox(10.0),

                DealerDropDown(data: data),
                // Text(
                //   "",
                //   style: GoogleFonts.lato(
                //       fontWeight: FontWeight.w600, fontSize: 22.sp),
                // ),
                heightSizedBox(10.0),
                const SizedBox(height: 20),
                isLoading
                    ? const SpinKitThreeBounce(
                        color: AppColor.primaryColor,
                        size: 28,
                      )
                    : Row(
                        children: [
                          Flexible(
                            child: Text(
                              address,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              final locationService = LocationService(ref);
                              locationService.getLocation();
                            },
                            icon: const Icon(
                              Icons.refresh,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                capturedImage != null
                    ? Expanded(
                        child: Image.file(
                          File(capturedImage.path),
                          // height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Center(
                        child: Text(
                          'No image selected or captured',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
              ],
            ),
          ),
          bottomNavigationBar: SubmitButton(
            latitude: getLetLong['latitude']!,
            longitude: getLetLong['longitude']!,
          ),
        );
      },
      error: (error, stackTrace) => const Center(
        child: Text("Something went wrong"),
      ),
      loading: () => const Center(
        child: SpinKitCircle(
          color: AppColor.primaryColor,
        ),
      ),
    );
  }
}

// class SubmitButton extends ConsumerWidget {
//   final double latitude, longitude;

//   const SubmitButton({
//     super.key,
//     required this.latitude,
//     required this.longitude,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final capturedImage = ref.watch(imageProvider);
//     return BottomAppBar(
//       color: Colors.white,
//       child: ElevatedButton(
//         onPressed: () {
//           CameraHelper cameraHelper = CameraHelper();
//           cameraHelper.pickImage(context, ref);
//           final dealer = ref.read(selectedDealerProvider);

//           if (dealer != null) {
//             ref.read(attendenceRepoProvider).dealerGeoTag(data: {
//               'dealerCode': dealer['BUYER CODE'],
//               'latitude': latitude,
//               'longitude': longitude
//             });
//           } else {
//             // Handle the case when dealer is null
//             print("Dealer is null");
//           }
//         },
//         style: ElevatedButton.styleFrom(
//             backgroundColor: AppColor.primaryColor,
//             foregroundColor: Colors.white,
//             overlayColor: Colors.white,
//             elevation: 2,
//             surfaceTintColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(30),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//             shadowColor: Colors.grey),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.login),
//             widthSizedBox(8.0),
//             Text(
//               'Submit',
//               style: GoogleFonts.lato(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

final isImageLoadingProvider = StateProvider<bool>((ref) => false);

// class SubmitButton extends ConsumerWidget {
//   final double latitude, longitude;

//   const SubmitButton({
//     super.key,
//     required this.latitude,
//     required this.longitude,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Watch the imageProvider to get the current image state
//     final capturedImage = ref.watch(imageProvider);
//     final imageLoading=ref.watch(isImageLoadingProvider);

//     return BottomAppBar(
//       color: Colors.white,
//       child: ElevatedButton(
//         onPressed: () {
//           if (capturedImage == null) {
//             // Trigger image capture if no image exists
//             CameraHelper cameraHelper = CameraHelper();
//             cameraHelper.pickImage(context, ref);
//           } else {
//             // Proceed to submit data if an image is already captured
//             final dealer = ref.read(selectedDealerProvider);

//             if (dealer != null) {
//               final response =
//                   ref.read(attendenceRepoProvider).dealerGeoTag(data: {
//                 'dealerCode': dealer['BUYER CODE'],
//                 'latitude': latitude,
//                 'longitude': longitude,
//                 'geotag_picture': capturedImage.path
//               });
//             } else {
//               // Handle the case when dealer is null
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Please select a dealer.')),
//               );
//             }
//           }
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColor.primaryColor,
//           foregroundColor: Colors.white,
//           overlayColor: Colors.white,
//           elevation: 2,
//           surfaceTintColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//           shadowColor: Colors.grey,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.camera_alt),
//             widthSizedBox(8.0),
//             Text(
//               // Change button text based on capturedImage state
//               capturedImage == null ? 'Take a Picture' : 'Submit',
//               style: GoogleFonts.lato(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class SubmitButton extends ConsumerWidget {
  final double latitude, longitude;

  const SubmitButton({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the imageProvider to get the current image state
    final capturedImage = ref.watch(imageProvider);
    final imageLoading = ref.watch(isImageLoadingProvider);

    return BottomAppBar(
      color: Colors.white,
      child: ElevatedButton(
        onPressed: imageLoading
            ? null // Disable button when loading
            : () {
                if (capturedImage == null) {
                  // Trigger image capture if no image exists
                  CameraHelper cameraHelper = CameraHelper();
                  cameraHelper.pickImage(context, ref);
                } else {
                  // Proceed to submit data if an image is already captured
                  final dealer = ref.read(selectedDealerProvider);

                  if (dealer != null) {
                    final response =
                        ref.read(attendenceRepoProvider).dealerGeoTag(data: {
                      'dealerCode': dealer['BUYER CODE'],
                      'latitude': latitude,
                      'longitude': longitude,
                      'geotag_picture': capturedImage.path
                    });
                  } else {
                    // Handle the case when dealer is null
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select a dealer.')),
                    );
                  }
                }
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
          shadowColor: Colors.grey,
        ),
        child: imageLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.camera_alt,
                    size: 22,
                    color: Colors.white,
                  ),
                  widthSizedBox(8.0),
                  Text(
                    capturedImage == null ? 'Take a Picture' : 'Submit',
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
