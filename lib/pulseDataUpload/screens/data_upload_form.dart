import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/utils/buttons.dart';
import 'package:siddha_connect/utils/sizes.dart';
import '../../common/common.dart';
import '../../common/dashboard_options.dart';
import '../../salesDashboard/repo/sales_dashboard_repo.dart';
import '../../utils/cus_appbar.dart';
import '../components/dropDawns.dart';
import '../components/top_profile_name.dart';

final getDealerListProvider = FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final getDealerList = await ref
      .watch(salesRepoProvider)
      .getDealerListForEmployeeData(
          startDate: options.firstDate, endDate: options.lastDate);
  return getDealerList;
});

class UploadForm extends ConsumerWidget {
  const UploadForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dealerList = ref.watch(getDealerListProvider);
    final selectedBrand =
        ref.watch(selectedBrandProvider); // Watch the selected brand

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: dealerList.when(
        data: (data) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              children: [
                const TopProfileName(),
                heightSizedBox(15.0),
                DealerDropDown(data: data),
                heightSizedBox(15.0),

                BrandDropDown(items: modelList),
                heightSizedBox(15.0),

                // Conditionally show ModelDropDawnTest based on selectedBrand state
                if (selectedBrand != null) ...[
                  const ModelDropDawnTest(),
                ],
              ],
            ),
          );
        },
        error: (error, stackTrace) => const Center(
          child: Text("Something went wrong"),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Btn(
            btnName: "Submit",
            onPressed: () {
              final quantity = ref.read(modelQuantityProvider);
              final id = ref.read(selectModelIDProvider1);
              final model = ref.read(selectedModelProvider);
              log("quantity$quantity");
              log("id$id");
              log("model$model");
            }),
      ),
    );
  }
}

final selectedDealerProvider = StateProvider<String?>((ref) => null);

class DealerDropDown extends ConsumerWidget {
  final dynamic data;
  const DealerDropDown({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedModel = ref.watch(selectedDealerProvider);

    final List<Map<String, dynamic>> products =
        List<Map<String, dynamic>>.from(data is List ? data : []);

    final List<String> modelNames = products
        .where((product) => product['BUYER'] != null)
        .map((product) => product['BUYER'] as String)
        .toList();

    if (modelNames.isEmpty) {
      return const Text("No models available");
    }

    return SizedBox(
      width: double.infinity,
      child: DropdownButtonFormField<String>(
        value: selectedModel,
        style: const TextStyle(
          fontSize: 16.0,
          height: 1.5,
          color: Colors.black87,
        ),
        dropdownColor: Colors.white,
        decoration: inputDecoration(label: "Select Dealer"),
        onChanged: (newValue) {
          ref.read(selectedDealerProvider.notifier).state = newValue;
          final selectedProduct =
              products.firstWhere((product) => product['BUYER'] == newValue);
          ref.read(selectedModelIdProvider.notifier).state =
              selectedProduct['BUYER CODE'];
        },
        hint: const Text("Select Dealer"),
        items: modelNames.map<DropdownMenuItem<String>>((model) {
          final buyerCode = products
              .firstWhere((product) => product['BUYER'] == model)['BUYER CODE'];
          return DropdownMenuItem<String>(
            value: model,
            child: ListTile(
              title: Text(model), // Show the buyer
              subtitle: Text(buyerCode), // Show the buyer code
            ),
          );
        }).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a dealer';
          }
          return null; // No error
        },
        menuMaxHeight: MediaQuery.of(context).size.height / 2,
        icon: const Icon(Icons.arrow_drop_down), // Default dropdown icon
        isExpanded: true, // Ensures that dropdown stretches to fit the text
        selectedItemBuilder: (BuildContext context) {
          return modelNames.map((model) {
            return Text(
              model, // Show only the buyer (model) as selected value
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            );
          }).toList();
        },
      ),
    );
  }
}

final selectedModelProvider = StateProvider<List<String>>((ref) => []);
final selectModelIDProvider1 = StateProvider<List<String>>((ref) => []);
final modelQuantityProvider = StateProvider<Map<String, int>>((ref) => {});

class ModelDropDawnTest extends ConsumerWidget {
  const ModelDropDawnTest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBrand = ref.watch(selectedBrandProvider);
    final selectedModels =
        ref.watch(selectedModelProvider); // List of selected models
    final modelQuantities =
        ref.watch(modelQuantityProvider); // Model quantities
    final getModels = ref.watch(getModelsProvider(selectedBrand));

    return getModels.when(
      data: (data) {
        if (data == null || data['products'] == null) {
          return const Text("No models available");
        }

        final List<Map<String, dynamic>> products =
            List<Map<String, dynamic>>.from(data['products']);
        final List<String> modelNames = products
            .where((product) => product['Model'] != null)
            .map((product) => product['Model'] as String)
            .toList();

        if (modelNames.isEmpty) {
          return const Text("No models available");
        }

        return SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextFormField acting like DropdownButtonFormField
              TextFormField(
                readOnly: true,
                decoration: inputDecoration(
                    label: "Select Models", hintText: "Select Models"),
                onTap: () async {
                  final Map<String, int>? selectedModelsWithQuantities =
                      await showModalBottomSheet<Map<String, int>>(
                    context: context,
                    isScrollControlled: true, // Full screen
                    builder: (context) {
                      final tempSelectedModels =
                          Map<String, int>.from(modelQuantities);

                      return StatefulBuilder(
                        builder: (context, setState) {
                          // Total quantity calculation
                          int totalQuantity = tempSelectedModels.values
                              .fold(0, (sum, quantity) => sum + quantity);

                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heightSizedBox(50.0),
                                Text(
                                  "Select Models and Quantities",
                                  style: GoogleFonts.lato(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                heightSizedBox(5.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 0.1),
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      child: Center(
                                        child: Text(
                                          "Total: $totalQuantity",
                                          style: GoogleFonts.lato(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                heightSizedBox(5.0),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: ListBody(
                                      children: modelNames.map((model) {
                                        final quantity =
                                            tempSelectedModels[model] ?? 0;
                                        final isSelected = quantity > 0;
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? Colors.green
                                                : Colors.transparent,
                                            border: Border.all(
                                              color: isSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                              width: 0.1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Model name (wrapped for long text)
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      model,
                                                      maxLines:
                                                          2, // Allow name to wrap
                                                      overflow: TextOverflow
                                                          .ellipsis, // Ellipsis for overflow
                                                      style: TextStyle(
                                                        color: isSelected
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.remove,
                                                      color: isSelected
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      if (quantity > 0) {
                                                        setState(() {
                                                          tempSelectedModels[
                                                                  model] =
                                                              quantity - 1;
                                                          if (tempSelectedModels[
                                                                  model] ==
                                                              0) {
                                                            tempSelectedModels
                                                                .remove(model);
                                                          }
                                                          // Update total quantity
                                                          totalQuantity =
                                                              tempSelectedModels
                                                                  .values
                                                                  .fold(
                                                            0,
                                                            (sum, qty) =>
                                                                sum + qty,
                                                          );
                                                        });
                                                      }
                                                    },
                                                  ),
                                                  Text(
                                                    quantity.toString(),
                                                    style: TextStyle(
                                                      color: isSelected
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                  ), // Display quantity
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.add,
                                                      color: isSelected
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        tempSelectedModels[
                                                                model] =
                                                            quantity + 1;
                                                        // Update total quantity
                                                        totalQuantity =
                                                            tempSelectedModels
                                                                .values
                                                                .fold(
                                                                    0,
                                                                    (sum, qty) =>
                                                                        sum +
                                                                        qty);
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text(
                                        'OK',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(tempSelectedModels);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );

                  if (selectedModelsWithQuantities != null) {
                    ref.read(modelQuantityProvider.notifier).state =
                        selectedModelsWithQuantities;

                    final selectedProductIds = products
                        .where((product) => selectedModelsWithQuantities.keys
                            .contains(product['Model']))
                        .map((product) => product['_id'] as String)
                        .toList();
                    ref.read(selectModelIDProvider1.notifier).state =
                        selectedProductIds;

                    final selectedModelNames = selectedModelsWithQuantities.keys
                        .where(
                            (model) => selectedModelsWithQuantities[model]! > 0)
                        .toList();
                    ref.read(selectedModelProvider.notifier).state =
                        selectedModelNames;
                  }
                },
              ),
              const SizedBox(height: 10),
              const Text("Selected Models:"),
              ...selectedModels.map((model) {
                final quantity = modelQuantities[model] ?? 1;

                return Row(
                  children: [
                    Expanded(child: Text(model)), // Model name
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (quantity > 1) {
                          // Reduce quantity
                          final newQuantities =
                              Map<String, int>.from(modelQuantities);
                          newQuantities[model] = quantity - 1;
                          ref.read(modelQuantityProvider.notifier).state =
                              newQuantities;
                        }
                      },
                    ),
                    Text(quantity.toString()), // Display quantity
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        // Increase quantity
                        final newQuantities =
                            Map<String, int>.from(modelQuantities);
                        newQuantities[model] = quantity + 1;
                        ref.read(modelQuantityProvider.notifier).state =
                            newQuantities;
                      },
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        );
      },
      error: (error, stackTrace) => Text("Error loading data: $error"),
      loading: () => const SizedBox(),
    );
  }
}

