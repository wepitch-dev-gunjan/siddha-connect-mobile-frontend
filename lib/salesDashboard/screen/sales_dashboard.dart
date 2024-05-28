import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/salesDashboard/repo/sales_dashboard_repo.dart';
import 'package:siddha_connect/utils/common_style.dart';
import 'package:siddha_connect/utils/sizes.dart';
import '../component/date_picker.dart';
import '../component/sales_data_show.dart';

final getSalesDashboardProvider = FutureProvider((ref) {
  final getRepo = ref.watch(salesRepoProvider).getSalesDashboardData();
  return getRepo;
});

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
        backgroundColor: AppColor.whiteColor,
      ),
      appBar: AppBar(
        foregroundColor: AppColor.whiteColor,
        backgroundColor: AppColor.primaryColor,
        titleSpacing: 10,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CusRadio(
                    text1: "YTD",
                    text: "MTD",
                    selectedOption: selectedOption1,
                    onChanged: (value) {
                      setState(() {
                        selectedOption1 = value!;
                      });
                    },
                    options: const ["YTD", "MTD"],
                    labels: const ["YTD", "MTD"],
                  ),
                  const Spacer(),
                  CusRadio(
                    text1: "Value",
                    text: "Volume",
                    selectedOption: selectedOption1,
                    onChanged: (value) {
                      setState(() {
                        selectedOption1 = value!;
                      });
                    },
                    options: const ["YTD", "MTD"],
                    labels: const ["YTD", "MTD"],
                  )
                ],
              ),
              heightSizedBox(10.0),
              Container(
                height: 40.h,
                width: 400,
                decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(11)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      DatePIckerComponent(
                        year: "2023",
                        month: "April",
                      ),
                      Spacer(),
                      DatePIckerComponent(
                        year: "2024",
                        month: "April",
                      ),
                    ],
                  ),
                ),
              ),

              const SalesDashboardCard(),

              //
            ],
          ),
        ),
      ),
    );
  }
}
