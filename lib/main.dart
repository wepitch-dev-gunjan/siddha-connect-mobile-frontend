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
          home: SplashScreen(),
        )
        // home: const ConnectivityNotifier(child: SplashScreen())),
        );
  }
}


// // // import 'package:flutter/material.dart';

// // // void main() => runApp(MyApp());

// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       home: DealerSelectionBottomSheet(),
// // //     );
// // //   }
// // // }

// // // class DealerSelectionBottomSheet extends StatefulWidget {
// // //   @override
// // //   _DealerSelectionBottomSheetState createState() =>
// // //       _DealerSelectionBottomSheetState();
// // // }

// // // class _DealerSelectionBottomSheetState extends State<DealerSelectionBottomSheet> {
// // //   String selectedName = "ALL";
// // //   List<String> dealers = ["Dealer 1", "Dealer 2", "Dealer 3"];

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: Text("Dealer Selection")),
// // //       body: Center(
// // //         child: ElevatedButton(
// // //           onPressed: () {
// // //             _showBottomSheet(context);
// // //           },
// // //           child: Text(selectedName),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   void _showBottomSheet(BuildContext context) {
// // //     showModalBottomSheet(
// // //       context: context,
// // //       builder: (BuildContext context) {
// // //         return ListView(
// // //           padding: EdgeInsets.all(16.0),
// // //           children: [
// // //             ListTile(
// // //               title: Text("ALL"),
// // //               onTap: () {
// // //                 setState(() {
// // //                   selectedName = "ALL";
// // //                 });
// // //                 Navigator.pop(context);
// // //               },
// // //             ),
// // //             ListTile(
// // //               title: Text("KRO"),
// // //               onTap: () {
// // //                 Navigator.pop(context);
// // //                 _showPopup("KRO");
// // //               },
// // //             ),
// // //             ListTile(
// // //               title: Text("NPO"),
// // //               onTap: () {
// // //                 Navigator.pop(context);
// // //                 _showPopup("NPO");
// // //               },
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }

// // //   void _showPopup(String name) {
// // //     showDialog(
// // //       context: context,
// // //       builder: (BuildContext context) {
// // //         return AlertDialog(
// // //           title: Text("$name Options"),
// // //           content: Column(
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: [
// // //               ListTile(
// // //                 title: Text("View List"),
// // //                 onTap: () {
// // //                   Navigator.pop(context);
// // //                   _showDealers(name, "List");
// // //                 },
// // //               ),
// // //               ListTile(
// // //                 title: Text("View Report"),
// // //                 onTap: () {
// // //                   Navigator.pop(context);
// // //                   _showDealers(name, "Report");
// // //                 },
// // //               ),
// // //             ],
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }

// // //   void _showDealers(String name, String type) {
// // //     showDialog(
// // //       context: context,
// // //       builder: (BuildContext context) {
// // //         return AlertDialog(
// // //           title: Text("$name - $type"),
// // //           content: Column(
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: dealers
// // //                 .map((dealer) => ListTile(
// // //                       title: Text(dealer),
// // //                     ))
// // //                 .toList(),
// // //           ),
// // //           actions: [
// // //             TextButton(
// // //               onPressed: () {
// // //                 setState(() {
// // //                   selectedName = name;
// // //                 });
// // //                 Navigator.pop(context);
// // //               },
// // //               child: Text("Select $name"),
// // //             )
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }
// // // }




// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text("Dialog Example")),
//         body: MyHomePage(),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   void _showAddDataDialog(BuildContext context) {
//     // Controllers for the text fields
//     TextEditingController field1Controller = TextEditingController();
//     TextEditingController field2Controller = TextEditingController();
//     TextEditingController field3Controller = TextEditingController();
//     TextEditingController field4Controller = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Add Data'),
//           content: SingleChildScrollView(
//             child: Column(
//               children: [
//                 TextField(
//                   controller: field1Controller,
//                   decoration: InputDecoration(labelText: "Field 1"),
//                 ),
//                 TextField(
//                   controller: field2Controller,
//                   decoration: InputDecoration(labelText: "Field 2"),
//                 ),
//                 TextField(
//                   controller: field3Controller,
//                   decoration: InputDecoration(labelText: "Field 3"),
//                 ),
//                 TextField(
//                   controller: field4Controller,
//                   decoration: InputDecoration(labelText: "Field 4"),
//                 ),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text("Cancel"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             ElevatedButton(
//               child: Text("OK"),
//               onPressed: () {
//                 // Handle OK button press (e.g., save the input data)
//                 print("Field 1: ${field1Controller.text}");
//                 print("Field 2: ${field2Controller.text}");
//                 print("Field 3: ${field3Controller.text}");
//                 print("Field 4: ${field4Controller.text}");

//                 // Close the dialog
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         onPressed: () => _showAddDataDialog(context),
//         child: const Text('Open Dialog'),
//       ),
//     );
//   }
// }
