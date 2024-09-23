import 'dart:developer';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/utils/providers.dart';
import '../../utils/common_style.dart';
import '../repo/sales_dashboard_repo.dart';
import 'segment_position_wise.dart';
import 'segment_table.dart';

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
        if (data == null ||
            data['columnNames'] == null ||
            data['data'] == null) {
          return const Center(child: Text('No data available.'));
        }

        final columns =
            dealerRole == "dealer" ? data['column'] : data['columnNames'] ?? [];
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
              // fixedLeftColumns: 1,
              // fixedColumnsColor: Colors.green,
              // fixedCornerColor: Colors.red,
              showBottomBorder: true,
              minWidth: 2000,
              // columnSpacing: 40,
              headingRowColor: WidgetStateColor.resolveWith(
                (states) => const Color(0xffD9D9D9),
              ),

              columns: [
                for (var column in columns)
                  DataColumn(
                    label: Text(
                      column ?? 'Unknown',
                      textAlign: TextAlign.center,
                      style: topStyle,
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
                    DataCell(Text(row['Category Wise']?.toString() ?? '')),
                    DataCell(Text(row['Target Vol']?.toString() ?? '')),
                    DataCell(Text(row['Mtd Vol']?.toString() ?? '')),
                    DataCell(Text(row['Lmtd Vol']?.toString() ?? '')),
                    DataCell(Text(row['Pending Vol']?.toString() ?? '')),
                    DataCell(Text(row['ADS']?.toString() ?? '')),
                    DataCell(Text(row['Req. ADS']?.toString() ?? '')),
                    DataCell(Text(row['% Gwth Vol']?.toString() ?? '')),
                    DataCell(Text(row['Target SO']?.toString() ?? '')),
                    DataCell(Text(row['Activation MTD']?.toString() ?? '')),
                    DataCell(Text(row['Activation LMTD']?.toString() ?? '')),
                    DataCell(Text(row['Pending Act']?.toString() ?? '')),
                    DataCell(Text(row['ADS Activation']?.toString() ?? '')),
                    DataCell(
                        Text(row['Req. ADS Activation']?.toString() ?? '')),
                    DataCell(Text(row['% Gwth Val']?.toString() ?? '')),
                    DataCell(Text(row['FTD']?.toString() ?? '')),
                    DataCell(Text(row['Contribution %']?.toString() ?? '')),
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

class ChannelTablePositionWise extends ConsumerWidget {
  const ChannelTablePositionWise({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth / 12;
    final channelData = ref.watch(getChannelDataPositionWiseProvider);

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
              // fixedLeftColumns: 1,
              // fixedColumnsColor: Colors.green,
              // fixedCornerColor: Colors.red,
              showBottomBorder: true,
              minWidth: 2000,
              // columnSpacing: 40,
              headingRowColor: WidgetStateColor.resolveWith(
                (states) => const Color(0xffD9D9D9),
              ),

              columns: [
                for (var column in columns)
                  DataColumn(
                    label: Text(
                      column ?? 'Unknown',
                      textAlign: TextAlign.center,
                      style: topStyle,
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
                    DataCell(Text(row['Category Wise']?.toString() ?? '')),
                    DataCell(Text(row['Target Vol']?.toString() ?? '')),
                    DataCell(Text(row['Mtd Vol']?.toString() ?? '')),
                    DataCell(Text(row['Lmtd Vol']?.toString() ?? '')),
                    DataCell(Text(row['Pending Vol']?.toString() ?? '')),
                    DataCell(Text(row['ADS']?.toString() ?? '')),
                    DataCell(Text(row['Req. ADS']?.toString() ?? '')),
                    DataCell(Text(row['% Gwth Vol']?.toString() ?? '')),
                    DataCell(Text(row['Target SO']?.toString() ?? '')),
                    DataCell(Text(row['Activation MTD']?.toString() ?? '')),
                    DataCell(Text(row['Activation LMTD']?.toString() ?? '')),
                    DataCell(Text(row['Pending Act']?.toString() ?? '')),
                    DataCell(Text(row['ADS Activation']?.toString() ?? '')),
                    DataCell(
                        Text(row['Req. ADS Activation']?.toString() ?? '')),
                    DataCell(Text(row['% Gwth Val']?.toString() ?? '')),
                    DataCell(Text(row['FTD']?.toString() ?? '')),
                    DataCell(Text(row['Contribution %']?.toString() ?? '')),
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
