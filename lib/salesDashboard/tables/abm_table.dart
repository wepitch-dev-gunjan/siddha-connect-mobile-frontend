import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/salesDashboard/component/tabels.dart';

import '../../utils/common_style.dart';
import '../component/radio.dart';
import '../repo/sales_dashboard_repo.dart';

final getAbmDataProvider = FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final getAbmData = await ref
      .watch(salesRepoProvider)
      .getAbmData(tdFormat: options.tdFormat, dataFormat: options.dataFormat);
  return getAbmData;
});

class AbmTable extends ConsumerWidget {
  const AbmTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedOption2 = ref.watch(selectedOption2Provider);
    final abmData = ref.watch(getAbmDataProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth / 12;

    return abmData.when(
      data: (data) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerTheme: const DividerThemeData(
                  color: Colors.white,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
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
                      columns: [
                        DataColumn(
                            label: Center(
                          child: Text('Name', style: topStyle),
                        )),
                        DataColumn(
                            label: Center(
                          child: Text(
                            'MTD SO',
                            textAlign: TextAlign.center,
                            style: topStyle,
                          ),
                        )),
                        DataColumn(
                            label: Text(
                          'LMTD SO',
                          style: topStyle,
                        )),
                        DataColumn(
                            label: Text(
                          selectedOption2 == "value"
                              ? 'TARGET VAL.'
                              : 'TARGET VOL.',
                          style: topStyle,
                        )),
                        DataColumn(
                            label: Text(
                          'ADS',
                          style: topStyle,
                        )),
                        DataColumn(
                            label: Text(
                          'DRR',
                          style: topStyle,
                        )),
                        DataColumn(
                            label: Text(
                          selectedOption2 == "value"
                              ? 'PENDING VAL.'
                              : 'PENDING VOL.',
                          style: topStyle,
                        )),
                        DataColumn(
                            label: Center(
                          child: Text(
                            '%\nGWTH',
                            textAlign: TextAlign.center,
                            style: topStyle,
                          ),
                        )),
                      ],
                      rows: List.generate(data.length, (index) {
                        final row = data[index];
                        return DataRow(
                            color: WidgetStateColor.resolveWith(
                              (states) => const Color(0xffEEEEEE),
                            ),
                            cells: [
                              DataCell(Text(row['_id'])),
                              DataCell(Center(
                                  child: Text(row['MTD SELL OUT'].toString()))),
                              DataCell(Center(
                                  child:
                                      Text(row['LMTD SELL OUT'].toString()))),
                              DataCell(Center(
                                  child: Text(row[selectedOption2 == "value"
                                          ? 'TARGET VALUE'
                                          : "TARGET VOLUME"]
                                      .toString()))),
                              DataCell(Text(row['AVERAGE DAY SALE']
                                  .truncate()
                                  .toString())),
                              DataCell(Text(
                                  row['DAILY REQUIRED AVERAGE'].toString())),
                              DataCell(Center(
                                  child: Text(row[selectedOption2 == "value"
                                          ? 'VAL PENDING'
                                          : 'VOL PENDING']
                                      .toString()))),
                              DataCell(Center(
                                  child: Text(row['% GWTH'].toString()))),
                            ]);
                      })),
                ),
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
