import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/utils/common_style.dart';
import '../../utils/sizes.dart';
import 'drop_downs.dart';

final selectedModelProvider = StateProvider<List<String>>((ref) => []);
final selectModelIDProvider1 = StateProvider<List<String>>((ref) => []);
final modelQuantityProvider =
    StateProvider<Map<String, Map<String, dynamic>>>((ref) => {});

class ModelDropDawnTest extends ConsumerWidget {
  const ModelDropDawnTest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBrand = ref.watch(selectedBrandProvider);
    ref.listen(selectedBrandProvider, (previous, next) {
      if (previous != next) {}
    });

    final selectedModelIDs = ref.watch(selectModelIDProvider1);
    final modelQuantities = ref.watch(modelQuantityProvider);
    final getModels = ref.watch(getModelsProvider(selectedBrand));
    final totalQuantity = modelQuantities.values.fold(
      0,
      (sum, modelData) => sum + (modelData['quantity'] ?? 0) as int,
    );

    return getModels.when(
      data: (data) {
        if (data == null || data['products'] == null) {
          return const Text("No models available");
        }

        final List<Map<String, dynamic>> products =
            List<Map<String, dynamic>>.from(data['products']);

        if (products.isEmpty) {
          return const Text("No models available");
        }

        var tempSelectedModels =
            Map<String, Map<String, dynamic>>.from(modelQuantities);

        return SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                readOnly: true,
                decoration: inputDecoration(
                    label: "Select Models", hintText: "Select Models"),
                onTap: () async {
                  final Map<String, Map<String, dynamic>>?
                      selectedModelsWithQuantities = await showModalBottomSheet<
                          Map<String, Map<String, dynamic>>>(
                    backgroundColor: Colors.white,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                     
                      String searchText = '';
                      return StatefulBuilder(
                        builder: (context, setState) {
                          int totalQuantity = tempSelectedModels.values.fold(
                              0,
                              (sum, modelData) =>
                                  sum + modelData['quantity'] as int);
                          final filteredProducts = products.where((product) {
                            final modelName =
                                product['Model']?.toLowerCase() ?? '';
                            return modelName.contains(searchText.toLowerCase());
                          }).toList();

                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heightSizedBox(50.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Select Models and Quantities",
                                      style: GoogleFonts.lato(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "$totalQuantity Items",
                                      style: GoogleFonts.lato(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                heightSizedBox(10.0),
                                CupertinoSearchTextField(
                                  placeholder: 'Search Models',
                                  onChanged: (value) {
                                    setState(() {
                                      searchText = value; // Update search text
                                    });
                                  },
                                ),
                                heightSizedBox(10.0),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: ListBody(
                                      children: filteredProducts.map((product) {
                                        final modelName = product['Model'];
                                        final modelId = product['_id'];
                                        final quantity =
                                            tempSelectedModels[modelId]
                                                    ?['quantity'] ??
                                                0;
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
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      modelName,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                              modelId] = {
                                                            'name': modelName,
                                                            'quantity':
                                                                quantity - 1,
                                                          };
                                                          if (tempSelectedModels[
                                                                      modelId]![
                                                                  'quantity'] ==
                                                              0) {
                                                            tempSelectedModels
                                                                .remove(
                                                                    modelId);
                                                          }
                                                          totalQuantity = tempSelectedModels
                                                              .values
                                                              .fold(
                                                                  0,
                                                                  (sum, modelData) =>
                                                                      sum + modelData['quantity']
                                                                          as int);
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
                                                  ),
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
                                                            modelId] = {
                                                          'name': modelName,
                                                          'quantity':
                                                              quantity + 1,
                                                        };
                                                        totalQuantity = tempSelectedModels
                                                            .values
                                                            .fold(
                                                                0,
                                                                (sum, modelData) =>
                                                                    sum + modelData['quantity']
                                                                        as int);
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
                                Container(
                                  height: 0.5,
                                  width: width(context),
                                  color: Colors.black,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ButtonStyle(
                                          foregroundColor:
                                              WidgetStateProperty.all<Color>(
                                                  Colors.black),
                                          shape: WidgetStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          "Cancel",
                                        )),
                                    widthSizedBox(10.0),
                                    TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
                                                AppColor.primaryColor),
                                        shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        'OK',
                                        style: TextStyle(color: Colors.white),
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
                    // Update the global state once the modal is closed
                    ref.read(modelQuantityProvider.notifier).state =
                        selectedModelsWithQuantities;

                    final selectedProductIds =
                        selectedModelsWithQuantities.keys.toList();
                    ref.read(selectModelIDProvider1.notifier).state =
                        selectedProductIds;

                    final selectedModelNames = selectedModelsWithQuantities
                        .values
                        .map((modelData) => modelData['name'] as String)
                        .toList();
                    ref.read(selectedModelProvider.notifier).state =
                        selectedModelNames;
                  }
                },
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Selected Models:",
                    style: GoogleFonts.lato(fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      "Total: $totalQuantity",
                      style: GoogleFonts.lato(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              heightSizedBox(10.0),
              ...modelQuantities.entries.map((entry) {
                final modelId = entry.key;
                final modelData = entry.value;
                final modelName = modelData['name'];
                final quantity = modelData['quantity'] ?? 1;

                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            modelName,
                            style: const TextStyle(color: Colors.white),
                          )), // Model name

                          quantity == 1
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  onPressed: () {
                                    final newQuantities =
                                        Map<String, Map<String, dynamic>>.from(
                                            modelQuantities);
                                    newQuantities.remove(modelId);
                                    ref
                                        .read(modelQuantityProvider.notifier)
                                        .state = newQuantities;

                                    final newSelectedModelIds = ref
                                        .read(selectModelIDProvider1)
                                        .where((id) => id != modelId)
                                        .toList();
                                    ref
                                        .read(selectModelIDProvider1.notifier)
                                        .state = newSelectedModelIds;

                                    final newSelectedModelNames = ref
                                        .read(selectedModelProvider)
                                        .where(
                                            (name) => name != modelData['name'])
                                        .toList();
                                    ref
                                        .read(selectedModelProvider.notifier)
                                        .state = newSelectedModelNames;
                                  },
                                )
                              : IconButton(
                                  icon: const Icon(
                                    Icons
                                        .remove, // Show - button if quantity is more than 1
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    if (quantity > 1) {
                                      final newQuantities = Map<String,
                                              Map<String, dynamic>>.from(
                                          modelQuantities);
                                      newQuantities[modelId]!['quantity'] =
                                          quantity - 1;
                                      ref
                                          .read(modelQuantityProvider.notifier)
                                          .state = newQuantities;
                                    }
                                  },
                                ),
                          Text(
                            quantity.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              final newQuantities =
                                  Map<String, Map<String, dynamic>>.from(
                                      modelQuantities);
                              newQuantities[modelId]!['quantity'] =
                                  quantity + 1;
                              ref.read(modelQuantityProvider.notifier).state =
                                  newQuantities;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        );
      },
      error: (error, stack) => Text('Error: $error'),
      loading: () => const SizedBox(
          height: 10,
          width: 10,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          )),
    );
  }
}
