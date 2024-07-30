import 'dart:developer';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/common_style.dart';
import '../repo/sales_dashboard_repo.dart';
import 'radio.dart';

final getChannelDataProvider = FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final getChanelData = await ref.watch(salesRepoProvider).getChannelData(
      tdFormet: options.tdFormat, dataFormet: options.dataFormat);
  return getChanelData;
});

class ChannelTable extends ConsumerWidget {
  const ChannelTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth / 12;
    final channelData = ref.watch(getChannelDataProvider);

    return channelData.when(
      data: (data) {
        if (data == null || data.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 100),
            child: Center(child: Text("No data available")),
          );
        }

        return SingleChildScrollView(
          // scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  dividerTheme: const DividerThemeData(
                    color: Colors.white,
                  ),
                ),
                child: SizedBox(
                  width: screenWidth,
                  child: DataTable(
                    dataRowMinHeight: 10,
                    dataRowMaxHeight: 40,
                    headingRowHeight: 50,
                    dividerThickness: 2.5,
                    columnSpacing: columnSpacing,
                    headingRowColor: MaterialStateColor.resolveWith(
                      (states) => const Color(0xffD9D9D9),
                    ),
                    columns: [
                      DataColumn(
                        label: Text('Channel',
                            textAlign: TextAlign.center, style: topStyle),
                      ),
                      DataColumn(
                        label: Text(
                          '%\nContribution',
                          textAlign: TextAlign.center,
                          style: topStyle,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Last\nMonth ACH',
                          textAlign: TextAlign.center,
                          style: topStyle,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'TGT',
                          textAlign: TextAlign.center,
                          style: topStyle,
                        ),
                      ),
                    ],
                    rows: List.generate(data.length, (index) {
                      final row = data[index];
                      return DataRow(
                          color: WidgetStateColor.resolveWith(
                            (states) => const Color(0xffEEEEEE),
                          ),
                          cells: [
                            DataCell(Text(row['Channel'])),
                            DataCell(Center(
                              child: Text(
                                row['Contribution'].toString(),
                                style: TextStyle(
                                  color: getColorFromPercentage(
                                      row['Contribution'].toString(),
                                      const Color.fromARGB(255, 218, 215, 0),
                                      const Color.fromRGBO(0, 192, 38, 1)),
                                ),
                              ),
                            )),
                            DataCell(Center(
                              child: Text(
                                row['Last Month ACH'],
                                style: TextStyle(
                                  color: row['%Gwth'].toString()[0] == '-'
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            )),
                            DataCell(
                              Center(child: Text(row['TGT'])),
                            ),
                          ]);
                    }),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) => const Center(
        child: Text("Something went wrong"),
      ),
      loading: () => const Padding(
        padding: EdgeInsets.only(top: 100),
        child: Center(
          child: CircularProgressIndicator(
            color: AppColor.primaryColor,
          ),
        ),
      ),
    );
  }
}

class DashboardOptions {
  final String tdFormat;
  final String dataFormat;
  DashboardOptions({required this.tdFormat, required this.dataFormat});
}

final selectedOptionsProvider =
    StateProvider.autoDispose<DashboardOptions>((ref) {
  final selectedOption1 = ref.watch(selectedOption1Provider);
  final selectedOption2 = ref.watch(selectedOption2Provider);
  return DashboardOptions(
    tdFormat: selectedOption1,
    dataFormat: selectedOption2,
  );
});

final getSegmentDataProvider = FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final getSegmentData = await ref.watch(salesRepoProvider).getSegmentData(
      tdFormet: options.tdFormat, dataFormet: options.dataFormat);
  return getSegmentData;
});

class SegmentTable extends ConsumerWidget {
  const SegmentTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final segmentData = ref.watch(getSegmentDataProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth / 12;

    return segmentData.when(
      data: (data) {
        log("Segment Data=>$data");
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
                    headingRowColor: MaterialStateColor.resolveWith(
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
                        'Target Value',
                        style: topStyle,
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
                      // DataColumn(
                      //     label: Text(
                      //   'MTD Ach',
                      //   style: topStyle,
                      // )),

                      // DataColumn(
                      //     label: Text(
                      //   '%\nExtrapolated',
                      //   textAlign: TextAlign.center,
                      //   style: topStyle,
                      // )),
                      // DataColumn(
                      //     label: Text(
                      //   'Grwth',
                      //   style: topStyle,
                      // )),
                      // DataColumn(
                      //     label: Text(
                      //   'LM Ads',
                      //   style: topStyle,
                      // )),
                      // DataColumn(
                      //     label: Text(
                      //   'CM Ads',
                      //   style: topStyle,
                      // )),
                      // DataColumn(
                      //     label: Text(
                      //   'Req Ads',
                      //   style: topStyle,
                      // )),
                      // DataColumn(
                      //     label: Text(
                      //   'D-1',
                      //   style: topStyle,
                      // )),
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
                          'Pending Val',
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
                                child: Text(row['TARGET VALUE'].toString()))),
                            DataCell(Center(
                                child: Text(row['MTD SELL OUT'].toString()))),
                            DataCell(Center(
                                child: Text(row['LMTD SELL OUT'].toString()))),
                            DataCell(
                                Center(child: Text(row['FTD'].toString()))),
                            DataCell(Center(
                                child: Text(row['VAL PENDING'].toString()))),
                            DataCell(
                                Text(row['DAILY REQUIRED AVERAGE'].toString())),
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
      loading: () => Padding(
        padding: const EdgeInsets.only(top: 150),
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColor.primaryColor,
          ),
        ),
      ),
    );
  }
}

var topStyle = GoogleFonts.lato(
  textStyle: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600),
);
