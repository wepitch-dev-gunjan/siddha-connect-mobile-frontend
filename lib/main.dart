import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siddha_connect/auth/screens/splash_screen.dart';
import 'package:siddha_connect/salesDashboard/repo/sales_dashboard_repo.dart';
import 'package:siddha_connect/utils/common_style.dart';
import 'package:siddha_connect/utils/navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: ScreenUtil.defaultSize,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Siddha Connect',
        home: const SplashScreen(),
      ),
    );
  }
}

final getChannelDataProvider = FutureProvider.autoDispose((ref) {
  final getChanelData = ref.watch(salesRepoProvider).getChannelData();
  return getChanelData;
});

class CusTable extends ConsumerWidget {
  const CusTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channelData = ref.watch(getChannelDataProvider);

    return channelData.when(
      data: (data) {
        log("channelData $data");
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
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Channel',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        '%\nContribution',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Last\nMonth ACH',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'TGT',
                        textAlign: TextAlign.center,
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






// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Custom Table Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Custom Table Example'),
//         ),
//         body: CustomTable(),
//       ),
//     );
//   }
// }

// class CustomTable extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Header row
//         _buildHeader(),
//         // Scrollable content
//         Expanded(
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: _buildContent(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       color: Colors.grey.shade300,
//       child: Row(
//         children: [
//           _buildHeaderCell('Channel'),
//           _buildHeaderCell('%Contribution'),
//           _buildHeaderCell('Last Month\nACH'),
//           _buildHeaderCell('TGT'),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeaderCell(String text) {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       alignment: Alignment.center,
//       child: Text(
//         text,
//         style: TextStyle(fontWeight: FontWeight.bold),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }

//   Widget _buildContent() {
//     List<List<String>> rows = [
//       ['SES', '85%', '17.28', '16.8'],
//       ['SMS', '85%', '17.28', '16.8'],
//       ['PC', '85%', '17.28', '16.8'],
//       ['SCP', '85%', '17.28', '16.8'],
//       ['RRF', '85%', '17.28', '16.8'],
//       ['SIS PRO', '85%', '17.28', '16.8'],
//       ['Grand Total', '85%', '57.28', '86.8'],
//     ];

//     return DataTable(
//       headingRowHeight: 0, // Remove the default header
//       columns: const [
//         DataColumn(label: Text('')),
//         DataColumn(label: Text('')),
//         DataColumn(label: Text('')),
//         DataColumn(label: Text('')),
//       ],
//       rows: rows.map((row) {
//         return DataRow(cells: row.map((cell) {
//           return DataCell(Text(cell));
//         }).toList());
//       }).toList(),
//     );
//   }
// }
