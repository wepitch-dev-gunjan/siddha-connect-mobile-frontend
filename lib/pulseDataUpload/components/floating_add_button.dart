import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/common_style.dart';
import '../../utils/drawer.dart';
import '../../utils/fields.dart';
import '../../utils/sizes.dart';
import 'dropDawns.dart';

// Quantity provider to manage state

class AddButton extends ConsumerWidget {
  TextEditingController dealerCode = TextEditingController();
  AddButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add Data'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TxtField(
                        contentPadding: contentPadding,
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
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    child: const Text("OK"),
                    onPressed: () {
                      ref.read(selectedBrandProvider.notifier).state = null;
                      ref.read(selectedModelProvider.notifier).state = null;
                      ref.read(selectedPriceProvider.notifier).state = null;
                      ref.read(paymentModeProvider.notifier).state = null;
                      ref.read(quantityProvider.notifier).state = 1;
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
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

// class QuantitySelector extends ConsumerWidget {
//   const QuantitySelector({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final quantity = ref.watch(quantityProvider);

//     return InputDecorator(
//       decoration: inputDecoration(label: "Select Quantity"),
//       child: SizedBox(
//         height: 35,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconButton(
//               onPressed: () {
//                 if (quantity > 1) {
//                   ref.read(quantityProvider.notifier).state--;
//                 }
//               },
//               icon: const Icon(Icons.remove, color: Colors.black54),
//             ),
//             Text(
//               '$quantity',
//               style: const TextStyle(fontSize: 18),
//             ),
//             IconButton(
//               onPressed: () {
//                 ref.read(quantityProvider.notifier).state++;
//               },
//               icon: const Icon(Icons.add, color: Colors.black54),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class TopNames extends ConsumerWidget {
  const TopNames({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employData = ref.watch(userProfileProvider);
    return employData.when(
      data: (data) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Name   :    ",
                    style: GoogleFonts.lato(
                        fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(border: Border.all()),
                    child: Center(
                      child: Text(
                        data['name'] ?? "N/A",
                        style: GoogleFonts.lato(
                            fontSize: 12.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
              heightSizedBox(10.0),
              Row(
                children: [
                  Text(
                    "Code   :     ",
                    style: GoogleFonts.lato(
                        fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    data['code'],
                    style: GoogleFonts.lato(
                        fontSize: 12.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => const Center(
        child: Text("Something went wrong"),
      ),
    );
  }
}
