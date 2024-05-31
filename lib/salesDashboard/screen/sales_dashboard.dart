import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:siddha_connect/salesDashboard/component/radio.dart';
import 'package:siddha_connect/utils/common_style.dart';
import '../component/btn.dart';
import '../component/date_picker.dart';
import '../component/sales_data_show.dart';

class SalesDashboard extends StatefulWidget {
  const SalesDashboard({super.key});

  @override
  State<SalesDashboard> createState() => _SalesDashboardState();
}

class _SalesDashboardState extends State<SalesDashboard> {
  String selectedOption1 = "YTD";
  String selectedOption2 = "Value";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      drawer: const Drawer(
        shape: BeveledRectangleBorder(),
        width: 261,
        backgroundColor: AppColor.whiteColor,
      ),
      appBar: AppBar(
        foregroundColor: AppColor.whiteColor,
        backgroundColor: AppColor.primaryColor,
        titleSpacing: 0,
        centerTitle: false,
        title: SvgPicture.asset("assets/images/logo.svg"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(
              "assets/images/profile.svg",
              height: 28,
              width: 28,
            ),
          )
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            TopRadioButtons(),
            DatePickerContainer(),
            SalesDashboardCard(),
            SmallCusBtn(),
            FullSizeBtn(),
          ],
        ),
      ),
    );
  }
}
