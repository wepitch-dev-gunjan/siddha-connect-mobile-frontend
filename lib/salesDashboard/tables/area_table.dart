import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/salesDashboard/component/tabels.dart';

import '../../utils/common_style.dart';
import '../repo/sales_dashboard_repo.dart';

final getAreaDataProvider = FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final getAreaData = await ref
      .watch(salesRepoProvider)
      .getAreaData(tdFormat: options.tdFormat, dataFormat: options.dataFormat);
  return getAreaData;
});

class AreaTable extends ConsumerWidget {
  const AreaTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final areaData = ref.watch(getAreaDataProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth / 12;

    return areaData.when(
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
                          child: Text('AREA', style: topStyle),
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
                          'TARGET VAL.',
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
                          'PENDING VAL.',
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
                                  child: Text(row['TARGET VALUE'].toString()))),
                              DataCell(Text(row['AVERAGE DAY SALE']
                                  .truncate()
                                  .toString())),
                              DataCell(Text(
                                  row['DAILY REQUIRED AVERAGE'].toString())),
                              DataCell(Center(
                                  child: Text(row['VAL PENDING'].toString()))),
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
