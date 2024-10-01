import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/uploadModel/components/repo/product_repo.dart';
import '../utils/common_style.dart';
import '../utils/cus_appbar.dart';
import '../utils/drawer.dart';
import '../utils/fields.dart';
import '../utils/sizes.dart';
import 'components/dropDawns.dart';
import 'components/floating_add_button.dart';
import 'components/table.dart';

// class UploadDailyReport extends ConsumerWidget {
//   const UploadDailyReport({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final employData = ref.watch(userProfileProvider);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: const CustomAppBar(),
//       body: const Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TopNames(),
//           ShowTable(),
//         ],
//       ),
//       floatingActionButton: AddButton(),
//     );
//   }
// }

// StateProvider for form visibility
final formVisibilityProvider = StateProvider<bool>((ref) => false);

class UploadDailyReport extends ConsumerStatefulWidget {
  const UploadDailyReport({super.key});

  @override
  ConsumerState<UploadDailyReport> createState() => _UploadDailyReportState();
}

class _UploadDailyReportState extends ConsumerState<UploadDailyReport> {
  late TextEditingController dealerCode;

  @override
  void initState() {
    super.initState();
    dealerCode = TextEditingController();
  }

  @override
  void dispose() {
    dealerCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFormVisible = ref.watch(formVisibilityProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopNames(),
              ShowTable(),
            ],
          ),
          if (isFormVisible)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  ref.read(formVisibilityProvider.notifier).state = false;
                },
                child: Container(
                  color: Colors.black54, // Background overlay
                  child: Center(child: DealerForm(dealerCode: dealerCode)),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: isFormVisible
          ? null // Hide FAB when the form is visible
          : const AddButton(),
    );
  }
}

class DealerForm extends ConsumerWidget {
  final TextEditingController dealerCode;

  const DealerForm({
    Key? key,
    required this.dealerCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TxtField(
              contentPadding: const EdgeInsets.all(10.0),
              capitalization: TextCapitalization.characters,
              labelText: "Dealer Code",
              hintText: "Dealer Code",
              maxLines: 1,
              controller: dealerCode,
              keyboardType: TextInputType.text,
              validator: validateCode,
            ),
            heightSizedBox(15.00),
            const BrandDropDown(
              items: [
                "SAMSUNG",
                "APPLE",
                "GOOGLE",
                "OPPO",
                "VIVO",
                "ONEPLUS",
                "REALME",
                "NOTHING",
                "XIAOMI",
                "MOTOROLA",
                "NOKIA",
                "INFINIX",
                "OTHER"
              ],
            ),
            heightSizedBox(15.0),
            const ModelDropDawn(),
            heightSizedBox(15.0),
            const QuantitySelector(),
            heightSizedBox(15.0),
            const PaymentModeDropDawn(
              items: ["Cash", "Online"],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // Hide the form on cancel
                    ref.read(formVisibilityProvider.notifier).state = false;
                  },
                  child: const Text("Cancel"),
                ),
                // ElevatedButton(
                //   onPressed: () async {
                //     final id = ref.read(selectedModelIdProvider);
                //     final quantity = ref.read(quantityProvider);
                //     final paymantMode = ref.read(paymentModeProvider);

                //     log("ID${id}");
                //     log("quantity${quantity.runtimeType}");
                //     log("paymantMode${paymantMode.runtimeType}");
                //     log("DealerCOde=${dealerCode.text.runtimeType}");

                //     await ref.read(productRepoProvider).addRecord(data: {
                //       "productId": id,
                //       "dealerCode": dealerCode.text,
                //       "quantity": quantity,
                //       "modeOfPayment": paymantMode,
                //     });

                //     ref.read(formVisibilityProvider.notifier).state = false;
                //   },
                //   child: const Text("OK"),
                // ),
                ElevatedButton(
                  onPressed: () {
                    final id = ref.read(selectedModelIdProvider);
                    final quantity = ref.read(quantityProvider);
                    final paymantMode = ref.read(paymentModeProvider);

                    log("ID: ${id.runtimeType}");
                    log("Quantity: $quantity");
                    log("Payment Mode: $paymantMode");
                    log("Dealer Code: ${dealerCode.text}");

                    // If paymentMode is "Cash", set it to "Offline" for API
                    final apiPaymentMode =
                        paymantMode == "Cash" ? "Offline" : paymantMode;

                    // Logging the full data map before sending it to the backend
                    final dataToSend = {
                      "productId": id,
                      "dealerCode": dealerCode.text,
                      "quantity": quantity,
                      "modeOfPayment": apiPaymentMode,
                    };

                    log("Data to send: $dataToSend");

                    // Send data to the backend
                    ref.read(productRepoProvider).addRecord(data: dataToSend);

                    ref.read(formVisibilityProvider.notifier).state = false;
                  },
                  child: const Text("OK"),
                ),

                // ElevatedButton(
                //   onPressed: () {
                //     final id = ref.read(selectedModelIdProvider);
                //     final quantity = ref.read(quantityProvider);
                //     final paymantMode = ref.read(paymentModeProvider);

                //     log("ID: ${id.runtimeType}");
                //     log("Quantity: $quantity");
                //     log("Payment Mode: $paymantMode");
                //     log("Dealer Code: ${dealerCode.text}");

                //     // Logging the full data map before sending it to the backend
                //     final dataToSend = {
                //       "productId": id,
                //       "dealerCode": dealerCode.text,
                //       "quantity": quantity,
                //       "modeOfPayment": paymantMode,
                //     };

                //     log("Data to send: $dataToSend");

                //     // Send data to the backend
                //     ref.read(productRepoProvider).addRecord(data: dataToSend);

                //     ref.read(formVisibilityProvider.notifier).state = false;
                //   },
                //   child: const Text("OK"),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddButton extends ConsumerWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        // Show the form when FAB is clicked
        ref.read(formVisibilityProvider.notifier).state = true;
      },
      shape: const CircleBorder(),
      backgroundColor: AppColor.primaryColor,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// // StateProvider for form visibility
// final formVisibilityProvider = StateProvider<bool>((ref) => false);

// class UploadDailyReport extends ConsumerWidget {
//   const UploadDailyReport({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isFormVisible = ref.watch(formVisibilityProvider);  // Watch the form visibility state
    
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: const CustomAppBar(),
//       body: Stack(
//         children: [
//           const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TopNames(),
//               ShowTable(),
//             ],
//           ),
//           if (isFormVisible)
//             Positioned.fill(
//               child: GestureDetector(
//                 onTap: () {
//                   // Hide the form when tapping outside
//                   ref.read(formVisibilityProvider.notifier).state = false;
//                 },
//                 child: Container(
//                   color: Colors.black54,  // Background overlay
//                   child: Center(
//                     child: _buildForm(context, ref),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//       floatingActionButton: AddButton(),
//     );
//   }

//   // Build the form UI inside a container
//   Widget _buildForm(BuildContext context, WidgetRef ref) {
//     TextEditingController dealerCode = TextEditingController();

//     return Container(
//       width: MediaQuery.of(context).size.width * 0.9,
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             TxtField(
//               contentPadding: const EdgeInsets.all(10.0),
//               capitalization: TextCapitalization.characters,
//               labelText: "Dealer Code",
//               hintText: "Dealer Code",
//               maxLines: 1,
//               controller: dealerCode,
//               keyboardType: TextInputType.text,
//               validator: validateCode,
//             ),
//             heightSizedBox(15.00),
//             const BrandDropDown(
//               items: [
//                 "SAMSUNG",
//                 "APPLE",
//                 "GOOGLE",
//                 "OPPO",
//                 "VIVO",
//                 "ONEPLUS",
//                 "REALME",
//                 "NOTHING",
//                 "XIAOMI",
//                 "MOTOROLA",
//                 "NOKIA",
//                 "INFINIX",
//                 "OTHER"
//               ],
//             ),
//             heightSizedBox(15.0),
//             const ModelDropDawn(),
//             heightSizedBox(15.0),
//             const QuantitySelector(),
//             heightSizedBox(15.0),
//             const PaymentModeDropDawn(
//               items: ["Cash", "Online"],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     // Hide the form on cancel
//                     ref.read(formVisibilityProvider.notifier).state = false;
//                   },
//                   child: const Text("Cancel"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Perform any submission action
//                     ref.read(formVisibilityProvider.notifier).state = false;  // Hide the form on submission
//                   },
//                   child: const Text("OK"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AddButton extends ConsumerWidget {
//   const AddButton({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return FloatingActionButton(
//       onPressed: () {
//         // Show the form when FAB is clicked
//         ref.read(formVisibilityProvider.notifier).state = true;
//       },
//       shape: const CircleBorder(),
//       backgroundColor: AppColor.primaryColor,
//       child: const Icon(
//         Icons.add,
//         color: Colors.white,
//       ),
//     );
//   }
// }
