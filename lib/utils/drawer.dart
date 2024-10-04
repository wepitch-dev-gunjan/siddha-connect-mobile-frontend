import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/auth/screens/splash_screen.dart';
import 'package:siddha_connect/profile/repo/profileRepo.dart';
import 'package:siddha_connect/pulseDataUpload/screens/extraction_data_upload.dart';
import 'package:siddha_connect/pulseDataUpload/screens/pulse_data_upload.dart';
import 'package:siddha_connect/uploadSalesData/screens/upload_channel-target.dart';
import 'package:siddha_connect/uploadSalesData/screens/upload_sales_data.dart';
import 'package:siddha_connect/uploadSalesData/screens/upload_segment_target.dart';
import 'package:siddha_connect/uploadSalesData/screens/upload_model_data.dart';
import 'package:siddha_connect/utils/navigation.dart';
import 'package:siddha_connect/utils/providers.dart';
import '../auth/repo/auth_repo.dart';
import '../salesDashboard/screen/sales_dashboard.dart';
import 'common_style.dart';
import 'secure_storage.dart';
import 'sizes.dart';

final userProfileProvider = FutureProvider.autoDispose((ref) async {
  final getprofileStatus = await ref.watch(profileRepoProvider).getProfile();

  return getprofileStatus;
});

final dealerProfileProvider = FutureProvider.autoDispose((ref) async {
  final getDealerVerified =
      await ref.watch(authRepoProvider).isDealerVerified();

  return getDealerVerified;
});

class CusDrawer extends ConsumerStatefulWidget {
  const CusDrawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CusDrawerState();
}

class _CusDrawerState extends ConsumerState<CusDrawer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final dealer = ref.watch(dealerRoleProvider);
    final userData = dealer == "dealer"
        ? ref.watch(dealerProfileProvider)
        : ref.watch(userProfileProvider);

    return Drawer(
      shape: const BeveledRectangleBorder(),
      width: 270,
      backgroundColor: AppColor.whiteColor,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                heightSizedBox(20.0),
                ClipOval(
                  child: Image.asset(
                    "assets/images/noImage.png",
                    height: 100,
                    width: 100,
                  ),
                ),
                heightSizedBox(10.0),
                userData.when(
                  data: (data) => Center(
                    child: Text(
                      data != null ? data['name'] : "N/A",
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  error: (error, stackTrace) =>
                      const Text("Something Went Wrong"),
                  loading: () => const Center(
                    child: Text("Loading..."),
                  ),
                ),
                heightSizedBox(20.0),
                ListTile(
                  leading: const Icon(
                    Icons.home_outlined,
                    size: 35,
                  ),
                  onTap: () {
                    navigationPush(context, const SalesDashboard());
                  },
                  title: Text(
                    "Home",
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  shape: Border(
                      bottom: BorderSide(
                    color: Colors.black.withOpacity(0.09),
                  )),
                ),
                dealer == 'dealer'
                    ? DrawerElement(
                        src: "assets/images/dashboard.svg",
                        title: "Sales Dashboard",
                        onTap: () {
                          navigationPush(context, const SalesDashboard());
                        },
                      )
                    : ExpansionTile(
                        leading:
                            SvgPicture.asset("assets/images/dashboard.svg"),
                        title: Text(
                          "Sales",
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        children: [
                          ListTile(
                            title: Text(
                              "Sales Dashboard",
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            onTap: () {
                              navigationPush(context, const SalesDashboard());
                            },
                          ),
                          ListTile(
                            title: Text(
                              "Sales Data Upload",
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            onTap: () {
                              navigationPush(context, const UploadSalesData());
                            },
                          ),
                          ListTile(
                            title: Text(
                              "Model Data Upload",
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            onTap: () {
                              navigationPush(context, const UploadModelData());
                            },
                          ),
                          ListTile(
                            title: Text(
                              "Segment Target Upload",
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            onTap: () {
                              navigationPush(
                                  context, const UploadSegmentTarget());
                            },
                          ),
                          ListTile(
                            title: Text(
                              "Channel Target Upload",
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            onTap: () {
                              navigationPush(
                                  context, const UploadChannelTarget());
                            },
                          ),
                        ],
                      ),
                dealer == 'dealer'
                    ? DrawerElement(
                        src: "assets/images/finance.svg",
                        title: "Finance Dashboard",
                        onTap: () {
                          navigationPush(context, const SalesDashboard());
                        },
                      )
                    : ExpansionTile(
                        leading: SvgPicture.asset("assets/images/finance.svg"),
                        title: Text(
                          "Finance",
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        children: [
                          ListTile(
                            title: const Text("Finance Dashboard"),
                            onTap: () {
                              navigationPush(context, const UploadSalesData());
                            },
                          ),
                          ListTile(
                            title: const Text("Upload Finance Data"),
                            onTap: () {
                              // navigationPush(context, const UploadSalesData());
                            },
                          ),
                          ListTile(
                            title: const Text("Payment Calculator"),
                            onTap: () {
                              // navigationPush(context, const UploadSalesData());
                            },
                          ),
                        ],
                      ),
                DrawerElement(
                  src: "assets/images/attendance.svg",
                  title: "Attendance",
                  onTap: () {},
                ),
                // dealer == "dealer"
                //     ? const SizedBox()
                //     : ListTile(
                //         title: Text(
                //           "Pulse Data Upload",
                //           style: GoogleFonts.lato(
                //             textStyle: const TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 20,
                //             ),
                //           ),
                //         ),
                //         onTap: () {
                //           navigationPush(context, const PulseDataUpload());
                //         },
                //       ),
                dealer == "dealer"
                    ? const SizedBox()
                    : ListTile(
                        title: Text(
                          "Extraction Data Upload",
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        onTap: () {
                          navigationPush(context, const ExtractionDataScreen());
                        },
                      ),
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    return ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: Text(
                        "Logout",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Logout'),
                              content: const Text(
                                  'Are you sure you want to logout?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('No'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Yes'),
                                  onPressed: () async {
                                    // Clear secure storage data
                                    await ref
                                        .read(secureStoargeProvider)
                                        .clearData();

                                    // Invalidate providers to reset state
                                    ref.invalidate(userProfileProvider);
                                    ref.invalidate(dealerProfileProvider);
                                    ref.invalidate(dealerCodeProvider);

                                    // Close the dialog before navigating
                                    Navigator.of(context).pop();

                                    // Navigate to SplashScreen
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SplashScreen()),
                                      (route) => false,
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Column(
              children: [
                SvgPicture.asset(
                  "assets/images/splashlogo.svg",
                  height: 60,
                  width: 150,
                ),
                heightSizedBox(8.0),
                SvgPicture.asset(
                  "assets/images/siddhaconnect.svg",
                  height: 13,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerElement extends StatelessWidget {
  final String src;
  final String title;
  final Function() onTap;

  const DrawerElement({
    super.key,
    required this.src,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(src),
      onTap: onTap,
      title: Text(
        title,
        style: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      shape: Border(
        bottom: BorderSide(
          color: Colors.black.withOpacity(0.09),
        ),
      ),
    );
  }
}
