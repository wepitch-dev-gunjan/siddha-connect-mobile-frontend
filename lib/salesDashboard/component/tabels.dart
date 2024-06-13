import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/common_style.dart';
import '../repo/sales_dashboard_repo.dart';

final getChannelDataProvider = FutureProvider.autoDispose((ref) {
  final getChanelData = ref.watch(salesRepoProvider).getChannelData();
  return getChanelData;
});

class ChannelTable extends ConsumerWidget {
  const ChannelTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channelData = ref.watch(getChannelDataProvider);

    return channelData.when(
      data: (data) {
        // log("channelData $data");
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Colors.grey.shade300,
                  ),
                  columns: [
                    DataColumn(
                      label: Text('Channel',
                          textAlign: TextAlign.center, style: topStyle),
                    ),
                    DataColumn(
                      label: Text(
                        '%\nContribution',
                        textAlign: TextAlign.center,
                        style: topStyle,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Last\nMonth ACH',
                        textAlign: TextAlign.center,
                        style: topStyle,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'TGT',
                        textAlign: TextAlign.center,
                        style: topStyle,
                      ),
                    ),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text(data[0]['Channel'])),
                      DataCell(Text(data[0]['Contribution'].toString())),
                      DataCell(Text(
                        data[0]['%Gwth'].toString(),
                        style: TextStyle(
                            color: data[0]["%Gwth"].toString()[0] == '-'
                                ? Colors.red
                                : Colors.green),
                      )),
                      const DataCell(Text('16.8')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(data[1]['Channel'])),
                      DataCell(Text(data[1]['Contribution'].toString())),
                      DataCell(Text(
                        data[1]['%Gwth'].toString(),
                        style: TextStyle(
                            color: data[1]["%Gwth"].toString()[0] == '-'
                                ? Colors.red
                                : Colors.green),
                      )),
                      const DataCell(Text('16.8')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(data[2]['Channel'])),
                      DataCell(Text(data[2]['Contribution'].toString())),
                      DataCell(Text(
                        data[2]['%Gwth'].toString(),
                        style: TextStyle(
                            color: data[2]["%Gwth"].toString()[0] == '-'
                                ? Colors.red
                                : Colors.green),
                      )),
                      const DataCell(Text('16.8')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(data[3]['Channel'])),
                      DataCell(Text(data[3]['Contribution'].toString())),
                      DataCell(Text(
                        data[3]['%Gwth'].toString(),
                        style: TextStyle(
                            color: data[3]["%Gwth"].toString()[0] == '-'
                                ? Colors.red
                                : Colors.green),
                      )),
                      const DataCell(Text('16.8')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(data[4]['Channel'])),
                      DataCell(Text(data[4]['Contribution'].toString())),
                      DataCell(Text(
                        data[4]['%Gwth'].toString(),
                        style: TextStyle(
                            color: data[4]["%Gwth"].toString()[0] == '-'
                                ? Colors.red
                                : Colors.green),
                      )),
                      const DataCell(Text('16.8')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(data[5]['Channel'])),
                      DataCell(Text(data[5]['Contribution'].toString())),
                      DataCell(Text(
                        data[5]['%Gwth'].toString(),
                        style: TextStyle(
                            color: data[5]["%Gwth"].toString()[0] == '-'
                                ? Colors.red
                                : Colors.green),
                      )),
                      const DataCell(Text('16.8')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(data[6]['Channel'])),
                      DataCell(Text(data[6]['Contribution'].toString())),
                      DataCell(Text(
                        data[6]['%Gwth'].toString(),
                        style: TextStyle(
                            color: data[6]["%Gwth"].toString()[0] == '-'
                                ? Colors.red
                                : Colors.green),
                      )),
                      const DataCell(Text('86.8')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(data[7]['Channel'])),
                      DataCell(Text(data[7]['Contribution'].toString())),
                      DataCell(Text(
                        data[7]['%Gwth'].toString(),
                        style: TextStyle(
                            color: data[7]["%Gwth"].toString()[0] == '-'
                                ? Colors.red
                                : Colors.green),
                      )),
                      const DataCell(Text('86.8')),
                    ]),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) => const Center(
        child: Text("Something went wrong"),
      ),
      loading: () => const Padding(
        padding: EdgeInsets.only(top: 100),
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
