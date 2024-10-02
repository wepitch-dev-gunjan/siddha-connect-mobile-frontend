import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/common_style.dart';
import '../../utils/cus_appbar.dart';
import '../../utils/fields.dart';
import '../../utils/sizes.dart';
import '../components/dropDawns.dart';
import '../components/floating_add_button.dart';
import '../components/table.dart';
import '../repo/product_repo.dart';

final formVisibilityProvider = StateProvider<bool>((ref) => false);

class ExtractionDataUpload extends ConsumerStatefulWidget {
  const ExtractionDataUpload({super.key});

  @override
  ConsumerState<ExtractionDataUpload> createState() =>
      _ExtractionDataUploadState();
}

class _ExtractionDataUploadState extends ConsumerState<ExtractionDataUpload> {
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
                // Dismiss only when tapping outside the form
                ref.read(formVisibilityProvider.notifier).state = false;
              },
              child: Container(
                color: Colors.black54, // Background overlay
                child: Center(
                  child: GestureDetector(
                    // Prevent dismissal when tapping inside the form
                    onTap: () {},
                    child: ExtractionDataForm(dealerCode: dealerCode),
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

class ExtractionDataForm extends ConsumerWidget {
  final TextEditingController dealerCode;

  const ExtractionDataForm({super.key, required this.dealerCode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBrand = ref.watch(selectedBrandProvider);

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
              // hintText: "Dealer Code",
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
            selectedBrand == "OTHER"
                ? const SegmentDropDown()
                : const ModelDropDawn(),
            heightSizedBox(15.0),
            const QuantitySelector(),
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
                    final id = ref.read(selectedModelIdProvider);
                    final quantity = ref.read(quantityProvider);

                    final dataToSend = {
                      "productId": id,
                      "dealerCode": dealerCode.text,
                      "quantity": quantity,
                    };
                    ref
                        .read(productRepoProvider)
                        .extractionDataUpload(data: dataToSend);
                    ref.read(formVisibilityProvider.notifier).state = false;
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
    );
  }
}
