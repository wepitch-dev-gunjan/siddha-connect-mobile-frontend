import 'package:flutter/material.dart';
import 'package:siddha_connect/salesDashboard/component/radio.dart';
import 'package:siddha_connect/utils/common_style.dart';
import '../../utils/cus_appbar.dart';
import '../../utils/drawer.dart';
import '../component/btn.dart';
import '../component/date_picker.dart';
import '../component/sales_data_show.dart';


class SalesDashboard extends StatefulWidget {
  const SalesDashboard({super.key});

  @override
  State<SalesDashboard> createState() => _SalesDashboardState();
}

class _SalesDashboardState extends State<SalesDashboard> {
  // String selectedOption1 = "YTD";
  // String selectedOption2 = "Value";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColor.whiteColor,
      drawer: CusDrawer(),
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
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

