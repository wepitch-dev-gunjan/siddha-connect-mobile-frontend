import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:siddha_connect/salesDashboard/component/date_picker.dart';
import '../../utils/common_style.dart';
import '../component/btn.dart';
import '../component/radio.dart';
import '../repo/sales_dashboard_repo.dart';
import 'segment_position_wise.dart';

class DashboardOptions {
  final String tdFormat;
  final String dataFormat;
  final String firstDate;
  final String lastDate;
  final String? name;
  final String? position;

  DashboardOptions(
      {required this.tdFormat,
      required this.dataFormat,
      required this.firstDate,
      required this.lastDate,
      this.name,
      this.position});
}

final selectedOptionsProvider =
    StateProvider.autoDispose<DashboardOptions>((ref) {
  final selectedOption1 = ref.watch(selectedOption1Provider);
  final selectedOption2 = ref.watch(selectedOption2Provider);
  final position = ref.watch(selectedPositionProvider).toLowerCase();
  final name = ref.watch(selectedItemProvider);
  final DateTime firstDate = ref.watch(firstDateProvider);
  final DateTime lastDate = ref.watch(lastDateProvider);
  final String formattedFirstDate = DateFormat('yyyy-MM-dd').format(firstDate);
  final String formattedLastDate = DateFormat('yyyy-MM-dd').format(lastDate);

  return DashboardOptions(
      tdFormat: selectedOption1,
      dataFormat: selectedOption2,
      firstDate: formattedFirstDate,
      lastDate: formattedLastDate,
      name: name,
      position: position);
});

final getSegmentDataProvider = FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final getSegmentData = await ref.watch(salesRepoProvider).getSegmentAllData(
      tdFormat: options.tdFormat,
      dataFormat: options.dataFormat,
      firstDate: options.firstDate,
      lastDate: options.lastDate);
  return getSegmentData;
});

class SegmentTable extends ConsumerWidget {
  const SegmentTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedOption2 = ref.watch(selectedOption2Provider);
    final segmentData = ref.watch(getSegmentDataProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth / 12;

    return segmentData.when(
      data: (data) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerTheme: const DividerThemeData(
                  color: Colors.white,
                ),
              ),
              child: SizedBox(
                // width: screenWidth,
                child: DataTable(
                    dataRowMinHeight: 10,
                    dataRowMaxHeight: 40,
                    headingRowHeight: 50,
                    dividerThickness: 2.5,
                    columnSpacing: columnSpacing,
                    headingRowColor: WidgetStateColor.resolveWith(
                      (states) => const Color(0xffD9D9D9),
                    ),
                    columns: <DataColumn>[
                      DataColumn(
                          label: Text(
                        'PRICE BAND',
                        textAlign: TextAlign.center,
                        style: topStyle,
                      )),
                      DataColumn(
                          label: Center(
                        child: Text(
                          '%\nContribution',
                          textAlign: TextAlign.center,
                          style: topStyle,
                        ),
                      )),
                      DataColumn(
                          label: Text(
                        'MTD SO',
                        style: topStyle,
                      )),
                      DataColumn(
                          label: Text(
                        'LMTD SO',
                        style: topStyle,
                      )),
                      DataColumn(
                          label: Text(
                        selectedOption2 == 'value'
                            ? 'TARGET VALUE'
                            : 'TARGET VOLUME',
                        style: topStyle,
                      )),
                      DataColumn(
                          label: Center(
                        child: Text(
                          selectedOption2 == 'value'
                              ? 'PENDING VAL.'
                              : 'PENDING VOL.',
                          style: topStyle,
                        ),
                      )),
                      DataColumn(
                          label: Center(
                        child: Text(
                          'FTD',
                          style: topStyle,
                        ),
                      )),
                      DataColumn(
                          label: Center(
                        child: Text(
                          'DRR',
                          style: topStyle,
                        ),
                      )),
                      DataColumn(
                          label: Center(
                        child: Text(
                          'ADS',
                          style: topStyle,
                        ),
                      )),
                      DataColumn(
                          label: Center(
                        child: Text(
                          '% GWTH',
                          style: topStyle,
                        ),
                      )),
                    ],
                    rows: List.generate(data.length, (index) {
                      final row = data[index];
                      return DataRow(
                          color: WidgetStateColor.resolveWith(
                            (states) => const Color(0xffEEEEEE),
                          ),
                          cells: [
                            DataCell(Center(child: Text(row['_id']))),
                            DataCell(Center(
                                child: Text(
                              row['CONTRIBUTION %'],
                            ))),
                            DataCell(Center(
                                child: Text(row['MTD SELL OUT'].toString()))),
                            DataCell(Center(
                                child: Text(row['LMTD SELL OUT'].toString()))),
                            DataCell(Center(
                                child: Text(row[selectedOption2 == 'value'
                                        ? 'TARGET VALUE'
                                        : "TARGET VOLUME"]
                                    .toString()))),
                            DataCell(Center(
                                child: Text(row[selectedOption2 == 'value'
                                        ? 'VAL PENDING'
                                        : 'VOL PENDING']
                                    .toString()))),
                            DataCell(
                                Center(child: Text(row['FTD'].toString()))),
                            DataCell(Text(row['DAILY REQUIRED AVERAGE']
                                .truncate()
                                .toString())),
                            DataCell(Text(
                                row['AVERAGE DAY SALE'].truncate().toString())),
                            DataCell(
                                Center(child: Text(row['% GWTH'].toString()))),
                          ]);
                    })),
              ),
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
