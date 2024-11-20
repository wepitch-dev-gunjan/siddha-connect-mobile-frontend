import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/auth/screens/splash_screen.dart';
import 'package:siddha_connect/extraction/screens/pulse_data_upload.dart';
import 'package:siddha_connect/profile/repo/profile_repo.dart';
import 'package:siddha_connect/extraction/screens/extraction_data_upload.dart';
import 'package:siddha_connect/extraction/screens/extraction_report.dart';
import 'package:siddha_connect/uploadSalesData/screens/upload_channel_targets.dart';
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
              // padding: EdgeInsets.zero,
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
                heightSizedBox(10.0),
                ListTile(
                  leading: const Icon(Icons.home, size: 35),
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
                ),
                dealer == 'dealer'
                    ? DrawerElement(
                        src: "assets/images/dashboard.svg",
                        title: "Sales Dashboard",
                        onTap: () {
                          navigationPush(context, const SalesDashboard());
                        },
                      )
// =============================! Sales Dashboard !==========================
                    : CusExpensionTile(
                        title: "Sales",
                        src: "assets/images/dashboard.svg",
                        children: [
                          CusListTile(
                              title: "Sales Dashboard",
                              onTap: () {
                                navigationPush(context, const SalesDashboard());
                              }),
                          CusListTile(
                              title: "Sales Data Upload",
                              onTap: () {
                                navigationPush(
                                    context, const UploadSalesData());
                              }),
                          CusListTile(
                              title: "Model Data Upload",
                              onTap: () {
                                navigationPush(
                                    context, const UploadModelData());
                              }),
                          CusListTile(
                              title: "Segment Target Upload",
                              onTap: () {
                                navigationPush(
                                    context, const UploadSegmentTarget());
                              }),
                          CusListTile(
                              title: "Channel Target Upload",
                              onTap: () {
                                navigationPush(
                                    context, const UploadChannelTarget());
                              }),
                        ],
                      ),

//==================================! Finance Dashboard !=======================                      
                dealer == 'dealer'
                    ? DrawerElement(
                        src: "assets/images/finance.svg",
                        title: "Finance Dashboard",
                        onTap: () {
                          navigationPush(context, const SalesDashboard());
                        },
                      )
                    : CusExpensionTile(
                        src: "assets/images/finance.svg",
                        title: "Finance",
                        children: [
                            CusListTile(
                                title: "Finance Dashboard", onTap: () {}),
                            CusListTile(
                                title: "Upload Finance Data", onTap: () {})
                          ]),


//===============================! Atteneance !====================================


                // DrawerElement(
                //   src: "assets/images/attendance.svg",
                //   title: "Attendance",
                //   onTap: () {},
                // ),

//================================== ! Pulse Dashboard !==============================
                // CusExpensionTile(
                //   title: "Pulse",
                //   icon: Icons.monitor_heart_outlined,
                //   children: [
                //     CusListTile(
                //         title: "Pulse Data Upload",
                //         onTap: () {
                //           navigationPush(context, const PulseDataScreen());
                //         }),
                //   ],
                // ),


//==================================! Extraction Dashboard !=========================
                dealer == "dealer"
                    ? const SizedBox()
                    : CusExpensionTile(
                        title: "Extraction",
                        icon: Icons.data_exploration_outlined,
                        children: [
                          CusListTile(
                              title: "Extraction Report",
                              onTap: () {
                                // navigationPush(context, const PulseDataScreen());
                                navigationPush(
                                    context, const ExtractionReport());
                              }),
                          CusListTile(
                              title: "Extraction Data Upload",
                              onTap: () {
                                navigationPush(
                                    context, const ExtractionDataScreen());
                              }),
                        ],
                      ),
// ========================= ! Log Out ! ================================

                const Logout(),
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

class CusExpensionTile extends StatelessWidget {
  final String? src;
  final String title;
  final IconData? icon;
  final List<Widget> children;
  const CusExpensionTile({
    super.key,
    this.src,
    required this.title,
    required this.children,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: Colors.black,
      leading: _getLeadingWidget(),
      title: Text(
        title,
        style: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      children: children,
    );
  }

  Widget _getLeadingWidget() {
    if (src != null && src!.isNotEmpty) {
      return SvgPicture.asset(src!);
    } else if (icon != null) {
      return Icon(
        icon,
        size: 32.0,
        color: Colors.black,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class CusListTile extends StatelessWidget {
  final String title;
  final Function() onTap;
  final FontWeight? fontWeight;
  final double? fontSize;
  const CusListTile(
      {super.key,
      required this.title,
      required this.onTap,
      this.fontWeight,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          title,
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: fontSize ?? 14.0,
              fontWeight: fontWeight ?? FontWeight.w600,
            ),
          ),
        ),
        onTap: onTap);
  }
}

class Logout extends StatelessWidget {
  const Logout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return ListTile(
          leading: const Icon(
            Icons.logout,
            color: Colors.red,
            size: 30,
          ),
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
                  backgroundColor: Colors.white,
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
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
                        await ref.read(secureStoargeProvider).clearData();
                        ref.invalidate(userProfileProvider);
                        ref.invalidate(dealerProfileProvider);
                        ref.invalidate(dealerCodeProvider);
                        navigationPop();

                        navigationRemoveUntil(const SplashScreen());
                        // Navigator.pushAndRemoveUntil(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           const SplashScreen()),
                        //   (route) => false,
                        // );
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      },
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
      // dense: true,
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
      // shape: Border(
      //     bottom: BorderSide(
      //   color: Colors.black.withOpacity(0.09),
      // )),
    );
  }
}
