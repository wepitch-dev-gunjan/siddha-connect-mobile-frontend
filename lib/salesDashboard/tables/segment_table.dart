import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siddha_connect/utils/responsive.dart';
import '../../common/dashboard_options.dart';
import '../../utils/common_style.dart';
import '../../utils/providers.dart';
import '../component/radio.dart';
import '../repo/sales_dashboard_repo.dart';
import 'segment_position_wise.dart';

//======================== ! Get Segment Data ! =========================
final getSegmentDataProvider = FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final getSegmentData = await ref.watch(salesRepoProvider).getSegmentAllData(
      tdFormat: options.tdFormat,
      dataFormat: options.dataFormat,
      firstDate: options.firstDate,
      lastDate: options.lastDate);
  return getSegmentData;
});

//======================== ! Get Dealer Data ! =========================
final getDealerDataProvider = FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final dealerCode = ref.watch(dealerCodeProvider);
  final getSegmentData = await ref.watch(salesRepoProvider).getDealerSegmetData(
        dataFormat: options.dataFormat,
        tdFormat: options.tdFormat,
        startDate: options.firstDate,
        endDate: options.lastDate,
      );
  ref.keepAlive();
  return getSegmentData;
});

class SegmentTable extends ConsumerWidget {
  const SegmentTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.read(dealerRoleProvider);
    final selectedOption2 = ref.watch(selectedOption2Provider);

    final segmentData = role == 'dealer'
        ? ref.watch(getDealerDataProvider)
        : ref.watch(getSegmentDataProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth / 12;
    final screenHeight = MediaQuery.of(context).size.height;
    final contentAboveHeight = screenHeight / 2;
    final remainingHeight = screenHeight - contentAboveHeight;

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
            // Use the remaining height for the table
            height: remainingHeight,
            child: DataTable2(
              headingRowHeight: 50,
              dividerThickness: 2.5,
              horizontalMargin: 0,
              bottomMargin: 5,
              columnSpacing: columnSpacing,
              fixedTopRows: 2,
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
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        column ?? 'Unknown', // Add a fallback label
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
                        child: Text(row['Segment Wise']?.toString() ?? '',
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
                        child: Text(
                      row['Contribution %']?.toString() ?? '',
                    ))),
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


// class SegmentTable extends ConsumerWidget {
//   const SegmentTable({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final role = ref.read(dealerRoleProvider);
//     final selectedOption2 = ref.watch(selectedOption2Provider);
//     final segmentData = role == 'dealer'
//         ? ref.watch(getDealerDataProvider)
//         : ref.watch(getSegmentDataProvider);
//     final screenWidth = MediaQuery.of(context).size.width;
//     final columnSpacing = screenWidth / 12;
//     return segmentData.when(
//       data: (data) {
//         if (data == null || data['columns'] == null || data['data'] == null) {
//           return const Center(child: Text('No data available.'));
//         }

//         final columns = data['columns'] ?? [];
//         final rows = data['data'] ?? [];
//         return Theme(
//           data: Theme.of(context).copyWith(
//             dividerTheme: const DividerThemeData(
//               color: Colors.white,
//             ),
//           ),
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height / 2,
//             child: DataTable2(
//               headingRowHeight: 50,
//               dividerThickness: 2.5,
//               columnSpacing: columnSpacing,
//               fixedTopRows: 2,
//               // fixedLeftColumns: 1,
//               // fixedColumnsColor: Colors.green,
//               // fixedCornerColor: Colors.red,
//               showBottomBorder: true,
//               minWidth: 2000,
//               // columnSpacing: 40,
//               headingRowColor: WidgetStateColor.resolveWith(
//                 (states) => const Color(0xffD9D9D9),
//               ),

//               columns: [
//                 for (var column in columns)
//                   DataColumn(
//                     label: Text(
//                       column ?? 'Unknown', // Add a fallback label
//                       textAlign: TextAlign.center,
//                       style: topStyle,
//                     ),
//                   ),
//               ],
//               rows: List.generate(rows.length, (index) {
//                 final row = rows[index] ?? {};

//                 return DataRow(
//                   color: WidgetStateColor.resolveWith(
//                     (states) => const Color(0xffEEEEEE),
//                   ),
//                   cells: [
//                     DataCell(Text(row['Segment Wise']?.toString() ?? '')),
//                     DataCell(Text(row['Target Vol']?.toString() ?? '')),
//                     DataCell(Text(row['Mtd Vol']?.toString() ?? '')),
//                     DataCell(Text(row['Lmtd Vol']?.toString() ?? '')),
//                     DataCell(Text(row['Pending Vol']?.toString() ?? '')),
//                     DataCell(Text(row['ADS']?.toString() ?? '')),
//                     DataCell(Text(row['Req. ADS']?.toString() ?? '')),
//                     DataCell(Text(row['% Gwth Vol']?.toString() ?? '')),
//                     DataCell(Text(row['Target SO']?.toString() ?? '')),
//                     DataCell(Text(row['Activation MTD']?.toString() ?? '')),
//                     DataCell(Text(row['Activation LMTD']?.toString() ?? '')),
//                     DataCell(Text(row['Pending Act']?.toString() ?? '')),
//                     DataCell(Text(row['ADS Activation']?.toString() ?? '')),
//                     DataCell(
//                         Text(row['Req. ADS Activation']?.toString() ?? '')),
//                     DataCell(Text(row['% Gwth Val']?.toString() ?? '')),
//                     DataCell(Text(row['FTD']?.toString() ?? '')),
//                     DataCell(Text(row['Contribution %']?.toString() ?? '')),
//                   ],
//                 );
//               }),
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
