// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import '../utils/providers.dart';

// class ConnectivityNotifier extends ConsumerWidget {
//   const ConnectivityNotifier({Key? key, required this.child}) : super(key: key);

//   final Widget child;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final connectivityStatus = ref.watch(internetConnectionProvider);

//     return connectivityStatus.when(
//       data: (status) {
//         if (status == InternetConnectionStatus.disconnected) {
//           // Show a Snackbar if the internet is disconnected
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             ScaffoldMessenger.of(context).showSnackBar(
//              const  SnackBar(
//                 content: Text(
//                   'No Internet Connection',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 backgroundColor: Colors.red,
//                 duration: const Duration(days: 1),
//               ),
//             );
//           });
//         } else {
//           // Hide Snackbar when the internet is connected
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             ScaffoldMessenger.of(context).hideCurrentSnackBar();
//           });
//         }
//         return child; // Return the child widget
//       },
//       loading: () => SizedBox(),
//       error: (err, stack) => const Text('Error in connectivity status'),
//     );
//   }
// }
