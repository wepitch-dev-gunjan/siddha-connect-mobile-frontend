import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/pulseDataUpload/screens/pulse_data_upload.dart';

class ShowTable extends ConsumerWidget {
  const ShowTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth / 12;
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
            DataRow(
              cells: [
                const DataCell(Text("")),
                const DataCell(Text("")),
                const DataCell(Text("")),
                const DataCell(Text("")),
                const DataCell(Text("")),
                DataCell(IconButton(
                  icon: const Icon(Icons.edit, color: Colors.black),
                  onPressed: () {
                    ref.read(formVisibilityProvider.notifier).state = true;
                  },
                )),
              ],
            ),
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
