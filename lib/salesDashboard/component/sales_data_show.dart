import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siddha_connect/salesDashboard/component/radio.dart';
import '../../utils/sizes.dart';
import '../repo/sales_dashboard_repo.dart';
import 'shimmer.dart';

final getSalesDashboardProvider = FutureProvider.autoDispose((ref) {
  final getRepo = ref.watch(salesRepoProvider).getSalesDashboardData();
  return getRepo;
});

// final getSalesDashboardProvider = FutureProvider.autoDispose.family<Map<String, dynamic>, List<String>>((ref, options) async {
//   final selectedOption1 = options[0];
//   final selectedOption2 = options[1];
//   final salesRepo = ref.watch(salesRepoProvider);

//   final data = await salesRepo.getSalesDashboardData( );
//   return data;
// });

class SalesDashboardCard extends ConsumerWidget {
  const SalesDashboardCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardData = ref.watch(getSalesDashboardProvider);
    final selectedOption1 = ref.watch(selectedOption1Provider);
    final selectedOption2 = ref.watch(selectedOption2Provider);
    return dashboardData.when(
        data: (data) {
          return Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              children: [
                heightSizedBox(10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DashboardComp(
                      title: (selectedOption1 == 'YTD' &&
                              selectedOption2 == 'Value')
                          ? "YTD sell in Value"
                          : (selectedOption1 == 'MTD' &&
                                  selectedOption2 == 'Value')
                              ? "MTD sell in Value"
                              : (selectedOption1 == 'YTD' &&
                                      selectedOption2 == 'Volume')
                                  ? "YTD sell in Volume"
                                  : (selectedOption1 == 'MTD' &&
                                          selectedOption2 == 'Volume')
                                      ? "MTD sell in Volume"
                                      : "MTD sell in Value",
                      value: data['ltd_sell_in'],
                    ),
                    DashboardComp(
                      title: (selectedOption1 == 'YTD' &&
                              selectedOption2 == 'Value')
                          ? "LYTD sell in Value"
                          : (selectedOption1 == 'MTD' &&
                                  selectedOption2 == 'Value')
                              ? "LMTD sell in Value"
                              : (selectedOption1 == 'YTD' &&
                                      selectedOption2 == 'Volume')
                                  ? "LYTD sell in Volume"
                                  : (selectedOption1 == 'MTD' &&
                                          selectedOption2 == 'Volume')
                                      ? "LMTD sell in Volume"
                                      : "LMTD sell in Value",
                      value: data['ltd_sell_in'],
                    ),
                    DashboardComp(
                      titleSize: 14.sp,
                      title: "Growth % \n",
                      value: data["sell_in_growth"],
                      valueColor: data["sell_out_growth"][0] == '-'
                          ? Colors.red
                          : Colors.green,
                    ),
                  ],
                ),
                heightSizedBox(10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DashboardComp(
                      title: (selectedOption1 == 'YTD' &&
                              selectedOption2 == 'Value')
                          ? "YTD sell out Value"
                          : (selectedOption1 == 'MTD' &&
                                  selectedOption2 == 'Value')
                              ? "MTD sell out Value"
                              : (selectedOption1 == 'YTD' &&
                                      selectedOption2 == 'Volume')
                                  ? "YTD sell out Volume"
                                  : (selectedOption1 == 'MTD' &&
                                          selectedOption2 == 'Volume')
                                      ? "MTD sell out Volume"
                                      : "MTD sell out Value",
                      value: data['td_sell_out'],
                    ),
                    DashboardComp(
                      title: (selectedOption1 == 'YTD' &&
                              selectedOption2 == 'Value')
                          ? "LYTD sell out Value"
                          : (selectedOption1 == 'MTD' &&
                                  selectedOption2 == 'Value')
                              ? "LMTD sell out Value"
                              : (selectedOption1 == 'YTD' &&
                                      selectedOption2 == 'Volume')
                                  ? "LYTD sell out Volume"
                                  : (selectedOption1 == 'MTD' &&
                                          selectedOption2 == 'Volume')
                                      ? "LMTD sell out Volume"
                                      : "LMTD sell out Value",
                      value: data["ltd_sell_out"],
                    ),
                    DashboardComp(
                      titleSize: 14.sp,
                      title: "Growth % \n",
                      value: data["sell_out_growth"],
                      valueColor: data["sell_out_growth"][0] == '-'
                          ? Colors.red
                          : Colors.green,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) =>
            const Center(child: Text("Something went wrong")),
        loading: () => const DashboardShimmerEffect());
  }
}
