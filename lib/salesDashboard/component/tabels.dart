import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/common_style.dart';
import '../repo/sales_dashboard_repo.dart';

final getChannelDataProvider = FutureProvider((ref) {
  final getChanelData = ref.watch(salesRepoProvider).getChannelData();
  return getChanelData;
});

class ChannelTable extends ConsumerWidget {
  const ChannelTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth / 12;
    final channelData = ref.watch(getChannelDataProvider);

    return channelData.when(
      data: (data) {
        return SingleChildScrollView(
          // scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  dividerTheme: const DividerThemeData(
                    color: Colors.white,
                  ),
                ),
                child: SizedBox(
                  width: screenWidth,
                  child: DataTable(
                    dataRowMinHeight: 10,
                    dataRowMaxHeight: 40,
                    headingRowHeight: 50,
                    dividerThickness: 2.5,
                    columnSpacing: columnSpacing,
                    headingRowColor: MaterialStateColor.resolveWith(
                      (states) => const Color(0xffD9D9D9),
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
                      return DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) => const Color(0xffEEEEEE),
                          ),
                          cells: [
                            DataCell(Text(row['Channel'])),
                            DataCell(Text(
                              row['Contribution'].toString(),
                              style: TextStyle(
                                color: getColorFromPercentage(
                                    row['Contribution'].toString(),
                                    const Color.fromARGB(255, 218, 215, 0),
                                    const Color.fromRGBO(0, 192, 38, 1)),
                              ),
                            )),
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
                ),
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
