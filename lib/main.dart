import 'app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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



