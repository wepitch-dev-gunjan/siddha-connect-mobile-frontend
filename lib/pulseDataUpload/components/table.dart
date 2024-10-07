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

// // Example widget to show table with Edit and Delete functionality
// class ShowTable extends ConsumerWidget {
//   ShowTable({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final extractionData = ref.watch(getExtractionRecordProvider);
//     final screenWidth = MediaQuery.of(context).size.width;
//     final columnSpacing = screenWidth / 12;

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
//             minWidth: 1200,
//             showBottomBorder: true,
//             columns: [
//               for (var column in columns)
//                 DataColumn(label: Center(child: Text(column ?? "N/A"))),
//               // Add an extra column for actions (Edit/Delete)
//               const DataColumn(label: Center(child: Text('Actions'))),
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
//                     child: Text(
//                       row['Brand']?.toString() ?? '',
//                     ),
//                   )),
//                   DataCell(Center(
//                     child: Text(
//                       row['Model']?.toString() ?? '',
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 2,
//                     ),
//                   )),
//                   DataCell(
//                     Center(child: Text(row['Category']?.toString() ?? '')),
//                   ),
//                   DataCell(
//                     Center(child: Text(row['quantity']?.toString() ?? '')),
//                   ),
//                   DataCell(Center(
//                     child: Text(
//                       row['totalPrice']?.toString() ?? '',
//                       textAlign: TextAlign.center,
//                     ),
//                   )),
//                   // Actions column: Edit and Delete
//                   DataCell(
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit, color: Colors.blue),
//                           onPressed: () {
//                             // Call edit function here
//                             editRow(context, row);
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete, color: Colors.red),
//                           onPressed: () {
//                             // Call delete function here
//                             deleteRow(ref, index);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
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
//           color: Colors.blue,
//           strokeWidth: 3,
//         ),
//       ),
//     );
//   }

//   void editRow(BuildContext context, Map<String, dynamic> row) {
//     // Open dialog or screen to edit the row data
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Edit Row'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Edit Dealer Code: ${row['dealerCode']}'),
//               // More editable fields here...
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 // Handle save
//                 Navigator.pop(context);
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void deleteRow(WidgetRef ref, int index) {
//     // Handle deletion logic here
//     // For example: removing the row from the list
//   }
// }

class ShowTable extends ConsumerWidget {
  const ShowTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final extractionData = ref.watch(getExtractionRecordProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth / 12;
    final screenHeight = MediaQuery.of(context).size.height;

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
            minWidth: 1000,
            showBottomBorder: true,
            headingRowColor: WidgetStateColor.resolveWith(
              (states) => const Color(0xff005BFF),
            ),
            columns: [
              for (var column in columns)
                titleColumn(
                  label: column ?? "N/A",
                ),
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
                    child: FittedBox(
                      // fit: BoxFit.fitHeight,
                      child: Text(
                        row['Brand']?.toString() ?? '',
                      ),
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      row['Model']?.toString() ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  )),
                  DataCell(Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(row['Category']?.toString() ?? ''),
                    ),
                  )),
                  DataCell(Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(row['quantity']?.toString() ?? ''),
                    ),
                  )),
                  DataCell(Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        row['totalPrice']?.toString() ?? '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
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

DataColumn titleColumn({required String label}) {
  return DataColumn(
    label: Center(
      child: Text(
        label,
        style: tableTitleStyle,
      ),
    ),
  );
}

var tableTitleStyle = GoogleFonts.lato(
  textStyle: const TextStyle(
      fontSize: 11.5, fontWeight: FontWeight.w600, color: Colors.white),
);
