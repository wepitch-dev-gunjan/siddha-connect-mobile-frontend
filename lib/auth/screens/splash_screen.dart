import 'dart:developer';

import 'package:flutter/material.dart';
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
  final secureStorage = ref.watch(secureStoargeProvider);
  String isLogin = await secureStorage.readData('authToken');

  if (isLogin.isNotEmpty) {
    try {
      final profileStatus = await ref.watch(profileStatusControllerProvider);
      if (profileStatus.containsKey('error') &&
          profileStatus['error'] == 'User not authorized') {
        final dealerStatus = await ref.watch(isDealerVerifiedProvider);

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
      final dealerStatus = await ref.watch(isDealerVerifiedProvider);

      if (dealerStatus['verified'] == false) {
        navigateTo(const StatusScreen());
      } else {
        navigateTo(const SalesDashboard());
      }
    }
  } else {
    navigateTo(LoginScreen());
  }
});
