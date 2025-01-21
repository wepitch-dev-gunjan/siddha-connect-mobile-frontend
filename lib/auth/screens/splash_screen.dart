import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siddha_connect/auth/screens/login_screen.dart';
import 'package:siddha_connect/profile/repo/profile_repo.dart';
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
    ref.read(checkAuthorizeProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
  try {
    final secureStorage = ref.watch(secureStoargeProvider);
    log("Welcome To SIDDHA");
    String? isLogin = await secureStorage.readData('authToken');
    log("Chack isLogin");
    if (isLogin != null && isLogin.isNotEmpty) {
      try {
        final profileStatus = await ref.watch(profileStatusControllerProvider);
        log("Run Profile Status");
        if (profileStatus.containsKey('error') &&
            profileStatus['error'] == 'User not authorized') {
          final dealerStatus = await ref.watch(isDealerVerifiedProvider);
          log("Run Dealer Status");
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
        // log("Error in profileStatus: $e");
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
    navigateTo(LoginScreen());
  }
});

