import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/common_style.dart';
import '../../utils/cus_appbar.dart';
import '../../utils/fields.dart';
import '../../utils/sizes.dart';
import '../components/dropDawns.dart';
import '../components/floating_add_button.dart';
import '../components/table.dart';
import '../repo/product_repo.dart';

final formVisibilityProvider = StateProvider<bool>((ref) => false);

class PulseDataUpload extends ConsumerStatefulWidget {
  const PulseDataUpload({super.key});

  @override
  ConsumerState<PulseDataUpload> createState() => _PulseDataUploadState();
}

class _PulseDataUploadState extends ConsumerState<PulseDataUpload> {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopNames(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Text(
                  "Pulse Data Upload",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              heightSizedBox(10.0),
              const ShowTable(),
            ],
          ),
          if (isFormVisible)
            Positioned.fill(
                child: GestureDetector(
              onTap: () {
                // Dismiss only when tapping outside the form
                ref.read(formVisibilityProvider.notifier).state = false;
              },
              child: Container(
                color: Colors.black54, // Background overlay
                child: Center(
                  child: GestureDetector(
                    // Prevent dismissal when tapping inside the form
                    onTap: () {},
                    child: PulseDataForm(dealerCode: dealerCode),
                  ),
                ),
              ),
            ))
        ],
      ),
      floatingActionButton: isFormVisible ? null : const AddButton(),
    );
  }
}

class PulseDataForm extends ConsumerWidget {
  final TextEditingController dealerCode;

  PulseDataForm({super.key, required this.dealerCode});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBrand = ref.watch(selectedBrandProvider);
    log("selectedBrand$selectedBrand");
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TxtField(
                contentPadding: const EdgeInsets.all(10.0),
                capitalization: TextCapitalization.characters,
                labelText: "Dealer Code",
                // hintText: "Dealer Code",
                maxLines: 1,
                controller: dealerCode,
                keyboardType: TextInputType.text,
                validator: validateCode,
              ),
              heightSizedBox(15.00),
              const BrandDropDown(
                items: [
                  "Samsung",
                  "Apple",
                  "Oppo",
                  "Vivo",
                  "OnePlus",
                  "Realme",
                  "Xiaomi",
                  "Motorola",
                  "Others (>100K)",
                  "Others (70-100K)",
                  "Others (40-70K)",
                  "Others (30-40K)",
                  "Others (20-30K)",
                  "Others (15-20K)",
                  "Others (10-15K)",
                  "Others (6-10K)"
                ],
              ),
              heightSizedBox(15.0),
              // selectedBrand == "OTHER"
              //     ? const SegmentDropDown()
              const ModelDropDawn(),
              heightSizedBox(15.0),
              const QuantitySelector(),
              heightSizedBox(15.0),
              const PaymentModeDropDawn(
                items: ["Cash", "Online"],
              ),
              heightSizedBox(10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      ref.read(formVisibilityProvider.notifier).state = false;
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final id = ref.read(selectedModelIdProvider);
                        final quantity = ref.read(quantityProvider);
                        final paymantMode = ref.read(paymentModeProvider);
                        final apiPaymentMode =
                            paymantMode == "Cash" ? "Offline" : paymantMode;
                        final dataToSend = {
                          "productId": id,
                          "dealerCode": dealerCode.text,
                          "quantity": quantity,
                          "modeOfPayment": apiPaymentMode,
                        };
                        ref
                            .read(productRepoProvider)
                            .pulseDataUpload(data: dataToSend);
                        ref.read(formVisibilityProvider.notifier).state = false;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
