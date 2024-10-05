import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siddha_connect/salesDashboard/component/radio.dart';
import '../../common/dashboard_options.dart';
import '../../utils/providers.dart';
import '../../utils/sizes.dart';
import '../repo/sales_dashboard_repo.dart';
import 'dashboard_small_btn.dart';
import 'shimmer.dart';

final getSalesDashboardProvider = FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final user = await ref.watch(userProvider.future);
  final salesRepo = ref.watch(salesRepoProvider);

  final data = await salesRepo.getSalesDashboardData(
    tdFormat: options.tdFormat,
    dataFormat: options.dataFormat,
    firstDate: options.firstDate,
    lastDate: options.lastDate,
  );
  return data;
});

final getSalesDashboardDataByEmployeeName =
    FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final user = await ref.watch(userProvider.future);
  final salesRepo = ref.watch(salesRepoProvider);

  final data = await salesRepo.getSalesDashboardDataByEmployeeName(
      tdFormat: options.tdFormat,
      dataFormat: options.dataFormat,
      firstDate: options.firstDate,
      lastDate: options.lastDate,
      position: options.position!.toUpperCase(),
      name: options.name);
  return data;
});

final getDealerDashboardProvider = FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final dealerCode = ref.read(dealerCodeProvider);
  final salesRepo = ref.watch(salesRepoProvider);
  final data = await salesRepo.getDealerDashboardData(
    tdFormat: options.tdFormat,
    dataFormat: options.dataFormat,
    startDate: options.firstDate,
    endDate: options.lastDate,
  );
  return data;
});

final getSalesDataByDealerCodeProvider =
    FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final dealerCode = ref.read(selectedDealerProvider);
  final salesRepo = ref.watch(salesRepoProvider);
  final data = await salesRepo.getSalesDashboardDataByDealerCode(
      tdFormat: options.tdFormat,
      dataFormat: options.dataFormat,
      firstDate: options.firstDate,
      lastDate: options.lastDate,
      dealerCode: dealerCode);
  return data;
});

class SalesDashboardCard extends ConsumerWidget {
  const SalesDashboardCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final dealerRole = ref.watch(dealerRoleProvider);
    final dealerName = ref.watch(dealerNameProvider);
    final dataByEmployeeName = ref.watch(getSalesDashboardDataByEmployeeName);
    final position = ref.watch(selectedPositionProvider);
    final dealerData = ref.watch(getSalesDataByDealerCodeProvider);
    final selectedPosition=ref.watch(selectedPositionProvider);
    


  final dashboardData = (selectedPosition == 'DEALER')
    ? ref.watch(getSalesDataByDealerCodeProvider) 
    : (dealerRole == 'dealer')
        ? ref.watch(getDealerDashboardProvider) // dealer role hai toh dealer dashboard ki API call ho
        : (position != 'All')
            ? ref.watch(getSalesDashboardDataByEmployeeName) // position 'All' nahi hai toh employee name ke hisaab se data fetch ho
            : ref.watch(getSalesDashboardProvider); // warna sales dashboard ki API call ho


    return dashboardData.when(
        data: (data) {
          if (data == null || data.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 60),
              child: Center(child: Text("No data available")),
            );
          }
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
                      value: data['td_sell_in'] ?? 'N/A',
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
                      value: data['ltd_sell_in'] ?? 'N/A',
                    ),
                    DashboardComp(
                      titleSize: 14.sp,
                      title: "Growth % \n",
                      value: data["sell_in_growth"] ?? '0%',
                      valueColor: (data["sell_in_growth"] ?? '0')[0] == '-'
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
                      value: data['td_sell_out'] ?? 'N/A',
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
                      value: data['ltd_sell_out'] ?? 'N/A',
                    ),
                    DashboardComp(
                      titleSize: 14.sp,
                      title: "Growth % \n",
                      value: data["sell_out_growth"] ?? '0%',
                      valueColor: (data["sell_out_growth"] ?? '0')[0] == '-'
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
