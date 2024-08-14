import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/common_style.dart';
import '../component/radio.dart';
import '../repo/sales_dashboard_repo.dart';
import 'segment_table.dart';

final positionWiseSegmentDataProvider = FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final getPositionSegmentData =
      await ref.watch(salesRepoProvider).getSegmentWiseData(
            tdFormat: options.tdFormat,
            dataFormat: options.dataFormat,
            firstDate: options.firstDate,
            lastDate: options.lastDate,
            name: options.name,
            position: options.position,
          );
  return getPositionSegmentData;
});

class SegmentTablePositionWise extends ConsumerWidget {
  const SegmentTablePositionWise({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedOption2 = ref.watch(selectedOption2Provider);
    final segmentData = ref.watch(positionWiseSegmentDataProvider);
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
                            ? 'PENDING VALUE'
                            : 'PENDING VOLUME',
                        style: topStyle,
                      ),
                    )),
                    DataColumn(
                        label: Center(child: Text('FTD', style: topStyle))),
                    DataColumn(
                        label: Center(child: Text('DRR', style: topStyle))),
                    DataColumn(
                        label: Center(child: Text('ADS', style: topStyle))),
                    DataColumn(
                        label: Center(child: Text('% GWTH', style: topStyle))),
                  ],
                  rows: List.generate(
                    data.length,
                    (index) {
                      final row = data[index];
                      return DataRow(
                        color: WidgetStateColor.resolveWith(
                          (states) => const Color(0xffEEEEEE),
                        ),
                        cells: [
                          DataCell(Center(child: Text(row['_id']))),
                          DataCell(Center(child: Text(row['CONTRIBUTION %']))),
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
                          DataCell(Text(row['FTD'].toString())),
                          DataCell(Text(row['DAILY REQUIRED AVERAGE']
                              .truncate()
                              .toString())),
                          DataCell(Text(
                              row['AVERAGE DAY SALE'].truncate().toString())),
                          DataCell(
                              Center(child: Text(row['% GWTH'].toString()))),
                        ],
                      );
                    },
                  ),
                ),
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

var topStyle = GoogleFonts.lato(
  textStyle: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600),
);
