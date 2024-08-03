import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/auth/screens/login_screen.dart';
import 'package:siddha_connect/uploadSalesData/screens/upload_sales_data.dart';
import 'package:siddha_connect/utils/navigation.dart';
import '../salesDashboard/screen/sales_dashboard.dart';
import 'common_style.dart';
import 'secure_storage.dart';
import 'sizes.dart';

class CusDrawer extends StatefulWidget {
  const CusDrawer({super.key});

  @override
  State<CusDrawer> createState() => _CusDrawerState();
}

class _CusDrawerState extends State<CusDrawer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
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
                    "assets/images/image.png",
                    height: 88,
                    width: 88,
                  ),
                ),
                heightSizedBox(10.0),
                Center(
                  child: Text(
                    'SIDDHA',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.green,
                      ),
                    ),
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
                DrawerElement(
                  src: "assets/images/dashboard.svg",
                  title: "Sales Dashboard",
                  onTap: () {
                    navigationPush(context, const SalesDashboard());
                  },
                ),
                DrawerElement(
                  src: "assets/images/finance.svg",
                  title: "Finance Dashboard",
                  onTap: () {},
                ),
                DrawerElement(
                  src: "assets/images/attendance.svg",
                  title: "Attendance",
                  onTap: () {},
                ),
                ExpansionTile(
                  leading: SvgPicture.asset("assets/images/upload.svg"),
                  title: Text(
                    "Upload Sales Data",
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text("Option 1"),
                      onTap: () {
                        navigationPush(context, const UploadSalesData());
                      },
                    ),
                    ListTile(
                      title: Text("Option 2"),
                      onTap: () {
                        navigationPush(context, const UploadSalesData());
                      },
                    ),
                  ],
                ),
                Consumer(builder:
                    (BuildContext context, WidgetRef ref, Widget? child) {
                  return ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: Text(
                        "Logout",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.red),
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
                                  onPressed: () {
                                    ref
                                        .read(secureStoargeProvider)
                                        .deleteData("authToken");
                                       
                                    navigateTo(LoginScreen());
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                })
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
