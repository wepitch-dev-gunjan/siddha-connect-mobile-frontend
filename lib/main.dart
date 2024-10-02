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
          home:const  SplashScreen(),
        )
        // home: const ConnectivityNotifier(child: SplashScreen())),
        );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// // StateProvider to store selected values and their quantities
// final selectedValuesProvider = StateProvider<Map<int, int>>((ref) {
//   return {}; // Initially empty map with no selections
// });

// class CustomDropdownWithPopupAndQuantity extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Popup for Selecting Values and Quantity'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Button to open popup (AlertDialog)
//             GestureDetector(
//               onTap: () {
//                 // Show the popup dialog
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: Text('Select Items'),
//                       content: CustomPopupContent(),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: Text('OK'),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//               child: Container(
//                 padding: EdgeInsets.all(12.0),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Select Items'),
//                     Icon(Icons.arrow_drop_down),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),

//             // Display selected values with quantity adjustment
//             Text(
//               'Selected Values with Quantity:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SelectedValuesWithQuantity(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CustomPopupContent extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedValues = ref.watch(selectedValuesProvider);

//     return SingleChildScrollView(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: List.generate(10, (index) {
//           final value = index + 1;
//           final isSelected = selectedValues.containsKey(value);

//           return CheckboxListTile(
//             title: Text('Sample $value'),
//             value: isSelected,
//             onChanged: (bool? checked) {
//               ref.read(selectedValuesProvider.notifier).update((state) {
//                 if (checked == true) {
//                   return {
//                     ...state,
//                     value: 1
//                   }; // Default quantity to 1 on selection
//                 } else {
//                   final updatedState = {...state};
//                   updatedState.remove(value); // Remove if unchecked
//                   return updatedState;
//                 }
//               });
//             },
//           );
//         }),
//       ),
//     );
//   }
// }

// class SelectedValuesWithQuantity extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedValues = ref.watch(selectedValuesProvider);

//     return Column(
//       children: selectedValues.entries.map((entry) {
//         final value = entry.key;
//         final quantity = entry.value;

//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text('This is a sample long valuses and how to mange this $value'),
//             Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.remove),
//                   onPressed: () {
//                     if (quantity > 1) {
//                       ref.read(selectedValuesProvider.notifier).update((state) {
//                         return {...state, value: quantity - 1};
//                       });
//                     }
//                   },
//                 ),
//                 Text('$quantity'),
//                 IconButton(
//                   icon: Icon(Icons.add),
//                   onPressed: () {
//                     ref.read(selectedValuesProvider.notifier).update((state) {
//                       return {...state, value: quantity + 1};
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ],
//         );
//       }).toList(),
//     );
//   }
// }

// void main() {
//   runApp(ProviderScope(
//       child: MaterialApp(home: CustomDropdownWithPopupAndQuantity())));
// }
