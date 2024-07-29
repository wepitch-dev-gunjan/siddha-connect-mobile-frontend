import 'package:data_table_2/data_table_2.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth / 12;
    final channelData = ref.watch(getChannelDataProvider);

    return channelData.when(
      data: (data) {
        if (data == null || data.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 100),
            child: Center(child: Text("No data available")),
          );
        }

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
                          color: WidgetStateColor.resolveWith(
                            (states) => const Color(0xffEEEEEE),
                          ),
                          cells: [
                            DataCell(Text(row['Channel'])),
                            DataCell(Center(
                              child: Text(
                                row['Contribution'].toString(),
                                style: TextStyle(
                                  color: getColorFromPercentage(
                                      row['Contribution'].toString(),
                                      const Color.fromARGB(255, 218, 215, 0),
                                      const Color.fromRGBO(0, 192, 38, 1)),
                                ),
                              ),
                            )),
                            DataCell(Center(
                              child: Text(
                                row['Last Month ACH'],
                                style: TextStyle(
                                  color: row['%Gwth'].toString()[0] == '-'
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            )),
                            DataCell(
                              Center(child: Text(row['TGT'])),
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
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth / 12;

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
          child: SizedBox(
            // width: screenWidth,
            child: DataTable(
              dataRowMinHeight: 10,
              dataRowMaxHeight: 40,
              headingRowHeight: 50,
              dividerThickness: 2.5,
              columnSpacing: columnSpacing,
              headingRowColor: MaterialStateColor.resolveWith(
                (states) => const Color(0xffD9D9D9),
              ),
              columns: <DataColumn>[
                DataColumn(
                    label: Text(
                  'Price Band',
                  textAlign: TextAlign.center,
                  style: topStyle,
                )),
                DataColumn(
                    label: Center(
                  child: Text(
                    '%\nContribution',
                    textAlign: TextAlign.center,
                    style: topStyle,
                  ),
                )),
                DataColumn(
                    label: Text(
                  'Value Target',
                  style: topStyle,
                )),
                DataColumn(
                    label: Text(
                  'MTD Mar',
                  style: topStyle,
                )),
                DataColumn(
                    label: Text(
                  'MTD Ach',
                  style: topStyle,
                )),
                DataColumn(
                    label: Text(
                  'Pending Val',
                  style: topStyle,
                )),
                DataColumn(
                    label: Text(
                  '%\nExtrapolated',
                  textAlign: TextAlign.center,
                  style: topStyle,
                )),
                DataColumn(
                    label: Text(
                  'Grwth',
                  style: topStyle,
                )),
                DataColumn(
                    label: Text(
                  'LM Ads',
                  style: topStyle,
                )),
                DataColumn(
                    label: Text(
                  'CM Ads',
                  style: topStyle,
                )),
                DataColumn(
                    label: Text(
                  'Req Ads',
                  style: topStyle,
                )),
                DataColumn(
                    label: Text(
                  'D-1',
                  style: topStyle,
                )),
                DataColumn(
                    label: Center(
                  child: Text(
                    'FTD',
                    style: topStyle,
                  ),
                )),
              ],
              rows: [
                DataRow(
                    color: WidgetStateColor.resolveWith(
                      (states) => const Color(0xffEEEEEE),
                    ),
                    cells: const [
                      DataCell(Text('100K')),
                      DataCell(Center(child: Text('78%'))),
                      DataCell(Center(child: Text('17.28'))),
                      DataCell(Center(child: Text('10.4'))),
                      DataCell(Center(child: Text('19.57'))),
                      DataCell(Center(child: Text('0.57'))),
                      DataCell(Center(child: Text('15.90'))),
                      DataCell(Center(child: Text('20%'))),
                      DataCell(Center(child: Text('10.4'))),
                      DataCell(Center(child: Text('0.4'))),
                      DataCell(Center(child: Text('0.57'))),
                      DataCell(Center(child: Text('10.4'))),
                      DataCell(Center(child: Text('17.28'))),
                    ]),
                DataRow(
                    color: WidgetStateColor.resolveWith(
                      (states) => const Color(0xffEEEEEE),
                    ),
                    cells: const [
                      DataCell(Text('70-100K')),
                      DataCell(Center(child: Text('80%'))),
                      DataCell(Center(child: Text('17.28'))),
                      DataCell(Center(child: Text('17.8'))),
                      DataCell(Center(child: Text('15.37'))),
                      DataCell(Center(child: Text('1.87'))),
                      DataCell(Center(child: Text('19.57'))),
                      DataCell(Center(child: Text('78%'))),
                      DataCell(Center(child: Text('19.57'))),
                      DataCell(Center(child: Text('10.4'))),
                      DataCell(Center(child: Text('10.4'))),
                      DataCell(Center(child: Text('1.87'))),
                      DataCell(Center(child: Text('19.57'))),
                    ]),
                DataRow(
                    color: WidgetStateColor.resolveWith(
                      (states) => const Color(0xffEEEEEE),
                    ),
                    cells: const [
                      DataCell(Text('40-70K')),
                      DataCell(Text('75%')),
                      DataCell(Text('17.28')),
                      DataCell(Text('16.8')),
                      DataCell(Text('10.15')),
                      DataCell(Text('2.70')),
                      DataCell(Text('08.36')),
                      DataCell(Text('37%')),
                      DataCell(Text('2.70')),
                      DataCell(Text('18.4')),
                      DataCell(Text('2.70')),
                      DataCell(Text('16.57')),
                      DataCell(Text('10.17')),
                    ]),
                DataRow(
                    color: WidgetStateColor.resolveWith(
                      (states) => const Color(0xffEEEEEE),
                    ),
                    cells: const [
                      DataCell(Text('30-40K')),
                      DataCell(Text('77%')),
                      DataCell(Text('17.28')),
                      DataCell(Text('18.8')),
                      DataCell(Text('15.80')),
                      DataCell(Text('0.57')),
                      DataCell(Text('13.57')),
                      DataCell(Text('52%')),
                      DataCell(Text('16.57')),
                      DataCell(Text('10.17')),
                      DataCell(Text('16.57')),
                      DataCell(Text('10.15')),
                      DataCell(Text('2.70')),
                    ]),
                DataRow(
                    color: WidgetStateColor.resolveWith(
                      (states) => const Color(0xffEEEEEE),
                    ),
                    cells: const [
                      DataCell(Text('20-30K')),
                      DataCell(Text('63%')),
                      DataCell(Text('17.28')),
                      DataCell(Text('12.2')),
                      DataCell(Text('16.37')),
                      DataCell(Text('0.68')),
                      DataCell(Text('25.57')),
                      DataCell(Text('44%')),
                      DataCell(Text('0.68')),
                      DataCell(Text('0.40')),
                      DataCell(Text('0.68')),
                      DataCell(Text('16.57')),
                      DataCell(Text('10.44')),
                    ]),
                DataRow(
                    color: WidgetStateColor.resolveWith(
                      (states) => const Color(0xffEEEEEE),
                    ),
                    cells: const [
                      DataCell(Text('15-20K')),
                      DataCell(Text('86%')),
                      DataCell(Text('17.28')),
                      DataCell(Text('14.8')),
                      DataCell(Text('18.67')),
                      DataCell(Text('0.57')),
                      DataCell(Text('16.57')),
                      DataCell(Text('45%')),
                      DataCell(Text('16.57')),
                      DataCell(Text('10.44')),
                      DataCell(Text('16.57')),
                      DataCell(Text('0.40')),
                      DataCell(Text('0.68')),
                    ]),
                DataRow(
                    color: WidgetStateColor.resolveWith(
                      (states) => const Color(0xffEEEEEE),
                    ),
                    cells: const [
                      DataCell(Text('10-15K')),
                      DataCell(Text('82%')),
                      DataCell(Text('17.28')),
                      DataCell(Text('16.8')),
                      DataCell(Text('15.37')),
                      DataCell(Text('0.90')),
                      DataCell(Text('19.57')),
                      DataCell(Text('68%')),
                      DataCell(Text('15.37')),
                      DataCell(Text('8.4')),
                      DataCell(Text('0.90')),
                      DataCell(Text('0.90')),
                      DataCell(Text('19.57')),
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
