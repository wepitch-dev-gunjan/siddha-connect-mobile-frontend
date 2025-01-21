import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/profile/repo/profile_repo.dart';
import 'package:siddha_connect/utils/navigation.dart';
import 'package:siddha_connect/utils/sizes.dart';
import '../../../attendence/location_service.dart';
import '../../../utils/common_style.dart';
import '../../controllers/profile_controller.dart';
import 'components/dealer_profile_comp.dart';
import 'update_dealer_profile.dart';

final getDealerProfileProvider = FutureProvider.autoDispose((ref) async {
  final getDealerVerified =
      await ref.watch(profileRepoProvider).getDealerProfile();
  ref.keepAlive();
  return getDealerVerified;
});

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(getDealerProfileProvider);
    final address = ref.watch(addressProvider);
    final coordinates = ref.watch(coordinatesProvider);
    final isLoading = ref.watch(isLoadingProvider);
    final dialogShown = ValueNotifier<bool>(false); // Track dialog state

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        foregroundColor: AppColor.whiteColor,
        backgroundColor: AppColor.primaryColor,
        titleSpacing: 0,
        centerTitle: false,
        title: SvgPicture.asset("assets/images/logo.svg"),
      ),
      body: userData.when(
        data: (data) {
          if (data == null || data['data'] == null || data['data'].isEmpty) {
            return const Center(
              child: Text("No Data Found"),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                heightSizedBox(10.0),
                const CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/images/profilepic.png"),
                ),
                Text(
                  data['data']['owner']['name'],
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                    fontSize: 22.sp,
                  )),
                ),
                heightSizedBox(10.0),
                GestureDetector(
                  onTap: () {
                    navigateTo(DelarProfileEditScreen());
                  },
                  child: Container(
                    height: 30.h,
                    width: 130.w,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "Edit Profile",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                heightSizedBox(20.0),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    children: [
                      DelarInfoGet(
                          delerCode: TextEditingController(
                              text: data['data']['dealerCode']),
                          shopName: TextEditingController(
                              text: data['data']['shopName']),
                          shopArea: TextEditingController(
                              text: data['data']['shopArea']),
                          shopAddress: TextEditingController(
                              text: data['data']['shopAddress'])),
                      GetOwnerInfo(
                        name: TextEditingController(
                            text: data['data']['owner']['name']),
                        position: TextEditingController(
                            text: data['data']['owner']['position']),
                        contactNumber: TextEditingController(
                            text: data['data']['owner']['contactNumber']),
                        email: TextEditingController(
                            text: data['data']['owner']['email']),
                        homeAddress: TextEditingController(
                            text: data['data']['owner']['homeAddress']),
                        birthDay: TextEditingController(
                            text: (data['data']['owner']['birthday'])
                                .split('T')[0]),
                      ),
                      GetFamilyInfo(
                        wifeName: TextEditingController(
                            text: data['data']['owner']['wife']['name']),
                        wifeBirthday: TextEditingController(
                            text: (data['data']['owner']['wife']['birthday'] !=
                                    null)
                                ? data['data']['owner']['wife']['birthday']
                                    .split('T')[0]
                                : ''),
                      ),
                      GetChildrensInfo(
                          children: data['data']['owner']['children']),
                      GetOtherFamilyMember(
                        familyMembers: data['data']['owner']
                            ['otherFamilyMembers'],
                      ),
                      GetOtherImportantDates(
                        importantDates: data['data']
                            ['otherImportantFamilyDates'],
                      ),
                      GetAnniversaryInfo(
                        shopAnniversary: TextEditingController(
                            text: (data['data']['anniversaryDate'] != null)
                                ? data['data']['anniversaryDate'].split('T')[0]
                                : ''),
                      ),
                      GetBusinessInfo(
                        businessType: TextEditingController(
                            text: data['data']['businessDetails']
                                ['typeOfBusiness']),
                        businessYears: TextEditingController(
                            text: data['data']['businessDetails']
                                    ['yearsInBusiness']
                                .toString()),
                        comunationController: TextEditingController(
                            text: data['data']['businessDetails']
                                ['preferredCommunicationMethod']),
                        specialNotes: TextEditingController(
                            text: data['data']['specialNotes']),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
        error: (error, stackTrace) => const Text("Something went wrong"),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showGeotagDialog(context);
        },
        label: const Text(
          "Geotag Me!",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        icon: const Icon(
          Icons.location_on,
          color: Colors.white,
        ),
        backgroundColor: AppColor.primaryColor,
        elevation: 8.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// Future<void> _showGeotagDialog(BuildContext context) async {
//   showDialog(
//     context: context,
//     barrierDismissible: false, // Prevent closing by tapping outside
//     builder: (BuildContext context) {
//       return FutureBuilder<Position>(
//         future: _determinePosition(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return AlertDialog(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(11)),
//               title: const Text("Fetching Location"),
//               content: const SizedBox(
//                 height: 50,
//                 child: Center(
//                     child: SpinKitCircle(
//                   color: AppColor.primaryColor,
//                 )),
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return AlertDialog(
//               title: const Text("Error"),
//               content: Text("Failed to get location: ${snapshot.error}"),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text("Close"),
//                 ),
//               ],
//             );
//           } else if (snapshot.hasData) {
//             final position = snapshot.data!;
//             return AlertDialog(
//               title: const Text("Your Location"),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(11)),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Latitude: ${position.latitude}",
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   Text(
//                     "Longitude: ${position.longitude}",
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                     onPressed: () {
//                       navigationPop();
//                     },
//                     child: const Text(
//                       "Cancel",
//                       style: TextStyle(color: Colors.black),
//                     )),
//                 Consumer(builder: (context, ref, child) {
//                   return ElevatedButton(
//                     onPressed: () {
//                       ref
//                           .read(profileControllerProvider)
//                           .dealerProfileUpdateController(data: {
//                         "latitude": position.latitude,
//                         "longitude": position.longitude
//                       });
//                     },
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColor.primaryColor),
//                     child: const Text(
//                       "Submit",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   );
//                 }),
//               ],
//             );
//           } else {
//             return AlertDialog(
//               title: const Text("Error"),
//               content: const Text("Unexpected error occurred."),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text("Close"),
//                 ),
//               ],
//             );
//           }
//         },
//       );
//     },
//   );
// }

Future<void> showGeotagDialog(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing by tapping outside
    builder: (BuildContext context) {
      return FutureBuilder<Position>(
        future: _determinePosition(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11)),
              title: const Text("Fetching Location"),
              content: const SizedBox(
                height: 50,
                child: Center(
                    child: SpinKitCircle(
                  color: AppColor.primaryColor,
                )),
              ),
            );
          } else if (snapshot.hasError) {
            return AlertDialog(
              title: const Text("Error"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11)),
              content: Text("Failed to get location: ${snapshot.error}"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Close"),
                ),
              ],
            );
          } else if (snapshot.hasData) {
            final position = snapshot.data!;
            return FutureBuilder<List>(
              future: placemarkFromCoordinates(
                  position.latitude, position.longitude),
              builder: (context, placeSnapshot) {
                if (placeSnapshot.connectionState == ConnectionState.waiting) {
                  return AlertDialog(
                    title: const Text("Fetching Address"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11)),
                    content: const Center(
                        child: SpinKitCircle(
                      color: AppColor.primaryColor,
                    )),
                  );
                } else if (placeSnapshot.hasError) {
                  return AlertDialog(
                    title: const Text("Error"),
                    content:
                        Text("Failed to get address: ${placeSnapshot.error}"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Close"),
                      ),
                    ],
                  );
                } else if (placeSnapshot.hasData) {
                  final placemarks = placeSnapshot.data!;
                  final address =
                      "${placemarks[1].name}, ${placemarks[1].subThoroughfare}, ${placemarks[1].thoroughfare}, ${placemarks[1].subLocality}, ${placemarks[1].locality}, ${placemarks[1].administrativeArea}, ${placemarks[1].postalCode}, ${placemarks[1].country}";
                  return AlertDialog(
                    title: const Text("Your Location"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11)),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   "Latitude: ${position.latitude}",
                        //   style: const TextStyle(fontSize: 16),
                        // ),
                        // Text(
                        //   "Longitude: ${position.longitude}",
                        //   style: const TextStyle(fontSize: 16),
                        // ),
                        // const SizedBox(height: 8),
                        Text(
                          "Address: $address",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Consumer(builder: (context, ref, child) {
                        return ElevatedButton(
                          onPressed: () {
                            ref
                                .read(profileControllerProvider)
                                .dealerProfileUpdateController(data: {
                              "latitude": position.latitude,
                              "longitude": position.longitude,
                              "address": address,
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryColor),
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }),
                    ],
                  );
                } else {
                  return AlertDialog(
                    title: const Text("Error"),
                    content: const Text("Unexpected error occurred."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Close"),
                      ),
                    ],
                  );
                }
              },
            );
          } else {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("Unexpected error occurred."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Close"),
                ),
              ],
            );
          }
        },
      );
    },
  );
}

Future<Position> _determinePosition() async {
  LocationPermission permission;

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception('Location permissions are permanently denied.');
  }

  return await Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 10,
    ),
  );
}
