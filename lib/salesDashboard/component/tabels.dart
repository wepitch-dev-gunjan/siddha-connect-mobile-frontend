import 'dart:developer';
import 'package:flutter/material.dart';
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
        log("Channel data=> $data");
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
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
                rows: List.generate(data.length, (index) {
                  final row = data[index];
                  return DataRow(cells: [
                    DataCell(Text(row['Channel'])),
                    DataCell(Text(row['Contribution'])),
                    DataCell(Text(
                      row['Last Month ACH'],
                      style: TextStyle(
                        color: row['%Gwth'].toString()[0] == '-'
                            ? Colors.red
                            : Colors.green,
                      ),
                    )),
                    DataCell(
                      Text(row['TGT']),
                    ),
                  ]);
                }),
              ),
            ],
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

class SegmentTable extends StatelessWidget {
  const SegmentTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(label: Text('Price Band')),
            DataColumn(
                label: Text('%\nContribution', textAlign: TextAlign.center)),
            DataColumn(label: Text('Value Target')),
            DataColumn(label: Text('MTD Mar')),
            DataColumn(label: Text('MTD Ach')),
            DataColumn(label: Text('Pending Val')),
            DataColumn(
                label: Text('%\nExtrapolated', textAlign: TextAlign.center)),
            DataColumn(label: Text('Grwth')),
            DataColumn(label: Text('LM Ads')),
            DataColumn(label: Text('CM Ads')),
            DataColumn(label: Text('Req Ads')),
            DataColumn(label: Text('D-1')),
            DataColumn(label: Text('FTD')),
          ],
          rows: const <DataRow>[
            DataRow(cells: <DataCell>[
              DataCell(Text('Row 1, Col 1')),
              DataCell(Text('Row 1, Col 2')),
              DataCell(Text('Row 1, Col 3')),
              DataCell(Text('Row 1, Col 4')),
              DataCell(Text('Row 1, Col 5')),
              DataCell(Text('Row 1, Col 1')),
              DataCell(Text('Row 1, Col 2')),
              DataCell(Text('Row 1, Col 3')),
              DataCell(Text('Row 1, Col 4')),
              DataCell(Text('Row 1, Col 5')),
              DataCell(Text('Row 1, Col 3')),
              DataCell(Text('Row 1, Col 4')),
              DataCell(Text('Row 1, Col 5')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Row 2, Col 1')),
              DataCell(Text('Row 2, Col 2')),
              DataCell(Text('Row 2, Col 3')),
              DataCell(Text('Row 2, Col 4')),
              DataCell(Text('Row 2, Col 5')),
              DataCell(Text('Row 2, Col 1')),
              DataCell(Text('Row 2, Col 2')),
              DataCell(Text('Row 2, Col 3')),
              DataCell(Text('Row 2, Col 4')),
              DataCell(Text('Row 2, Col 5')),
              DataCell(Text('Row 2, Col 1')),
              DataCell(Text('Row 2, Col 2')),
              DataCell(Text('Row 2, Col 2')),
            ]),
            // Add more rows as needed
          ],
        ),
      ),
    );
  }
}
