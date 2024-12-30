import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth/screens/splash_screen.dart';
import 'connectivity/connectivity_widget.dart';
import 'utils/message.dart';
import 'utils/navigation.dart';

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
        home: const ConnectivityNotifier(
          child: SplashScreen(),
        ),
      ),
    );
  }
}
