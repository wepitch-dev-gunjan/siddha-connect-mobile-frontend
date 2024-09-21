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



// class ChannelTable extends ConsumerWidget {
//   const ChannelTable({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final dealerRole = ref.watch(dealerRoleProvider);
//     final screenWidth = MediaQuery.of(context).size.width;
//     final columnSpacing = screenWidth / 12;
//     final channelData = dealerRole == 'dealer'
//         ? ref.watch(getDealerChannelDataProvider)
//         : ref.watch(getChannelDataProvider);

//     return dealerRole == 'dealer'
//         ? const Center(
//             child: Text("No Data"),
//           )
//         : channelData.when(
//             data: (data) {
//               if (data == null || data.isEmpty) {
//                 return const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 100),
//                   child: Center(child: Text("No data available")),
//                 );
//               }
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Theme(
//                       data: Theme.of(context).copyWith(
//                         dividerTheme: const DividerThemeData(
//                           color: Colors.white,
//                         ),
//                       ),
//                       child: SizedBox(
//                         width: screenWidth,
//                         child: DataTable(
//                           dataRowMinHeight: 10,
//                           dataRowMaxHeight: 40,
//                           headingRowHeight: 50,
//                           dividerThickness: 2.5,
//                           columnSpacing: columnSpacing,
//                           headingRowColor: WidgetStateColor.resolveWith(
//                             (states) => const Color(0xffD9D9D9),
//                           ),
//                           columns: [
//                             DataColumn(
//                               label: Text('Channel',
//                                   textAlign: TextAlign.center, style: topStyle),
//                             ),
//                             DataColumn(
//                               label: Text(
//                                 '%\nContribution',
//                                 textAlign: TextAlign.center,
//                                 style: topStyle,
//                               ),
//                             ),
//                             DataColumn(
//                               label: Text(
//                                 'Last\nMonth ACH',
//                                 textAlign: TextAlign.center,
//                                 style: topStyle,
//                               ),
//                             ),
//                             DataColumn(
//                               label: Text(
//                                 'TGT',
//                                 textAlign: TextAlign.center,
//                                 style: topStyle,
//                               ),
//                             ),
//                           ],
//                           rows: List.generate(data.length, (index) {
//                             final row = data[index];
//                             return DataRow(
//                                 color: WidgetStateColor.resolveWith(
//                                   (states) => const Color(0xffEEEEEE),
//                                 ),
//                                 cells: [
//                                   DataCell(Text(row['Channel'])),
//                                   DataCell(Center(
//                                     child: Text(
//                                       row['Contribution'].toString(),
//                                       style: TextStyle(
//                                         color: getColorFromPercentage(
//                                             row['Contribution'].toString(),
//                                             const Color.fromARGB(
//                                                 255, 218, 215, 0),
//                                             const Color.fromRGBO(
//                                                 0, 192, 38, 1)),
//                                       ),
//                                     ),
//                                   )),
//                                   DataCell(Center(
//                                     child: Text(
//                                       row['Last Month ACH'],
//                                       style: TextStyle(
//                                         color: row['%Gwth'].toString()[0] == '-'
//                                             ? Colors.red
//                                             : Colors.green,
//                                       ),
//                                     ),
//                                   )),
//                                   DataCell(
//                                     Center(child: Text(row['TGT'])),
//                                   ),
//                                 ]);
//                           }),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//             error: (error, stackTrace) => const Center(
//               child: Text("Something went wrong"),
//             ),
//             loading: () => const Padding(
//               padding: EdgeInsets.only(top: 100),
//               child: Center(
//                 child: CircularProgressIndicator(
//                   color: AppColor.primaryColor,
//                 ),
//               ),
//             ),
//           );
//   }
// }
