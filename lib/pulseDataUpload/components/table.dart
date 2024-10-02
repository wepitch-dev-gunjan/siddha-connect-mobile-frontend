import 'dart:developer';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/pulseDataUpload/screens/pulse_data_upload.dart';

import '../repo/product_repo.dart';

final getExtractionRecordProvider = FutureProvider.autoDispose((ref) async {
  final productRepo = ref.watch(productRepoProvider);
  final data = await productRepo.getExtractionRecord();
  return data;
});

// class ShowTable extends ConsumerWidget {
//   const ShowTable({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final columnSpacing = screenWidth / 12;
//     TextEditingController dealerCode = TextEditingController();

//     return Theme(
//       data: Theme.of(context).copyWith(
//         dividerTheme: const DividerThemeData(
//           color: Colors.white,
//         ),
//       ),
//       child: Expanded(
//         child: DataTable2(
//           headingRowHeight: 50,
//           dividerThickness: 2.5,
//           columnSpacing: columnSpacing,
//           showBottomBorder: true,
//           minWidth: 700,
//           headingRowColor: WidgetStateColor.resolveWith(
//             (states) => const Color(0xff005BFF),
//           ),
//           columns: [
//             titleColumn(label: "Brand"),
//             titleColumn(label: "Model"),
//             titleColumn(label: "Dealer Price"),
//             titleColumn(label: "Quantity"),
//             titleColumn(label: "Payment Mode"),
//             titleColumn(label: "Actions"),
//           ],
//           rows: [
//             DataRow(
//               cells: [
//                 const DataCell(Text("")),
//                 const DataCell(Text("")),
//                 const DataCell(Text("")),
//                 const DataCell(Text("")),
//                 const DataCell(Text("")),
//                 DataCell(IconButton(
//                   icon: const Icon(Icons.edit, color: Colors.black),
//                   onPressed: () {
//                     ref.read(formVisibilityProvider.notifier).state = true;
//                   },
//                 )),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class ShowTable extends ConsumerWidget {
//   const ShowTable({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final extractionData = ref.watch(getExtractionRecordProvider);
//     final screenWidth = MediaQuery.of(context).size.width;
//     final columnSpacing = screenWidth / 12;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final contentAboveHeight = screenHeight / 2;
//     final remainingHeight = screenHeight - contentAboveHeight;

//     return extractionData.when(
//       data: (data) {
//         if (data == null || data['records'] == null || data['records'][0]['columns'] == null) {
//           return const Center(child: Text('No data available.'));
//         }

//         final columns = data['records'][0]['columns'] ?? [];
//         final rows = data['records'].sublist(1) ?? [];

//         return Theme(
//           data: Theme.of(context).copyWith(
//             dividerTheme: const DividerThemeData(
//               color: Colors.white,
//             ),
//           ),
//           child: SizedBox(
//             // Use the remaining height for the table to prevent overflow
//             height: remainingHeight,
//             child: DataTable2(
//               headingRowHeight: 50,
//               dividerThickness: 2.5,
//               columnSpacing: columnSpacing,
//               minWidth: 2000,
//               showBottomBorder: true,
//               headingRowColor: WidgetStateColor.resolveWith(
//                 (states) => const Color(0xff005BFF),
//               ),
//               columns: [
//                 for (var column in columns)
//                   DataColumn(
//                     label: Text(column ?? "N/A"),
//                   ),
//               ],
//               rows: List.generate(rows.length, (index) {
//                 final row = rows[index];
//                 return DataRow(
//                   cells: [
//                     DataCell(Text(row['_id']?.toString() ?? '')),
//                     DataCell(Text(row['dealerCode']?.toString() ?? '')),
//                     DataCell(Text(row['shopName']?.toString() ?? '')),
//                     DataCell(Text(row['date']?.toString() ?? '')),
//                     DataCell(Text(row['quantity']?.toString() ?? '')),
//                     DataCell(Text(row['uploadedBy']?.toString() ?? '')),
//                     DataCell(Text(row['employeeName']?.toString() ?? '')),
//                     DataCell(Text(row['totalPrice']?.toString() ?? '')),
//                     DataCell(Text(row['Brand']?.toString() ?? '')),
//                     DataCell(Text(row['Model']?.toString() ?? '')),
//                     DataCell(Text(row['Price']?.toString() ?? '')),
//                     DataCell(Text(row['Segment']?.toString() ?? '')),
//                     DataCell(Text(row['Category']?.toString() ?? '')),
//                     DataCell(Text(row['Status']?.toString() ?? '')),
//                     DataCell(IconButton(
//                       icon: const Icon(Icons.edit, color: Colors.black),
//                       onPressed: () {
//                         ref.read(formVisibilityProvider.notifier).state = true;
//                       },
//                     )),
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
//       loading: () => const Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }

// class ShowTable extends ConsumerWidget {
//   const ShowTable({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final extractionData = ref.watch(getExtractionRecordProvider);
//     final screenWidth = MediaQuery.of(context).size.width;
//     final columnSpacing = screenWidth / 12;

//     return extractionData.when(
//       data: (data) {
//         if (data == null || data['records'] == null || data['records'][0]['columns'] == null) {
//           return const Center(child: Text('No data available.'));
//         }

//         final columns = data['records'][0]['columns'] ?? [];
//         final rows = data['records'].sublist(1) ?? [];

//         return Theme(
//           data: Theme.of(context).copyWith(
//             dividerTheme: const DividerThemeData(
//               color: Colors.white,
//             ),
//           ),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: DataTable(
//               columnSpacing: columnSpacing,
//               headingRowColor: MaterialStateColor.resolveWith(
//                 (states) => const Color(0xff005BFF),
//               ),
//               columns: [
//                 for (var column in columns)
//                   DataColumn(
//                     label: Text(column ?? "N/A"),
//                   ),
//               ],
//               rows: List.generate(rows.length, (index) {
//                 final row = rows[index] ?? {};

//                 // Make sure each row has the same number of cells as columns
//                 return DataRow(
//                   cells: [
//                     DataCell(Text(row['_id']?.toString() ?? '')),
//                     DataCell(Text(row['dealerCode']?.toString() ?? '')),
//                     DataCell(Text(row['shopName']?.toString() ?? '')),
//                     DataCell(Text(row['date']?.toString() ?? '')),
//                     DataCell(Text(row['quantity']?.toString() ?? '')),
//                     DataCell(Text(row['uploadedBy']?.toString() ?? '')),
//                     DataCell(Text(row['employeeName']?.toString() ?? '')),
//                     DataCell(Text(row['totalPrice']?.toString() ?? '')),
//                     DataCell(Text(row['Brand']?.toString() ?? '')),
//                     DataCell(Text(row['Model']?.toString() ?? '')),
//                     DataCell(Text(row['Price']?.toString() ?? '')),
//                     DataCell(Text(row['Segment']?.toString() ?? '')),
//                     DataCell(Text(row['Category']?.toString() ?? '')),
//                     DataCell(Text(row['Status']?.toString() ?? '')),
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
//       loading: () => const Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
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
    final contentAboveHeight = screenHeight / 2;
    final remainingHeight = screenHeight - contentAboveHeight;

    return extractionData.when(
      data: (data) {
        if (data == null ||
            data['records'] == null ||
            data['records'][0]['columns'] == null) {
          return const Center(child: Text('No data available.'));
        }

        final columns = data['records'][0]['columns'] ?? [];
        final rows = data['records'].sublist(1) ?? [];

        return Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: const DividerThemeData(
              color: Colors.white,
            ),
          ),
          child: DataTable2(
            headingRowHeight: 50,
            dividerThickness: 2.5,
            columnSpacing: columnSpacing,
            minWidth: 2000, // Set minimum width for large tables
            showBottomBorder: true,
            headingRowColor: MaterialStateColor.resolveWith(
              (states) => const Color(0xff005BFF),
            ),
            columns: [
              for (var column in columns)
                DataColumn(
                  label: Text(column ?? "N/A"),
                ),
            ],
            rows: List.generate(rows.length, (index) {
              final row = rows[index];
              return DataRow(
                cells: [
                  DataCell(Text(row['_id']?.toString() ?? '')),
                  DataCell(Text(row['dealerCode']?.toString() ?? '')),
                  DataCell(Text(row['shopName']?.toString() ?? '')),
                  DataCell(Text(row['date']?.toString() ?? '')),
                  DataCell(Text(row['quantity']?.toString() ?? '')),
                  DataCell(Text(row['uploadedBy']?.toString() ?? '')),
                  DataCell(Text(row['employeeName']?.toString() ?? '')),
                  DataCell(Text(row['totalPrice']?.toString() ?? '')),
                  DataCell(Text(row['Brand']?.toString() ?? '')),
                  DataCell(Text(row['Model']?.toString() ?? '')),
                  DataCell(Text(row['Price']?.toString() ?? '')),
                  DataCell(Text(row['Segment']?.toString() ?? '')),
                  DataCell(Text(row['Category']?.toString() ?? '')),
                  DataCell(Text(row['Status']?.toString() ?? '')),
                  // DataCell(IconButton(
                  //   icon: const Icon(Icons.edit, color: Colors.black),
                  //   onPressed: () {
                  //     ref.read(formVisibilityProvider.notifier).state = true;
                  //   },
                  // )),
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
        child: CircularProgressIndicator(),
      ),
    );
  }
}

DataColumn titleColumn({required String label}) {
  return DataColumn(
    label: Text(
      label,
      style: tableTitleStyle,
    ),
  );
}

var tableTitleStyle = GoogleFonts.lato(
  textStyle: const TextStyle(
      fontSize: 11.5, fontWeight: FontWeight.w600, color: Colors.white),
);

