import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siddha_connect/auth/screens/splash_screen.dart';
import 'package:siddha_connect/utils/message.dart';
import 'package:siddha_connect/utils/navigation.dart';
import 'connectivity/connectivity_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
        // home: const SplashScreen(),
        home: const ConnectivityNotifier(
          child: SplashScreen(),
        ),
      ),
    );
  }
}





// class PaymentWindow extends ConsumerWidget {
//   const PaymentWindow({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Testing Payment Getway"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//             onPressed: () {
//               ref.read(paymentProvider).initialGatway(totalAmmount: 100.0);
//               ref.read(paymentProvider).openPaymentWindow(
//                   ammount: 100.0, phone: "9782209395", email: "Pk@gmail.com");
//             },
//             child: const Text("Pay Now")),
//       ),
//     );
//   }
// }



