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

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Rotating Icon Example'),
//         ),
//         body: const Center(
//           child: RefreshButton(),
//         ),
//       ),
//     );
//   }
// }

// class RefreshButton extends StatefulWidget {
//   const RefreshButton({super.key});

//   @override
//   _RefreshButtonState createState() => _RefreshButtonState();
// }

// class _RefreshButtonState extends State<RefreshButton>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     );
//   }

//   void _startRotation() {
//     _controller.repeat();
//     // Simulating a network call or some operation
//     Future.delayed(const Duration(seconds: 2), () {
//       _controller.stop(); // Stop the rotation
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _startRotation,
//       child: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           return Transform.rotate(
//             angle: _controller.value * 2 * 3.14159265359, // Full rotation
//             child: child,
//           );
//         },
//         child: const Icon(
//           Icons.refresh,
//           size: 25,
//         ),
//       ),
//     );
//   }
// }






// // class PaymentWindow extends ConsumerWidget {
// //   const PaymentWindow({super.key});

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Testing Payment Getway"),
// //       ),
// //       body: Center(
// //         child: ElevatedButton(
// //             onPressed: () {
// //               ref.read(paymentProvider).initialGatway(totalAmmount: 100.0);
// //               ref.read(paymentProvider).openPaymentWindow(
// //                   ammount: 100.0, phone: "9782209395", email: "Pk@gmail.com");
// //             },
// //             child: const Text("Pay Now")),
// //       ),

// //     );
// //   }
// // }



