import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siddha_connect/auth/screens/splash_screen.dart';
import 'package:siddha_connect/connectivity/connectivity_widget.dart';
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
          home: const ConnectivityNotifier(child: SplashScreen())),
    );
  }
}

// class DataTableExample extends StatelessWidget {
//   const DataTableExample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height / 2,
//       child: DataTable2(
//         fixedTopRows: 2,
//         // fixedLeftColumns: 1,
//         fixedColumnsColor: Colors.green,
//         fixedCornerColor: Colors.red,
//         showBottomBorder: true,

//         columns: const [
//           DataColumn(label: Text('Price Band')),
//           DataColumn(label: Text('% Contribution')),
//           DataColumn(label: Text('Value Target')),
//           DataColumn(label: Text('MTD Mar')),
//         ],
//         rows: const [
//           DataRow(cells: [
//             DataCell(Text('120K >')),
//             DataCell(Text('85%')),
//             DataCell(Text('17.28')),
//             DataCell(Text('16.8')),
//           ]),
//           DataRow(cells: [
//             DataCell(Text('100K - 120K')),
//             DataCell(Text('85%')),
//             DataCell(Text('17.28')),
//             DataCell(Text('16.8')),
//           ]),
//           DataRow(cells: [
//             DataCell(Text('70K - 100K')),
//             DataCell(Text('85%')),
//             DataCell(Text('17.28')),
//             DataCell(Text('16.8')),
//           ]),
//           DataRow(cells: [
//             DataCell(Text('> 40K')),
//             DataCell(Text('85%')),
//             DataCell(Text('17.28')),
//             DataCell(Text('16.8')),
//           ]),
//           DataRow(cells: [
//             DataCell(Text('< 40K')),
//             DataCell(Text('85%')),
//             DataCell(Text('17.28')),
//             DataCell(Text('16.8')),
//           ]),
//           DataRow(cells: [
//             DataCell(Text('30K - 40K')),
//             DataCell(Text('85%')),
//             DataCell(Text('17.28')),
//             DataCell(Text('16.8')),
//           ]),
//           DataRow(cells: [
//             DataCell(Text('30K - 40K')),
//             DataCell(Text('85%')),
//             DataCell(Text('17.28')),
//             DataCell(Text('16.8')),
//           ]),
//           DataRow(cells: [
//             DataCell(Text('30K - 40K')),
//             DataCell(Text('85%')),
//             DataCell(Text('17.28')),
//             DataCell(Text('16.8')),
//           ]),
//           DataRow(cells: [
//             DataCell(Text('30K - 40K')),
//             DataCell(Text('85%')),
//             DataCell(Text('17.28')),
//             DataCell(Text('16.8')),
//           ]),
//           DataRow(cells: [
//             DataCell(Text('30K - 40K')),
//             DataCell(Text('85%')),
//             DataCell(Text('17.28')),
//             DataCell(Text('16.8')),
//           ]),
//           DataRow(cells: [
//             DataCell(Text('30K - 40K')),
//             DataCell(Text('85%')),
//             DataCell(Text('17.28')),
//             DataCell(Text('16.8')),
//           ]),
//           DataRow(cells: [
//             DataCell(Text('30K - 40K')),
//             DataCell(Text('85%')),
//             DataCell(Text('17.28')),
//             DataCell(Text('16.8')),
//           ]),
//           DataRow(cells: [
//             DataCell(Text('30K - 40K')),
//             DataCell(Text('85%')),
//             DataCell(Text('17.28')),
//             DataCell(Text('16.8')),
//           ]),
//           DataRow(cells: [
//             DataCell(Text('Grand Total')),
//             DataCell(Text('85%')),
//             DataCell(Text('57.28')),
//             DataCell(Text('86.8')),
//           ]),
//         ],
//         minWidth: 600, // Adjust the minimum width as needed
//         columnSpacing: 20, // Adjust the spacing between columns
//         headingRowColor:
//             WidgetStateProperty.resolveWith((states) => Colors.grey[200]),
//         headingTextStyle: const TextStyle(fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

// // Define a StreamProvider for Internet connectivity
// final internetConnectionProvider = StreamProvider<InternetConnectionStatus>((ref) {
//   return InternetConnectionChecker().onStatusChange;
// });

// void main() {
//   runApp(ProviderScope(child: MyApp()));
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Internet Connectivity Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Internet Connectivity Example'),
//       ),
//       body: Center(
//         child: Consumer(
//           builder: (context, ref, child) {
//             // Watch the internet connection status from the provider
//             final connectivityStatus = ref.watch(internetConnectionProvider);

//             return connectivityStatus.when(
//               data: (status) {
//                 if (status == InternetConnectionStatus.disconnected) {
//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(
//                           'PLEASE CONNECT TO THE INTERNET',
//                           style: TextStyle(fontSize: 14, color: Colors.white),
//                         ),
//                         backgroundColor: Colors.red,
//                         duration: const Duration(days: 1),
//                         action: SnackBarAction(
//                           label: 'DISMISS',
//                           onPressed: () {},
//                           textColor: Colors.white,
//                         ),
//                       ),
//                     );
//                   });
//                   return Text(
//                     'No Internet Connection',
//                     style: TextStyle(fontSize: 20),
//                   );
//                 } else {
//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                   });
//                   return Text(
//                     'Connected to the Internet',
//                     style: TextStyle(fontSize: 20),
//                   );
//                 }
//               },
//               loading: () => CircularProgressIndicator(),
//               error: (err, stack) => Text('Error: $err'),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
