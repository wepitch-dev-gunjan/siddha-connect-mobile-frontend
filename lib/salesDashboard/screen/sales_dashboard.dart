import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/salesDashboard/component/radio.dart';
import 'package:siddha_connect/utils/common_style.dart';
import '../../utils/cus_appbar.dart';
import '../../utils/drawer.dart';
import '../../utils/providers.dart';
import '../component/btn.dart';
import '../component/date_picker.dart';
import '../component/sales_data_show.dart';

class SalesDashboard extends ConsumerWidget {
  const SalesDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final userProfile = ref.watch(getProfileProvider);
    // final selectedBtn = ref.watch(selectedIndexProvider);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        SystemNavigator.pop();
      },
      child: const Scaffold(
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
              FullSizeBtn()
              // if (selectedBtn == 0) const FullSizeBtn(),
              // if (selectedBtn != 0) const FullSizeBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
