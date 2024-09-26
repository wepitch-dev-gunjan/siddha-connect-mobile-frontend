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


// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // // import 'package:internet_connection_checker/internet_connection_checker.dart';

// // // // Define a StreamProvider for Internet connectivity
// // // final internetConnectionProvider = StreamProvider<InternetConnectionStatus>((ref) {
// // //   return InternetConnectionChecker().onStatusChange;
// // // });

// // // void main() {
// // //   runApp(ProviderScope(child: MyApp()));
// // // }

// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       debugShowCheckedModeBanner: false,
// // //       title: 'Internet Connectivity Example',
// // //       theme: ThemeData(
// // //         primarySwatch: Colors.blue,
// // //       ),
// // //       home: HomeScreen(),
// // //     );
// // //   }
// // // }

// // // class HomeScreen extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Internet Connectivity Example'),
// // //       ),
// // //       body: Center(
// // //         child: Consumer(
// // //           builder: (context, ref, child) {
// // //             // Watch the internet connection status from the provider
// // //             final connectivityStatus = ref.watch(internetConnectionProvider);

// // //             return connectivityStatus.when(
// // //               data: (status) {
// // //                 if (status == InternetConnectionStatus.disconnected) {
// // //                   WidgetsBinding.instance.addPostFrameCallback((_) {
// // //                     ScaffoldMessenger.of(context).showSnackBar(
// // //                       SnackBar(
// // //                         content: Text(
// // //                           'PLEASE CONNECT TO THE INTERNET',
// // //                           style: TextStyle(fontSize: 14, color: Colors.white),
// // //                         ),
// // //                         backgroundColor: Colors.red,
// // //                         duration: const Duration(days: 1),
// // //                         action: SnackBarAction(
// // //                           label: 'DISMISS',
// // //                           onPressed: () {},
// // //                           textColor: Colors.white,
// // //                         ),
// // //                       ),
// // //                     );
// // //                   });
// // //                   return Text(
// // //                     'No Internet Connection',
// // //                     style: TextStyle(fontSize: 20),
// // //                   );
// // //                 } else {
// // //                   WidgetsBinding.instance.addPostFrameCallback((_) {
// // //                     ScaffoldMessenger.of(context).hideCurrentSnackBar();
// // //                   });
// // //                   return Text(
// // //                     'Connected to the Internet',
// // //                     style: TextStyle(fontSize: 20),
// // //                   );
// // //                 }
// // //               },
// // //               loading: () => CircularProgressIndicator(),
// // //               error: (err, stack) => Text('Error: $err'),
// // //             );
// // //           },
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';

// // void main() => runApp(MyApp());

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: DealerSelectionBottomSheet(),
// //     );
// //   }
// // }

// // class DealerSelectionBottomSheet extends StatefulWidget {
// //   @override
// //   _DealerSelectionBottomSheetState createState() =>
// //       _DealerSelectionBottomSheetState();
// // }

// // class _DealerSelectionBottomSheetState extends State<DealerSelectionBottomSheet> {
// //   String selectedName = "ALL";
// //   List<String> dealers = ["Dealer 1", "Dealer 2", "Dealer 3"];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("Dealer Selection")),
// //       body: Center(
// //         child: ElevatedButton(
// //           onPressed: () {
// //             _showBottomSheet(context);
// //           },
// //           child: Text(selectedName),
// //         ),
// //       ),
// //     );
// //   }

// //   void _showBottomSheet(BuildContext context) {
// //     showModalBottomSheet(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return ListView(
// //           padding: EdgeInsets.all(16.0),
// //           children: [
// //             ListTile(
// //               title: Text("ALL"),
// //               onTap: () {
// //                 setState(() {
// //                   selectedName = "ALL";
// //                 });
// //                 Navigator.pop(context);
// //               },
// //             ),
// //             ListTile(
// //               title: Text("KRO"),
// //               onTap: () {
// //                 Navigator.pop(context);
// //                 _showPopup("KRO");
// //               },
// //             ),
// //             ListTile(
// //               title: Text("NPO"),
// //               onTap: () {
// //                 Navigator.pop(context);
// //                 _showPopup("NPO");
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   void _showPopup(String name) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text("$name Options"),
// //           content: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               ListTile(
// //                 title: Text("View List"),
// //                 onTap: () {
// //                   Navigator.pop(context);
// //                   _showDealers(name, "List");
// //                 },
// //               ),
// //               ListTile(
// //                 title: Text("View Report"),
// //                 onTap: () {
// //                   Navigator.pop(context);
// //                   _showDealers(name, "Report");
// //                 },
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   void _showDealers(String name, String type) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text("$name - $type"),
// //           content: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: dealers
// //                 .map((dealer) => ListTile(
// //                       title: Text(dealer),
// //                     ))
// //                 .toList(),
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 setState(() {
// //                   selectedName = name;
// //                 });
// //                 Navigator.pop(context);
// //               },
// //               child: Text("Select $name"),
// //             )
// //           ],
// //         );
// //       },
// //     );
// //   }
// // }


