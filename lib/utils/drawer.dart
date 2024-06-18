import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/uploadSalesData/upload_sales_data.dart';
import 'package:siddha_connect/utils/navigation.dart';
import '../salesDashboard/screen/sales_dashboard.dart';
import 'common_style.dart';
import 'sizes.dart';

class CusDrawer extends StatelessWidget {
  const CusDrawer({super.key});

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
                        color: Color(0xff1F0A68),
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
                DrawerElement(
                  src: "assets/images/upload.svg",
                  title: "Upload Sales Data",
                  onTap: () {
                    navigationPush(context, const UploadSalesData());
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
      leading: SvgPicture.asset(
        src,
      ),
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
