import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siddha_connect/auth/screens/splash_screen.dart';
import 'package:siddha_connect/utils/message.dart';
import 'package:siddha_connect/utils/navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // .env ko pubspec file ke assets me add kre
  await dotenv.load(fileName: ".env");
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
          scaffoldMessengerKey: snackbarKey,
          debugShowCheckedModeBanner: false,
          title: 'Siddha Connect',
          home: const SplashScreen()),
    );
  }
}

// // /// Example without a datasource
// // class DataTable2SimpleDemo extends StatelessWidget {
// //   const DataTable2SimpleDemo();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: DataTable2(
// //             columnSpacing: 0,
// //             horizontalMargin: 12,
// //             minWidth: 600,
// //             columns: const [
// //               DataColumn2(
// //                 label: Text('Price Band'),
// //                 size: ColumnSize.L,
// //               ),
// //               DataColumn(
// //                 label: Text('Column B'),
// //               ),
// //               DataColumn(
// //                 label: Text('Column C'),
// //               ),
// //               DataColumn(
// //                 label: Text('Column D'),
// //               ),
// //               DataColumn(
// //                 label: Text('Column NUMBERS'),
// //                 numeric: true,
// //               ),
// //             ],
// //             rows: List<DataRow>.generate(
// //                 20,
// //                 (index) => const DataRow(cells: [
// //                       DataCell(Center(child: Text('A'))),
// //                       DataCell(Text('B')),
// //                       DataCell(Text('C')),
// //                       DataCell(Text('D')),
// //                       DataCell(Text("E"))
// //                     ]))),
// //       ),
// //     );
// //   }
// // }

// // import 'package:data_table_2/data_table_2.dart';
// // import 'package:flutter/material.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: Text('Data Table Example'),
// //         ),
// //         body: DataTableExample(),
// //       ),
// //     );
// //   }
// // }

// // class DataTableExample extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
//     // return DataTable2(
//     //   columns: [
//     //     DataColumn(label: Text('Price Band')),
//     //     DataColumn(label: Text('% Contribution')),
//     //     DataColumn(label: Text('Value Target')),
//     //     DataColumn(label: Text('MTD Mar')),
//     //   ],
//     //   rows: [
//     //     DataRow(cells: [
//     //       DataCell(Text('120K >')),
//     //       DataCell(Text('85%')),
//     //       DataCell(Text('17.28')),
//     //       DataCell(Text('16.8')),
//     //     ]),
//     //     DataRow(cells: [
//     //       DataCell(Text('100K - 120K')),
//     //       DataCell(Text('85%')),
//     //       DataCell(Text('17.28')),
//     //       DataCell(Text('16.8')),
//     //     ]),
//     //     DataRow(cells: [
//     //       DataCell(Text('70K - 100K')),
//     //       DataCell(Text('85%')),
//     //       DataCell(Text('17.28')),
//     //       DataCell(Text('16.8')),
//     //     ]),
//     //     DataRow(cells: [
//     //       DataCell(Text('> 40K')),
//     //       DataCell(Text('85%')),
//     //       DataCell(Text('17.28')),
//     //       DataCell(Text('16.8')),
//     //     ]),
//     //     DataRow(cells: [
//     //       DataCell(Text('< 40K')),
//     //       DataCell(Text('85%')),
//     //       DataCell(Text('17.28')),
//     //       DataCell(Text('16.8')),
//     //     ]),
//     //     DataRow(cells: [
//     //       DataCell(Text('30K - 40K')),
//     //       DataCell(Text('85%')),
//     //       DataCell(Text('17.28')),
//     //       DataCell(Text('16.8')),
//     //     ]),
//     //     DataRow(cells: [
//     //       DataCell(Text('30K - 40K')),
//     //       DataCell(Text('85%')),
//     //       DataCell(Text('17.28')),
//     //       DataCell(Text('16.8')),
//     //     ]),
//     //     DataRow(cells: [
//     //       DataCell(Text('30K - 40K')),
//     //       DataCell(Text('85%')),
//     //       DataCell(Text('17.28')),
//     //       DataCell(Text('16.8')),
//     //     ]),
//     //     DataRow(cells: [
//     //       DataCell(Text('30K - 40K')),
//     //       DataCell(Text('85%')),
//     //       DataCell(Text('17.28')),
//     //       DataCell(Text('16.8')),
//     //     ]),
//     //     DataRow(cells: [
//     //       DataCell(Text('30K - 40K')),
//     //       DataCell(Text('85%')),
//     //       DataCell(Text('17.28')),
//     //       DataCell(Text('16.8')),
//     //     ]),
//     //     DataRow(cells: [
//     //       DataCell(Text('30K - 40K')),
//     //       DataCell(Text('85%')),
//     //       DataCell(Text('17.28')),
//     //       DataCell(Text('16.8')),
//     //     ]),
//     //     DataRow(cells: [
//     //       DataCell(Text('30K - 40K')),
//     //       DataCell(Text('85%')),
//     //       DataCell(Text('17.28')),
//     //       DataCell(Text('16.8')),
//     //     ]),
//     //     DataRow(cells: [
//     //       DataCell(Text('30K - 40K')),
//     //       DataCell(Text('85%')),
//     //       DataCell(Text('17.28')),
//     //       DataCell(Text('16.8')),
//     //     ]),
//     //     DataRow(cells: [
//     //       DataCell(Text('Grand Total')),
//     //       DataCell(Text('85%')),
//     //       DataCell(Text('57.28')),
//     //       DataCell(Text('86.8')),
//     //     ]),

//     //   ],
//     //   minWidth: 600, // Adjust the minimum width as needed
//     //   columnSpacing: 20, // Adjust the spacing between columns
//     //   headingRowColor:
//     //       MaterialStateProperty.resolveWith((states) => Colors.grey[200]),
//     //   headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
//     // );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter/services.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Device Info Example',
//       home: DeviceInfoScreen(),
//     );
//   }
// }

// class DeviceInfoScreen extends StatefulWidget {
//   @override
//   _DeviceInfoScreenState createState() => _DeviceInfoScreenState();
// }

// class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
//   static const platform = MethodChannel('com.example.deviceinfo/imei');
//   String? _imei;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _retrieveImei();
//     });
//   }

//   Future<void> _retrieveImei() async {
//     String? imei;
//     try {
//       // Request phone state permission
//       if (await Permission.phone.request().isGranted) {
//         imei = await platform.invokeMethod('getImei');
//       } else {
//         print("Phone permission is not granted");
//       }
//     } catch (e) {
//       print("Failed to get IMEI: $e");
//     }

//     if (mounted) {
//       setState(() {
//         _imei = imei;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Device Info Example'),
//       ),
//       body: Center(
//         child: _imei != null
//             ? Text('IMEI: $_imei')
//             : CircularProgressIndicator(),
//       ),
//     );
//   }
// }
