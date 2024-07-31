import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/salesDashboard/component/radio.dart';
import 'package:siddha_connect/salesDashboard/tables/abm_table.dart';
import 'package:siddha_connect/salesDashboard/tables/area_table.dart';
import 'package:siddha_connect/salesDashboard/tables/asm_table.dart';
import 'package:siddha_connect/salesDashboard/tables/rso_table.dart';
import 'package:siddha_connect/salesDashboard/tables/tse_table.dart';
import 'package:siddha_connect/utils/common_style.dart';
import '../../utils/cus_appbar.dart';
import '../../utils/drawer.dart';
import '../component/btn.dart';
import '../component/date_picker.dart';
import '../component/sales_data_show.dart';

class SalesDashboard extends ConsumerWidget {
  const SalesDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBtn = ref.watch(selectedIndexProvider);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        drawer: const CusDrawer(),
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const TopRadioButtons(),
              const DatePickerContainer(),
              const SalesDashboardCard(),
              const SmallCusBtn(),
              // if (selectedBtn == 0) TseTable(),
              // if (selectedBtn == 1) const TseTable(),
              // if (selectedBtn == 2) const AreaTable(),
              // if (selectedBtn == 3) const AbmTable(),
              // if (selectedBtn == 4) const AsmTable(),
              // if (selectedBtn == 5) const RsoTable(),
              const FullSizeBtn()
            ],
          ),
        ),
      ),
    );
  }
}
