import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siddha_connect/auth/screens/login_screen.dart';
import 'package:siddha_connect/salesDashboard/screen/sales_dashboard.dart';

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
    // Future.delayed(const Duration(seconds: 2), () {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => LoginScreen()));
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  String isLogin = await ref.watch(secureStoargeProvider).readData('authToken');

  log("token=> $isLogin");

  log(isLogin.toString());
  if (isLogin.isNotEmpty) {
    navigateTo(const SalesDashboard());
  } else {
    navigateTo(LoginScreen());
  }
});
