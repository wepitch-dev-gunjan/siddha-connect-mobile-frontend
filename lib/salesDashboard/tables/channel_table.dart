import 'dart:developer';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siddha_connect/utils/providers.dart';
import '../../common/dashboard_options.dart';
import '../../utils/common_style.dart';
import '../../utils/responsive.dart';
import '../component/dashboard_small_btn.dart';
import '../repo/sales_dashboard_repo.dart';
import 'segment_position_wise.dart';

final getChannelDataProvider = FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final getChanelData = await ref.watch(salesRepoProvider).getChannelWiseData(
      tdFormat: options.tdFormat,
      dataFormat: options.dataFormat,
      firstDate: options.firstDate,
      lastDate: options.lastDate);
  return getChanelData;
});

final getDealerChannelDataProvider = FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final getChanelData = await ref.watch(salesRepoProvider).getDealerChannelData(
      tdFormat: options.tdFormat,
      dataFormat: options.dataFormat,
      startDate: options.firstDate,
      endDate: options.lastDate);
  ref.keepAlive();
  return getChanelData;
});

class ChannelTable extends ConsumerWidget {
  const ChannelTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dealerRole = ref.watch(dealerRoleProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth / 12;
    final channelData = dealerRole == 'dealer'
        ? ref.watch(getDealerChannelDataProvider)
        : ref.watch(getChannelDataProvider);
    return channelData.when(
      data: (data) {
        log("I Am in Dealer");
        if (data == null || data['data'] == null) {
          return const Center(child: Text('No data available.'));
        }

        final columns = dealerRole == "dealer"
            ? data['columns']
            : data['columnNames'] ?? [];
        final rows = data['data'] ?? [];
        return Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: const DividerThemeData(
              color: Colors.white,
            ),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2.2,
            child: DataTable2(
              headingRowHeight: 50,
              dividerThickness: 2.5,
              columnSpacing: columnSpacing,
              fixedTopRows: 2,
              horizontalMargin: 0,
              fixedLeftColumns: 1,
              fixedColumnsColor: const Color(0xffEEEEEE),
              fixedCornerColor: const Color(0xffD9D9D9),
              bottomMargin: 5,
              showBottomBorder: true,
              minWidth: Responsive.isTablet(context) ? 1200.w : 2000.w,
              // columnSpacing: 40,
              headingRowColor: WidgetStateColor.resolveWith(
                (states) => const Color(0xffD9D9D9),
              ),

              columns: [
                for (var column in columns)
                  DataColumn(
                    label: Center(
                      child: Text(
                        column ?? 'Unknown',
                        textAlign: TextAlign.center,
                        style: tableTitleStyle(context),
                      ),
                    ),
                  ),
              ],
              rows: List.generate(rows.length, (index) {
                final row = rows[index] ?? {};

                return DataRow(
                  color: WidgetStateColor.resolveWith(
                    (states) => const Color(0xffEEEEEE),
                  ),
                  cells: [
                    DataCell(Center(
                        child: Text(row['Category Wise']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['Target Vol']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['Mtd Vol']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['Lmtd Vol']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['Pending Vol']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['ADS']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['Req. ADS']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['% Gwth Vol']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['Target SO']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['Activation MTD']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['Activation LMTD']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['Pending Act']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['ADS Activation']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Text(row['Req. ADS Activation']?.toString() ?? '',
                        style: tableRowStyle(context))),
                    DataCell(Center(
                        child: Text(row['% Gwth Val']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['FTD']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['Contribution %']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                  ],
                );
              }),
            ),
          ),
        );
      },
      error: (error, stackTrace) => const Center(
        child: Text("Something Went Wrong"),
      ),
      loading: () => const Padding(
        padding: EdgeInsets.only(top: 150),
        child: Center(
          child: CircularProgressIndicator(
            color: AppColor.primaryColor,
          ),
        ),
      ),
    );
  }
}

final getChannelDataPositionWiseProvider =
    FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final getChanelData = await ref
      .watch(salesRepoProvider)
      .getChannelPositionWiseData(
          tdFormat: options.tdFormat,
          dataFormat: options.dataFormat,
          firstDate: options.firstDate,
          lastDate: options.lastDate,
          name: options.name,
          position: options.position!.toUpperCase());
  return getChanelData;
});

final getSalesDataChannelWiseForEmployee =
    FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final getPositionSegmentData = await ref
      .watch(salesRepoProvider)
      .getSalesDataChannelWiseForEmployes(
          tdFormat: options.tdFormat,
          dataFormat: options.dataFormat,
          firstDate: options.firstDate,
          lastDate: options.lastDate,
          dealerCode: options.dealerCode);
  return getPositionSegmentData;
});

class ChannelTablePositionWise extends ConsumerWidget {
  const ChannelTablePositionWise({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final selectedPosition = ref.watch(selectedPositionProvider);
    final columnSpacing = screenWidth / 12;
    final channelData = selectedPosition == "DEALER"
        ? ref.watch(getSalesDataChannelWiseForEmployee)
        : ref.watch(getChannelDataPositionWiseProvider);

    return channelData.when(
      data: (data) {
        if (data == null || data['columns'] == null || data['data'] == null) {
          return const Center(child: Text('No data available.'));
        }

        final columns = data['columns'] ?? [];
        final rows = data['data'] ?? [];
        return Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: const DividerThemeData(
              color: Colors.white,
            ),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2.2,
            child: DataTable2(
              headingRowHeight: 50,
              dividerThickness: 2.5,
              columnSpacing: columnSpacing,
              fixedTopRows: 2,
              horizontalMargin: 0,
              bottomMargin: 5,
              fixedLeftColumns: 1,
              fixedColumnsColor: const Color(0xffEEEEEE),
              fixedCornerColor: const Color(0xffD9D9D9),
              showBottomBorder: true,
              minWidth: Responsive.isTablet(context) ? 1200.w : 2000.w,
              headingRowColor: WidgetStateColor.resolveWith(
                (states) => const Color(0xffD9D9D9),
              ),
              columns: [
                for (var column in columns)
                  DataColumn(
                    label: Center(
                      child: Text(
                        column ?? 'Unknown',
                        textAlign: TextAlign.center,
                        style: tableTitleStyle(context),
                      ),
                    ),
                  ),
              ],
              rows: List.generate(rows.length, (index) {
                final row = rows[index] ?? {};

                return DataRow(
                  color: WidgetStateColor.resolveWith(
                    (states) => const Color(0xffEEEEEE),
                  ),
                  cells: [
                    DataCell(Center(
                        child: Text(row['Category Wise']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['Target Vol']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['Mtd Vol']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['Lmtd Vol']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['Pending Vol']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['ADS']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['Req. ADS']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['% Gwth Vol']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['Target SO']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['Activation MTD']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['Activation LMTD']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['Pending Act']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['ADS Activation']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(
                            row['Req. ADS Activation']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['% Gwth Val']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['FTD']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                    DataCell(Center(
                        child: Text(row['Contribution %']?.toString() ?? '',
                            style: tableRowStyle(context)))),
                  ],
                );
              }),
            ),
          ),
        );
      },
      error: (error, stackTrace) => const Center(
        child: Text("Something Went Wrong"),
      ),
      loading: () => const Padding(
        padding: EdgeInsets.only(top: 150),
        child: Center(
          child: CircularProgressIndicator(
            color: AppColor.primaryColor,
          ),
        ),
      ),
    );
  }
}
