import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/salesDashboard/component/radio.dart';
import 'package:siddha_connect/utils/common_style.dart';
import 'package:siddha_connect/utils/message.dart';
import '../../utils/cus_appbar.dart';
import '../../utils/drawer.dart';
import '../../utils/providers.dart';
import '../component/dashboard_small_btn.dart';
import '../component/date_picker.dart';
import '../component/sales_data_show.dart';
import '../component/dashboard_full_btn.dart';

// class SalesDashboard extends ConsumerWidget {
//   final String initialOption;
//   const SalesDashboard({
//     super.key,
//     this.initialOption = 'MTD',
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(selectedOption1Provider.notifier).state = initialOption;
//     });
//     // this provider call for dealer info
//     final dealerInfo = ref.watch(dealerProvider);
//     return PopScope(
//       canPop: false,
//       onPopInvoked: (didPop) {
//         SystemNavigator.pop();
//       },
//       child: const Scaffold(
//         backgroundColor: AppColor.whiteColor,
//         drawer: CusDrawer(),
//         appBar: CustomAppBar(),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               TopRadioButtons(),
//               DatePickerContainer(),
//               SalesDashboardCard(),
//               SmallCusBtn(),
//               FullSizeBtn()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io'; // Import required for exit(0)

class SalesDashboard extends ConsumerWidget {
  final String initialOption;
  const SalesDashboard({
    super.key,
    this.initialOption = 'MTD',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime? lastBackPressTime;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(selectedOption1Provider.notifier).state = initialOption;
    });

    // this provider call for dealer info
    final dealerInfo = ref.watch(dealerProvider);

    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        if (lastBackPressTime == null ||
            now.difference(lastBackPressTime!) > const Duration(seconds: 2)) {
          lastBackPressTime = now;

          showSnackBarMsg("Press back again to exit",
              duration: const Duration(seconds: 2));
          return false;
        }
        exit(0);
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
            ],
          ),
        ),
      ),
    );
  }
}

class YTDSalesDashboard extends ConsumerWidget {
  final String initialOption;
  const YTDSalesDashboard({
    super.key,
    this.initialOption = 'MTD',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(selectedOption1Provider.notifier).state = initialOption;
    });
    // this provider call for dealer info
    final dealerInfo = ref.watch(dealerProvider);
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
              YTDTopRadioButtons(),
              DatePickerContainer(),
              SalesDashboardCard(),
              SmallCusBtn(),
              FullSizeBtn()
            ],
          ),
        ),
      ),
    );
  }
}
