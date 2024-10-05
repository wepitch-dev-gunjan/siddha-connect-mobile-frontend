import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../utils/providers.dart';

// final internetConnectionProvider =
//     StreamProvider<InternetConnectionStatus>((ref) {
//   return InternetConnectionChecker().onStatusChange;
// });
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

final internetConnectionProvider =
    StreamProvider<InternetConnectionStatus>((ref) {
  return InternetConnectionChecker().onStatusChange;
});

// class ConnectivityNotifier extends ConsumerWidget {
//   const ConnectivityNotifier({Key? key, required this.child}) : super(key: key);

//   final Widget child;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final connectivityStatus = ref.watch(internetConnectionProvider);

//     log("Connectivity Status${connectivityStatus.runtimeType}");

//     return connectivityStatus.when(
//       data: (status) {
//         log("Connectivity+++$status");
//         if (status == InternetConnectionStatus.disconnected) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text(
//                   'No Internet Connection',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 backgroundColor: Colors.red,
//                 duration: Duration(days: 1),
//               ),
//             );
//           });
//         } else if (status == InternetConnectionStatus.connected) {
//           // Hide Snackbar when the internet is connected
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             ScaffoldMessenger.of(context)
//                 .removeCurrentSnackBar(); // Change here
//           });
//         }
//         return child; // Return the child widget
//       },
//       loading: () => const SizedBox(),
//       error: (err, stack) => const Text('Error in connectivity status'),
//     );
//   }
// }


class ConnectivityNotifier extends ConsumerWidget {
  const ConnectivityNotifier({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityStatus = ref.watch(internetConnectionProvider);

    log("Connectivity Status${connectivityStatus.runtimeType}");

    return connectivityStatus.when(
      data: (status) {
        log("Connectivity+++$status");
        if (status == InternetConnectionStatus.disconnected) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.wifi_off, size: 80, color: Colors.red),
                  SizedBox(height: 20),
                  Text(
                    'No Internet Connection',
                    style: TextStyle(fontSize: 24, color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        } else if (status == InternetConnectionStatus.connected) {
          // Jab internet connected ho, asli child dikhaye
          return child;
        }
        return child; // Return child by default
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Text('Error in connectivity status'),
    );
  }
}
