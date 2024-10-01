import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowTable extends ConsumerWidget {
  const ShowTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth / 12;
    final screenHeight = MediaQuery.of(context).size.height;
    final contentAboveHeight = screenHeight / 2;
    final remainingHeight = screenHeight - contentAboveHeight;

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
          minWidth: 600,
          headingRowColor: WidgetStateColor.resolveWith(
            (states) => const Color(0xff005BFF),
          ),
          columns: [
            titleColumn(lable: "Brand"),
            titleColumn(lable: "Model"),
            titleColumn(lable: "Dealer Price"),
            titleColumn(lable: "Quantity"),
            titleColumn(lable: "Payment Method"),
          ],
          rows: const [
            DataRow(cells: [
              DataCell(Text("data")),
              DataCell(Text("data")),
              DataCell(Text("data")),
              DataCell(Text("data")),
              DataCell(Text("data")),
            ]),
          ],
        ),
      ),
    );
  }
}

DataColumn titleColumn({required String lable}) {
  return DataColumn(
    label: Text(
      lable,
      style: tableTitleStyle,
    ),
  );
}

var tableTitleStyle = GoogleFonts.lato(
  textStyle: const TextStyle(
      fontSize: 11.5, fontWeight: FontWeight.w600, color: Colors.white),
);



