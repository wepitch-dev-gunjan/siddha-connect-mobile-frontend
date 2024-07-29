import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siddha_connect/auth/screens/splash_screen.dart';
import 'package:siddha_connect/utils/message.dart';
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
        scaffoldMessengerKey: snackbarKey,
        debugShowCheckedModeBanner: false,
        title: 'Siddha Connect',
        home: const SplashScreen(),
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
//       home: Scaffold(
//         appBar: AppBar(title: Text('Position Dropdown Example')),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: MyForm(),
//         ),
//       ),
//     );
//   }
// }

// class MyForm extends StatefulWidget {
//   @override
//   _MyFormState createState() => _MyFormState();
// }

// class _MyFormState extends State<MyForm> {
//   String? selectedPosition;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextFormField(
//           decoration: InputDecoration(
//             labelText: 'Password',
//             border: OutlineInputBorder(),
//           ),
//           obscureText: true,
//         ),
//         SizedBox(height: 20),
//         DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             labelText: 'Position',
//             border: OutlineInputBorder(),
//           ),
//           value: selectedPosition,
//           onChanged: (newValue) {
//             setState(() {
//               selectedPosition = newValue;
//             });
//           },
//           items: <String>['Position 1', 'Position 2', 'Position 3']
//               .map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//         ),
//         DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             // contentPadding: contentPadding,
//             labelText: "Position",
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//           ),
//           items: [
//             DropdownMenuItem(
//               value: "Manager",
//               child: Text("Manager"),
//             ),
//             DropdownMenuItem(
//               value: "Developer",
//               child: Text("Developer"),
//             ),
//             DropdownMenuItem(
//               value: "Designer",
//               child: Text("Designer"),
//             ),
//           ],
//           onChanged: (value) {
//             // Handle position selection
//           },
//         ),
//       ],
//     );
//   }
// }




















// /// Example without a datasource
// class DataTable2SimpleDemo extends StatelessWidget {
//   const DataTable2SimpleDemo();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: DataTable2(
//             columnSpacing: 12,
//             horizontalMargin: 12,
//             minWidth: 600,
//             columns: [
//               DataColumn2(
//                 label: Text('Column A'),
//                 size: ColumnSize.L,
//               ),
//               DataColumn(
//                 label: Text('Column B'),
//               ),
//               DataColumn(
//                 label: Text('Column C'),
//               ),
//               DataColumn(
//                 label: Text('Column D'),
//               ),
//               DataColumn(
//                 label: Text('Column NUMBERS'),
//                 numeric: true,
//               ),
//             ],
//             rows: List<DataRow>.generate(
//                 100,
//                 (index) => DataRow(cells: [
//                       DataCell(Text('A' * (10 - index % 10))),
//                       DataCell(Text('B' * (10 - (index + 5) % 10))),
//                       DataCell(Text('C' * (15 - (index + 5) % 10))),
//                       DataCell(Text('D' * (15 - (index + 10) % 10))),
//                       DataCell(Text(((index + 0.1) * 25.4).toString()))
//                     ]))),
//       ),
//     );
//   }
// }
