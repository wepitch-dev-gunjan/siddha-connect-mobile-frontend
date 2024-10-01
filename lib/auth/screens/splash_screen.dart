import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siddha_connect/auth/screens/login_screen.dart';
import 'package:siddha_connect/profile/repo/profileRepo.dart';
import 'package:siddha_connect/salesDashboard/screen/sales_dashboard.dart';
import 'package:siddha_connect/auth/screens/status_screen.dart';
import 'package:siddha_connect/utils/providers.dart';
import '../../utils/navigation.dart';
import '../../utils/secure_storage.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    log("Splash 1");
    ref.read(checkAuthorizeProvider);
    super.initState();
    log("Splash 2");
  }

  @override
  Widget build(BuildContext context) {
    // log("Splash 3");
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: Column(
              children: [
                SvgPicture.asset("assets/images/splashlogo.svg"),
                SvgPicture.asset("assets/images/siddhaconnect.svg")
              ],
            ),
          ))
        ],
      ),
    );
  }
}



final checkAuthorizeProvider = FutureProvider.autoDispose((ref) async {
  log("Chack1");
  try {
    final secureStorage = ref.watch(secureStoargeProvider);
    log("Chack2");
    String? isLogin = await secureStorage.readData('authToken');
    log("Chack3");

    if (isLogin != null && isLogin.isNotEmpty) {
      try {
        final profileStatus = await ref.watch(profileStatusControllerProvider);
        log("Chack4");
        
        if (profileStatus.containsKey('error') && profileStatus['error'] == 'User not authorized') {
          final dealerStatus = await ref.watch(isDealerVerifiedProvider);
          log("Chack5");
          if (dealerStatus['verified'] == false) {
            navigateTo(const StatusScreen());
          } else {
            navigateTo(const SalesDashboard());
          }
        } else {
          if (profileStatus['verified'] == false) {
            navigateTo(const StatusScreen());
          } else {
            navigateTo(const SalesDashboard());
          }
        }
      } catch (e) {
        log("Error in profileStatus: $e");
        final dealerStatus = await ref.watch(isDealerVerifiedProvider);
        if (dealerStatus['verified'] == false) {
          navigateTo(const StatusScreen());
        } else {
          navigateTo(const SalesDashboard());
        }
      }
    } else {
      log("User not logged in, navigating to LoginScreen.");
      navigateTo(LoginScreen());
    }
  } catch (e) {
    log("Error in reading authToken: $e");
    navigateTo(LoginScreen());  // Fallback if secure storage fails
  }
});






// final checkAuthorizeProvider = FutureProvider.autoDispose((ref) async {
//   log("Chack1");
//   final secureStorage = ref.watch(secureStoargeProvider);
//   log("Chack2");
//   String isLogin = await secureStorage.readData('authToken');
//   log("Chack3");

//   if (isLogin.isNotEmpty) {
//     try {
//       final profileStatus = await ref.watch(profileStatusControllerProvider);
//       if (profileStatus.containsKey('error') &&
//           profileStatus['error'] == 'User not authorized') {
//         final dealerStatus = await ref.watch(isDealerVerifiedProvider);

//         if (dealerStatus['verified'] == false) {
//           navigateTo(const StatusScreen());
//         } else {
//           navigateTo(const SalesDashboard());
//         }
//       } else {
//         if (profileStatus['verified'] == false) {
//           navigateTo(const StatusScreen());
//         } else {
//           navigateTo(const SalesDashboard());
//         }
//       }
//     } catch (e) {
//       final dealerStatus = await ref.watch(isDealerVerifiedProvider);

//       if (dealerStatus['verified'] == false) {
//         navigateTo(const StatusScreen());
//       } else {
//         navigateTo(const SalesDashboard());
//       }
//     }
//   } else {
//     navigateTo(LoginScreen());
//   }
// });

// final checkAuthorizeProvider = FutureProvider.autoDispose((ref) async {

//   log("Chack1");
//   final secureStorage = ref.watch(secureStoargeProvider);
//   String isLogin = await secureStorage.readData('authToken');
//     navigateTo(const StatusScreen());

//   if (isLogin.isNotEmpty) {
//     try {
//       final profileStatus = await ref.watch(profileStatusControllerProvider);
//       if (profileStatus.containsKey('error') &&
//           profileStatus['error'] == 'User not authorized') {
//         final dealerStatus = await ref.watch(isDealerVerifiedProvider);

//         if (dealerStatus['verified'] == false) {
//           navigateTo(const StatusScreen());
//         } else {
//           navigateTo(const SalesDashboard());
//         }
//       } else {
//         if (profileStatus['verified'] == false) {
//           navigateTo(const StatusScreen());
//         } else {
//           navigateTo(const SalesDashboard());
//         }
//       }
//     } catch (e) {
//       final dealerStatus = await ref.watch(isDealerVerifiedProvider);

//       if (dealerStatus['verified'] == false) {
//         navigateTo(const StatusScreen());
//       } else {
//         navigateTo(const SalesDashboard());
//       }
//     }
//   } else {
//     navigateTo(LoginScreen());
//   }
// });




// final checkAuthorizeProvider = FutureProvider.autoDispose((ref) async {
//   log("Chack1");
//   final secureStorage = ref.watch(secureStoargeProvider);
  
//   // Add log before reading the data
//   log("Chack2 - Before reading authToken");

//   String isLogin = '';
//   try {
//     // Fetch authToken and add logging
//     isLogin = await secureStorage.readData('authToken');
//     log("Auth token fetched: $isLogin");
//   } catch (e) {
//     // Log if a specific decryption error occurs
//     if (e is PlatformException && e.message!.contains('BAD_DECRYPT')) {
//       log("Decryption error occurred, clearing stored authToken...");
//       // Delete the corrupted authToken and handle re-login
//       await secureStorage.deleteData('authToken');
//       isLogin = '';  // Reset isLogin to empty
//     } else {
//       log("Error fetching auth token: $e");
//     }
//   }

//   log("Chack3 - After reading authToken");

//   // If no error and token is not empty, move forward with navigation logic
//   WidgetsBinding.instance.addPostFrameCallback((_) async {
//     if (isLogin.isNotEmpty) {
//       log("User is logged in. Proceeding with profile and dealer status checks...");

//       try {
//         // Await the profileStatus result
//         final profileStatus = await ref.read(profileStatusControllerProvider);
//         log("Profile status fetched: $profileStatus");

//         if (profileStatus.containsKey('error') &&
//             profileStatus['error'] == 'User not authorized') {
//           log("User not authorized, checking dealer status...");
          
//           // Await dealerStatus result
//           final dealerStatus = await ref.read(isDealerVerifiedProvider);
//           log("Dealer status fetched: $dealerStatus");

//           if (dealerStatus['verified'] == false) {
//             log("Dealer not verified, navigating to StatusScreen...");
//             navigateTo(const StatusScreen());
//           } else {
//             log("Dealer verified, navigating to SalesDashboard...");
//             navigateTo(const SalesDashboard());
//           }
//         } else {
//           if (profileStatus['verified'] == false) {
//             log("Profile not verified, navigating to StatusScreen...");
//             navigateTo(const StatusScreen());
//           } else {
//             log("Profile verified, navigating to SalesDashboard...");
//             navigateTo(const SalesDashboard());
//           }
//         }
//       } catch (e) {
//         log("Error while fetching profile or dealer status: $e");
//         final dealerStatus = await ref.read(isDealerVerifiedProvider);
//         log("Dealer status fetched in catch: $dealerStatus");

//         if (dealerStatus['verified'] == false) {
//           log("Dealer not verified in catch block, navigating to StatusScreen...");
//           navigateTo(const StatusScreen());
//         } else {
//           log("Dealer verified in catch block, navigating to SalesDashboard...");
//           navigateTo(const SalesDashboard());
//         }
//       }
//     } else {
//       log("User not logged in, navigating to LoginScreen...");
//       navigateTo(LoginScreen());
//     }
//   });
// });
