import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/pulseDataUpload/components/table.dart';
import 'package:siddha_connect/pulseDataUpload/repo/product_repo.dart';
import 'package:siddha_connect/utils/buttons.dart';
import 'package:siddha_connect/utils/common_style.dart';
import 'package:siddha_connect/utils/sizes.dart';
import '../../common/common.dart';
import '../../common/dashboard_options.dart';
import '../../salesDashboard/repo/sales_dashboard_repo.dart';
import '../../utils/cus_appbar.dart';
import '../components/dealer_dropdown.dart';
import '../components/drop_downs.dart';
import '../components/model_dropdown.dart';
import '../components/top_profile_name.dart';

final getDealerListProvider = FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final getDealerList = await ref
      .watch(salesRepoProvider)
      .getDealerListForEmployeeData(
          startDate: options.firstDate, endDate: options.lastDate);
  ref.keepAlive();
  return getDealerList;
});

class ExtractionUploadForm extends ConsumerWidget {
  const ExtractionUploadForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dealerList = ref.watch(getDealerListProvider);
    final selectedBrand = ref.watch(selectedBrandProvider);
    final selectedDealer = ref.watch(selectedDealerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: dealerList.when(
        data: (data) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const TopProfileName(),
                  heightSizedBox(15.0),
                  DealerDropDown(data: data),
                  heightSizedBox(15.0),
                  if (selectedDealer != null) ...[
                    BrandDropDown(items: brandList),
                    heightSizedBox(15.0),
                  ],
                  if (selectedBrand != null) const ModelDropDawnTest(),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) => const Center(
          child: Text("Something went wrong"),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: AppColor.primaryColor,
            strokeWidth: 3,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Btn(
          btnName: "Submit",
          onPressed: () {
            final quantity = ref.read(modelQuantityProvider);
            final dealer = ref.read(selectedDealerProvider);
            if (dealer != null && quantity.isNotEmpty) {
              List<Map<String, dynamic>> productList = [];
              quantity.forEach((productId, modelData) {
                final productQuantity = modelData['quantity'];
                productList.add({
                  "productId": productId,
                  "quantity": productQuantity,
                });
              });
              final dataToSend = {
                'dealerCode': dealer['BUYER CODE'],
                'products': productList,
              };
              ref
                  .read(productRepoProvider)
                  .extractionDataUpload(data: dataToSend)
                  .then((_) {
                var refreshedData = ref.refresh(getExtractionRecordProvider);
                ref.read(modelQuantityProvider.notifier).state = {};
                ref.read(selectedDealerProvider.notifier).state = null;
                ref.read(selectedBrandProvider.notifier).state = null;
                Navigator.pop(context);
              }).catchError((error) {
                log("Error during data upload: $error");
              });
            } else {
              log("Dealer or models not selected.");
            }
          },
        ),
      ),
    );
  }
}

class PulseUploadForm extends ConsumerWidget {
  const PulseUploadForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dealerList = ref.watch(getDealerListProvider);
    final selectedBrand = ref.watch(selectedBrandProvider);
    final selectedDealer = ref.watch(selectedDealerProvider);
    final paymentMode = ref.watch(paymentModeProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: dealerList.when(
        data: (data) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const TopProfileName(),
                  heightSizedBox(15.0),
                  DealerDropDown(data: data),
                  heightSizedBox(15.0),
                  if (selectedDealer != null)
                    const PaymentModeDropDawn(items: ["Online", "Offline"]),
                  heightSizedBox(15.0),
                  if (selectedDealer != null) ...[
                    BrandDropDown(items: brandList),
                    heightSizedBox(15.0),
                  ],
                  if (selectedBrand != null) const ModelDropDawnTest(),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) => const Center(
          child: Text("Something went wrong"),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: AppColor.primaryColor,
            strokeWidth: 3,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Btn(
          btnName: "Submit",
          onPressed: () {
            final quantity = ref.read(modelQuantityProvider);
            final dealer = ref.read(selectedDealerProvider);
            final paymentMode = ref.read(paymentModeProvider);
            if (dealer != null && quantity.isNotEmpty) {
              List<Map<String, dynamic>> productList = [];
              quantity.forEach((productId, modelData) {
                final productQuantity = modelData['quantity'];
                productList.add({
                  "productId": productId,
                  "quantity": productQuantity,
                });
              });
              final dataToSend = {
                'dealerCode': dealer['BUYER CODE'],
                'products': productList,
                "modeOfPayment": paymentMode
              };
              ref
                  .read(productRepoProvider)
                  .pulseDataUpload(data: dataToSend)
                  .then((_) {
                var refreshedData = ref.refresh(getExtractionRecordProvider);
                ref.read(modelQuantityProvider.notifier).state = {};
                ref.read(selectedDealerProvider.notifier).state = null;
                ref.read(selectedBrandProvider.notifier).state = null;
                Navigator.pop(context);
              }).catchError((error) {
                log("Error during data upload: $error");
              });
            } else {
              log("Dealer or models not selected.");
            }
          },
        ),
      ),
    );
  }
}
