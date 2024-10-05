import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:siddha_connect/utils/common_style.dart';

final internetConnectionProvider =
    StreamProvider<InternetConnectionStatus>((ref) {
  return InternetConnectionChecker().onStatusChange;
});

class ConnectivityNotifier extends ConsumerStatefulWidget {
  final Widget child;
  const ConnectivityNotifier({super.key, required this.child});

  @override
  ConnectivityNotifierState createState() => ConnectivityNotifierState();
}

class ConnectivityNotifierState extends ConsumerState<ConnectivityNotifier> {
  bool isFirstRun = true;

  @override
  Widget build(BuildContext context) {
    final connectivityStatus = ref.watch(internetConnectionProvider);

    return connectivityStatus.when(
      data: (status) {
        if (status == InternetConnectionStatus.disconnected) {
          if (isFirstRun) {
            return const Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi_off,
                        size: 80, color: AppColor.primaryColor),
                    SizedBox(height: 20),
                    Text(
                      'No Internet Connection',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // Using addPostFrameCallback to show SnackBar after the current frame
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.wifi_off,
                          size: 25, color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        'No Internet Connection',
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.red,
                  duration: const Duration(days: 1),
                ),
              );
            });
          }
        } else if (status == InternetConnectionStatus.connected) {
          // Using addPostFrameCallback to remove the SnackBar after the current frame
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            if (isFirstRun) {
              setState(() {
                isFirstRun = false;
              });
            }
          });
        }
        return widget.child;
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) =>
          const Text('Error in connectivity status'),
    );
  }
}
