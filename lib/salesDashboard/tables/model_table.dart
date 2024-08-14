import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/common_style.dart';
import '../repo/sales_dashboard_repo.dart';
import 'segment_table.dart';

final modelWiseDataProvider = FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final getModelData = await ref.watch(salesRepoProvider).getModelWiseData(
        firstDate: options.firstDate,
        lastDate: options.lastDate,
      );
  return getModelData;
});

class ModelTable extends ConsumerWidget {
  const ModelTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelData = ref.watch(modelWiseDataProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth / 12;

    return modelData.when(
      data: (data) {
        return data.isEmpty
            ? const Padding(
                padding: EdgeInsets.only(top: 100),
                child: Center(
                  child: Text("No data found"),
                ),
              )
            : SingleChildScrollView(
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
                                'MARKET NAME',
                                textAlign: TextAlign.center,
                                style: topStyle,
                              ),
                            )),
                            DataColumn(
                                label: Text(
                              'MODEL NAME',
                              style: topStyle,
                            )),
                            DataColumn(
                                label: Text(
                              'MODEL TARGET',
                              style: topStyle,
                            )),
                            DataColumn(
                                label: Text(
                              "LMTD",
                              style: topStyle,
                            )),
                            DataColumn(
                                label: Center(
                              child: Text(
                                "MTD",
                                style: topStyle,
                              ),
                            )),
                            DataColumn(
                                label: Center(
                                    child: Text('FTD VOL.', style: topStyle))),
                            DataColumn(
                                label: Center(
                                    child: Text('% GWTH', style: topStyle))),
                            DataColumn(
                                label: Center(
                                    child: Text('ADS', style: topStyle))),
                            DataColumn(
                                label: Center(
                                    child: Text('% DP', style: topStyle))),
                            DataColumn(
                                label: Center(
                                    child: Text('MTK STK.', style: topStyle))),
                            DataColumn(
                                label: Center(
                                    child: Text('DMDD STK', style: topStyle))),
                            DataColumn(
                                label: Center(
                                    child: Text('M+S', style: topStyle))),
                            DataColumn(
                                label: Center(
                                    child: Text('DOS', style: topStyle))),
                          ],
                          rows: List.generate(data.length, (index) {
                            final row = data[index];
                            return DataRow(
                                color: WidgetStateColor.resolveWith(
                                  (states) => const Color(0xffEEEEEE),
                                ),
                                cells: [
                                  DataCell(Center(
                                      child: Text(row['Price Band'] != ""
                                          ? row['Price Band']
                                          : 'N/A'))),
                                  DataCell(Text(row['Market Name'] != ""
                                      ? row['Market Name']
                                      : "N/A")),
                                  DataCell(Center(
                                      child:
                                          Text(row['MODEL NAME'].toString()))),
                                  DataCell(Center(
                                      child: Text(
                                          row['Model Target'].toString()))),
                                  DataCell(Center(
                                      child: Text(row['LMTD'].toString()))),
                                  DataCell(Center(
                                      child: Text(row['MTD'].toString()))),
                                  DataCell(Center(
                                      child: Text(row['FTD Vol'].toString()))),
                                  DataCell(Center(
                                      child: Text(row['% Gwth'].toString()))),
                                  DataCell(Center(
                                      child: Text(row['ADS'].toString()))),
                                  DataCell(Center(
                                      child: Text(row['DP'].toString()))),
                                  DataCell(Center(
                                      child: Text(row['Mkt Stk'].toString()))),
                                  DataCell(Center(
                                      child: Text(row['Dmdd Stk'].toString()))),
                                  DataCell(Center(
                                      child: Text(row['M+S'].toString()))),
                                  DataCell(Text(row['DOS'].toString())),
                                ]);
                          })),
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
