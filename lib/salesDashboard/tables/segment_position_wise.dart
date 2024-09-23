import 'package:data_table_2/data_table_2.dart';
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
      await ref.watch(salesRepoProvider).getSegmentPositionWiseData(
            tdFormat: options.tdFormat,
            dataFormat: options.dataFormat,
            firstDate: options.firstDate,
            lastDate: options.lastDate,
            name: options.name,
            position: options.position!.toUpperCase(),
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
                      column ?? 'Unknown', // Add a fallback label
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
                    DataCell(Text(row['Segment Wise']?.toString() ?? '')),
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

// class SegmentTablePositionWise extends ConsumerWidget {
//   const SegmentTablePositionWise({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedOption2 = ref.watch(selectedOption2Provider);
//     final segmentData = ref.watch(positionWiseSegmentDataProvider);
//     final screenWidth = MediaQuery.of(context).size.width;
//     final columnSpacing = screenWidth / 12;

//     return segmentData.when(
//       data: (data) {
//         return SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Theme(
//               data: Theme.of(context).copyWith(
//                 dividerTheme: const DividerThemeData(
//                   color: Colors.white,
//                 ),
//               ),
//               child: SizedBox(
//                 child: DataTable(
//                   dataRowMinHeight: 10,
//                   dataRowMaxHeight: 40,
//                   headingRowHeight: 50,
//                   dividerThickness: 2.5,
//                   columnSpacing: columnSpacing,
//                   headingRowColor: WidgetStateColor.resolveWith(
//                     (states) => const Color(0xffD9D9D9),
//                   ),
//                   columns: <DataColumn>[
//                     DataColumn(
//                         label: Text(
//                       'PRICE BAND',
//                       textAlign: TextAlign.center,
//                       style: topStyle,
//                     )),
//                     DataColumn(
//                         label: Center(
//                       child: Text(
//                         '%\nContribution',
//                         textAlign: TextAlign.center,
//                         style: topStyle,
//                       ),
//                     )),
//                     DataColumn(
//                         label: Text(
//                       'MTD SO',
//                       style: topStyle,
//                     )),
//                     DataColumn(
//                         label: Text(
//                       'LMTD SO',
//                       style: topStyle,
//                     )),
//                     DataColumn(
//                         label: Text(
//                       selectedOption2 == 'value'
//                           ? 'TARGET VALUE'
//                           : 'TARGET VOLUME',
//                       style: topStyle,
//                     )),
//                     DataColumn(
//                         label: Center(
//                       child: Text(
//                         selectedOption2 == 'value'
//                             ? 'PENDING VALUE'
//                             : 'PENDING VOLUME',
//                         style: topStyle,
//                       ),
//                     )),
//                     DataColumn(
//                         label: Center(child: Text('FTD', style: topStyle))),
//                     DataColumn(
//                         label: Center(child: Text('DRR', style: topStyle))),
//                     DataColumn(
//                         label: Center(child: Text('ADS', style: topStyle))),
//                     DataColumn(
//                         label: Center(child: Text('% GWTH', style: topStyle))),
//                   ],
//                   rows: List.generate(
//                     data.length,
//                     (index) {
//                       final row = data[index];
//                       return DataRow(
//                         color: WidgetStateColor.resolveWith(
//                           (states) => const Color(0xffEEEEEE),
//                         ),
//                         cells: [
//                           DataCell(Center(child: Text(row['_id']))),
//                           DataCell(Center(child: Text(row['CONTRIBUTION %']))),
//                           DataCell(Center(
//                               child: Text(row['MTD SELL OUT'].toString()))),
//                           DataCell(Center(
//                               child: Text(row['LMTD SELL OUT'].toString()))),
//                           DataCell(Center(
//                               child: Text(row[selectedOption2 == 'value'
//                                       ? 'TARGET VALUE'
//                                       : "TARGET VOLUME"]
//                                   .toString()))),
//                           DataCell(Center(
//                               child: Text(row[selectedOption2 == 'value'
//                                       ? 'VAL PENDING'
//                                       : 'VOL PENDING']
//                                   .toString()))),
//                           DataCell(Text(row['FTD'].toString())),
//                           DataCell(Text(row['DAILY REQUIRED AVERAGE']
//                               .truncate()
//                               .toString())),
//                           DataCell(Text(
//                               row['AVERAGE DAY SALE'].truncate().toString())),
//                           DataCell(
//                               Center(child: Text(row['% GWTH'].toString()))),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//       error: (error, stackTrace) => const Center(
//         child: Text("Something Went Wrong"),
//       ),
//       loading: () => const Padding(
//         padding: EdgeInsets.only(top: 150),
//         child: Center(
//           child: CircularProgressIndicator(
//             color: AppColor.primaryColor,
//           ),
//         ),
//       ),
//     );
//   }
// }

var topStyle = GoogleFonts.lato(
  textStyle: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600),
);
