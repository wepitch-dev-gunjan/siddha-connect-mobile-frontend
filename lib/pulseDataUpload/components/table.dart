import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/pulseDataUpload/screens/pulse_data_upload.dart';

// class ShowTable extends ConsumerWidget {
//   const ShowTable({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final columnSpacing = screenWidth / 12;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final contentAboveHeight = screenHeight / 2;
//     final remainingHeight = screenHeight - contentAboveHeight;

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
//           minWidth: 600,
//           headingRowColor: WidgetStateColor.resolveWith(
//             (states) => const Color(0xff005BFF),
//           ),
//           columns: [
//             titleColumn(lable: "Brand"),
//             titleColumn(lable: "Model"),
//             titleColumn(lable: "Dealer Price"),
//             titleColumn(lable: "Quantity"),
//             titleColumn(lable: "Payment Method"),
//           ],
//           rows: const [
//             DataRow(cells: [
//               DataCell(Text("data")),
//               DataCell(Text("data")),
//               DataCell(Text("data")),
//               DataCell(Text("data")),
//               DataCell(Text("data")),
//             ]),
//           ],
//         ),
//       ),
//     );
//   }
// }

// DataColumn titleColumn({required String lable}) {
//   return DataColumn(
//     label: Text(
//       lable,
//       style: tableTitleStyle,
//     ),
//   );
// }

// var tableTitleStyle = GoogleFonts.lato(
//   textStyle: const TextStyle(
//       fontSize: 11.5, fontWeight: FontWeight.w600, color: Colors.white),
// );

//////////////////2nd way

// class ShowTable extends ConsumerWidget {
//   const ShowTable({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final columnSpacing = screenWidth / 12;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final contentAboveHeight = screenHeight / 2;
//     final remainingHeight = screenHeight - contentAboveHeight;

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
//           minWidth: 600,
//           headingRowColor: WidgetStateColor.resolveWith(
//             (states) => const Color(0xff005BFF),
//           ),
//           columns: [
//             titleColumn(label: "Brand"),
//             titleColumn(label: "Model"),
//             titleColumn(label: "Dealer Price"),
//             titleColumn(label: "Quantity"),
//             titleColumn(label: "Payment Method"),
//           ],
//           rows: [
//             DataRow(cells: [
//               editableDataCell(initialValue: "Brand 1"),
//               editableDataCell(initialValue: "Model 1"),
//               editableDataCell(initialValue: "5000"),
//               editableDataCell(initialValue: "10"),
//               editableDataCell(initialValue: "Cash"),
//             ]),
//           ],
//         ),
//       ),
//     );
//   }
// }

// DataColumn titleColumn({required String label}) {
//   return DataColumn(
//     label: Text(
//       label,
//       style: tableTitleStyle,
//     ),
//   );
// }

// var tableTitleStyle = GoogleFonts.lato(
//   textStyle: const TextStyle(
//       fontSize: 11.5, fontWeight: FontWeight.w600, color: Colors.white),
// );

// DataCell editableDataCell({required String initialValue}) {
//   return DataCell(
//     TextFormField(
//       initialValue: initialValue,
//       style: const TextStyle(color: Colors.black),
//       decoration: const InputDecoration(
//         border: InputBorder.none,
//       ),
//     ),
//   );
// }

//////////////3rd way
///
class ShowTable extends ConsumerWidget {
  const ShowTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth / 12;

    // Access the TextEditingController and form visibility provider
    TextEditingController dealerCode = TextEditingController();

    return Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(
          color: Colors.white,
        ),
      ),
      child: Expanded(
        child: DataTable2(
          headingRowHeight: 50,
          dividerThickness: 2.5,
          columnSpacing: columnSpacing,
          showBottomBorder: true,
          minWidth: 700,
          headingRowColor: WidgetStateColor.resolveWith(
            (states) => const Color(0xff005BFF),
          ),
          columns: [
            titleColumn(label: "Brand"),
            titleColumn(label: "Model"),
            titleColumn(label: "Dealer Price"),
            titleColumn(label: "Quantity"),
            titleColumn(label: "Payment Mode"),
            titleColumn(label: "Actions"),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text("Brand 1")),
              DataCell(Text("Model 1")),
              DataCell(Text("5000")),
              DataCell(Text("10")),
              DataCell(Text("Cash")),
              DataCell(IconButton(
                icon: const Icon(Icons.edit, color: Colors.black),
                onPressed: () {
                  // Show the form and populate the dealer code
                  dealerCode.text = "123"; // Example of setting dealer code
                  ref.read(formVisibilityProvider.notifier).state = true; // Show form
                },
              )),
            ]),
          ],
        ),
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
