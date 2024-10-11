import 'dart:developer';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/utils/common_style.dart';
import '../repo/product_repo.dart';

final getExtractionRecordProvider = FutureProvider.autoDispose((ref) async {
  final productRepo = ref.watch(productRepoProvider);
  final data = await productRepo.getExtractionRecord();
  ref.keepAlive();
  return data;
});


final getPulseRecordProvider = FutureProvider.autoDispose((ref) async {
  final productRepo = ref.watch(productRepoProvider);
  final data = await productRepo.getPulseRecord();
  ref.keepAlive();
  return data;
});

// Example widget to show table with Edit and Delete functionality
class ExtractionDataTable extends ConsumerWidget {
  const ExtractionDataTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final extractionData = ref.watch(getExtractionRecordProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth / 12;

    return extractionData.when(
      data: (data) {
        if (data == null ||
            data['records'] == null ||
            data['records'][0]['columns'] == null) {
          return const Center(child: Text('No data available.'));
        }

        final columns = data['records'][0]['columns']?.sublist(1) ?? [];
        final rows = data['records'].sublist(1) ?? [];

        return Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: const DividerThemeData(
              color: Colors.white,
            ),
          ),
          child: DataTable2(
            headingRowHeight: 50,
            columnSpacing: columnSpacing,
            border: TableBorder.all(color: Colors.black45, width: 0.5),
            horizontalMargin: 0,
            bottomMargin: 5,
            minWidth: 1200,
            showBottomBorder: true,
            headingRowColor: WidgetStateColor.resolveWith(
              (states) => const Color(0xff005BFF),
            ),
            columns: [
              for (var column in columns)
                DataColumn(
                    label: Center(
                        child: Text(
                  column ?? "N/A",
                  style: tableTitleStyleExtraction,
                ))),
              // Add an extra column for actions (Edit/Delete)
              DataColumn(
                  label: Center(
                      child: Text(
                'Actions',
                style: tableTitleStyleExtraction,
              ))),
            ],
            rows: List.generate(rows.length, (index) {
              final row = rows[index];
              return DataRow(
                cells: [
                  DataCell(Center(
                    child: Text(
                      row['dealerCode']?.toString() ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      row['shopName']?.toString() ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      row['Brand']?.toString() ?? '',
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      row['Model']?.toString() ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  )),
                  DataCell(
                    Center(child: Text(row['Category']?.toString() ?? '')),
                  ),
                  DataCell(
                    Center(child: Text(row['quantity']?.toString() ?? '')),
                  ),
                  DataCell(Center(
                    child: Text(
                      row['totalPrice']?.toString() ?? '',
                      textAlign: TextAlign.center,
                    ),
                  )),
                  // Actions column: Edit and Delete
                  DataCell(
                    Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          semanticLabel: "Delete Items",
                        ),
                        onPressed: () {
                          // Call delete function here
                          deleteRow(ref, index, row);
                        },
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        );
      },
      error: (error, stackTrace) => const Center(
        child: Text("Something Went Wrong"),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: AppColor.primaryColor,
          strokeWidth: 3,
        ),
      ),
    );
  }

}



class PulseDataTable extends ConsumerWidget {
  const PulseDataTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pulseData = ref.watch(getPulseRecordProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth / 12;

    return pulseData.when(
      data: (data) {
        if (data == null ||
            data['records'] == null ||
            data['records'][0]['columns'] == null) {
          return const Center(child: Text('No data available.'));
        }

        final columns = data['records'][0]['columns']?.sublist(1) ?? [];
        final rows = data['records'].sublist(1) ?? [];

        return Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: const DividerThemeData(
              color: Colors.white,
            ),
          ),
          child: DataTable2(
            headingRowHeight: 50,
            columnSpacing: columnSpacing,
            border: TableBorder.all(color: Colors.black45, width: 0.5),
            horizontalMargin: 0,
            bottomMargin: 5,
            minWidth: 1200,
            showBottomBorder: true,
            headingRowColor: WidgetStateColor.resolveWith(
              (states) => const Color(0xff005BFF),
            ),
            columns: [
              for (var column in columns)
                DataColumn(
                    label: Center(
                        child: Text(
                  column ?? "N/A",
                  style: tableTitleStyleExtraction,
                ))),
              // Add an extra column for actions (Edit/Delete)
              DataColumn(
                  label: Center(
                      child: Text(
                'Actions',
                style: tableTitleStyleExtraction,
              ))),
            ],
            rows: List.generate(rows.length, (index) {
              final row = rows[index];
              return DataRow(
                cells: [
                  DataCell(Center(
                    child: Text(
                      row['dealerCode']?.toString() ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      row['shopName']?.toString() ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      row['Brand']?.toString() ?? '',
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      row['Model']?.toString() ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  )),
                  DataCell(
                    Center(child: Text(row['Category']?.toString() ?? '')),
                  ),
                  DataCell(
                    Center(child: Text(row['quantity']?.toString() ?? '')),
                  ),
                  DataCell(Center(
                    child: Text(
                      row['totalPrice']?.toString() ?? '',
                      textAlign: TextAlign.center,
                    ),
                  )),
                  // Actions column: Edit and Delete
                  DataCell(
                    Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          semanticLabel: "Delete Items",
                        ),
                        onPressed: () {
                          // Call delete function here
                          deleteRow(ref, index, row);
                        },
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        );
      },
      error: (error, stackTrace) => const Center(
        child: Text("Something Went Wrong"),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: AppColor.primaryColor,
          strokeWidth: 3,
        ),
      ),
    );
  }

}

var tableTitleStyleExtraction = GoogleFonts.lato(
  textStyle: const TextStyle(
      fontSize: 11.5, fontWeight: FontWeight.w600, color: Colors.white),
);



  void deleteRow(WidgetRef ref, int index, Map<String, dynamic> row) {
    showDialog(
      context: ref.context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Confirm Deletion',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Are you sure you want to delete this item?'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: AppColor.primaryColor),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        log('Deleting row with ID: ${row['Id']}');
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(color: AppColor.primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }




//=====================! WithOut delete Table !================================

// class ShowTable extends ConsumerWidget {
//   const ShowTable({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final extractionData = ref.watch(getExtractionRecordProvider);
//     final screenWidth = MediaQuery.of(context).size.width;
//     final columnSpacing = screenWidth / 12;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return extractionData.when(
//       data: (data) {
//         if (data == null ||
//             data['records'] == null ||
//             data['records'][0]['columns'] == null) {
//           return const Center(child: Text('No data available.'));
//         }
//         final columns = data['records'][0]['columns']?.sublist(1) ?? [];
//         final rows = data['records'].sublist(1) ?? [];
//         return Theme(
//           data: Theme.of(context).copyWith(
//             dividerTheme: const DividerThemeData(
//               color: Colors.white,
//             ),
//           ),
//           child: DataTable2(
//             headingRowHeight: 50,
//             columnSpacing: columnSpacing,
//             border: TableBorder.all(color: Colors.black45, width: 0.5),
//             horizontalMargin: 0,
//             bottomMargin: 5,
//             minWidth: 1000,
//             showBottomBorder: true,
//             headingRowColor: WidgetStateColor.resolveWith(
//               (states) => const Color(0xff005BFF),
//             ),
//             columns: [
//               for (var column in columns)
//                 titleColumn(
//                   label: column ?? "N/A",
//                 ),
//             ],
//             rows: List.generate(rows.length, (index) {
//               final row = rows[index];
//               return DataRow(
//                 cells: [
//                   DataCell(Center(
//                     child: Text(
//                       row['dealerCode']?.toString() ?? '',
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   )),
//                   DataCell(Center(
//                     child: Text(
//                       row['shopName']?.toString() ?? '',
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 2,
//                     ),
//                   )),
//                   DataCell(Center(
//                     child: FittedBox(
//                       // fit: BoxFit.fitHeight,
//                       child: Text(
//                         row['Brand']?.toString() ?? '',
//                       ),
//                     ),
//                   )),
//                   DataCell(Center(
//                     child: Text(
//                       row['Model']?.toString() ?? '',
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 2,
//                     ),
//                   )),
//                   DataCell(Center(
//                     child: FittedBox(
//                       fit: BoxFit.scaleDown,
//                       child: Text(row['Category']?.toString() ?? ''),
//                     ),
//                   )),
//                   DataCell(Center(
//                     child: FittedBox(
//                       fit: BoxFit.scaleDown,
//                       child: Text(row['quantity']?.toString() ?? ''),
//                     ),
//                   )),
//                   DataCell(Center(
//                     child: FittedBox(
//                       fit: BoxFit.scaleDown,
//                       child: Text(
//                         row['totalPrice']?.toString() ?? '',
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   )),
//                 ],
//               );
//             }),
//           ),
//         );
//       },
//       error: (error, stackTrace) => const Center(
//         child: Text("Something Went Wrong"),
//       ),
//       loading: () => const Center(
//         child: CircularProgressIndicator(
//           color: AppColor.primaryColor,
//           strokeWidth: 3,
//         ),
//       ),
//     );
//   }
// }

