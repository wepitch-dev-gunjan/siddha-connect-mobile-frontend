import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siddha_connect/salesDashboard/component/radio.dart';
import '../../utils/sizes.dart';
import '../repo/sales_dashboard_repo.dart';
import 'shimmer.dart';

class DashboardOptions {
  final String tdFormat;
  final String dataFormat;
  DashboardOptions({required this.tdFormat, required this.dataFormat});
}

final selectedOptionsProvider = StateProvider<DashboardOptions>((ref) {
  final selectedOption1 = ref.watch(selectedOption1Provider);
  final selectedOption2 = ref.watch(selectedOption2Provider);
  return DashboardOptions(
    tdFormat: selectedOption1,
    dataFormat: selectedOption2,
  );
});

final getSalesDashboardProvider = FutureProvider.autoDispose((ref) async {

  final options = ref.watch(selectedOptionsProvider);
  final salesRepo = ref.watch(salesRepoProvider);
  final data = await salesRepo.getSalesDashboardData(
    tdFormet: options.tdFormat,
    dataFormet: options.dataFormat,
  );
  return data;
});

class SalesDashboardCard extends ConsumerWidget {
  const SalesDashboardCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardData = ref.watch(getSalesDashboardProvider);
    return dashboardData.when(
        data: (data) {
          final selectedOption1 = ref.watch(selectedOption1Provider);
          final selectedOption2 = ref.watch(selectedOption2Provider);

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
                              selectedOption2 == 'value')
                          ? "YTD Sell in Value"
                          : (selectedOption1 == 'MTD' &&
                                  selectedOption2 == 'value')
                              ? "MTD Sell in Value"
                              : (selectedOption1 == 'YTD' &&
                                      selectedOption2 == 'volume')
                                  ? "YTD Sell in Volume"
                                  : (selectedOption1 == 'MTD' &&
                                          selectedOption2 == 'volume')
                                      ? "MTD Sell in Volume"
                                      : "MTD Sell in Value",
                      value: data['td_sell_in'],
                    ),
                    DashboardComp(
                      title: (selectedOption1 == 'YTD' &&
                              selectedOption2 == 'value')
                          ? "LYTD Sell in Value"
                          : (selectedOption1 == 'MTD' &&
                                  selectedOption2 == 'value')
                              ? "LMTD Sell in Value"
                              : (selectedOption1 == 'YTD' &&
                                      selectedOption2 == 'volume')
                                  ? "LYTD Sell in Volume"
                                  : (selectedOption1 == 'MTD' &&
                                          selectedOption2 == 'volume')
                                      ? "LMTD Sell in Volume"
                                      : "LMTD Sell in Value",
                      value: data['ltd_sell_in'],
                    ),
                    DashboardComp(
                      titleSize: 14.sp,
                      title: "Growth % \n",
                      value: data["sell_in_growth"],
                      valueColor: data["sell_in_growth"][0] == '-'
                          ? Colors.red
                          : Colors.green,
                    ),
                  ],
                ),
                heightSizedBox(5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DashboardComp(
                      title: (selectedOption1 == 'YTD' &&
                              selectedOption2 == 'value')
                          ? "YTD Sell out Value"
                          : (selectedOption1 == 'MTD' &&
                                  selectedOption2 == 'value')
                              ? "MTD Sell out Value"
                              : (selectedOption1 == 'YTD' &&
                                      selectedOption2 == 'volume')
                                  ? "YTD Sell out Volume"
                                  : (selectedOption1 == 'MTD' &&
                                          selectedOption2 == 'volume')
                                      ? "MTD Sell out Volume"
                                      : "MTD Sell out Value",
                      value: data['td_sell_out'],
                    ),
                    DashboardComp(
                      title: (selectedOption1 == 'YTD' &&
                              selectedOption2 == 'value')
                          ? "LYTD Sell out Value"
                          : (selectedOption1 == 'MTD' &&
                                  selectedOption2 == 'value')
                              ? "LMTD Sell out Value"
                              : (selectedOption1 == 'YTD' &&
                                      selectedOption2 == 'volume')
                                  ? "LYTD Sell out Volume"
                                  : (selectedOption1 == 'MTD' &&
                                          selectedOption2 == 'volume')
                                      ? "LMTD Sell out Volume"
                                      : "LMTD Sell out Value",
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
