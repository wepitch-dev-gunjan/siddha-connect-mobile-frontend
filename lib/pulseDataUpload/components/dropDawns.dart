import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repo/product_repo.dart';

final selectedBrandProvider = StateProvider<String?>((ref) => null);
final selectedModelProvider = StateProvider<String?>((ref) => null);
final selectedPriceProvider = StateProvider<String?>((ref) => null);
final paymentModeProvider = StateProvider<String?>((ref) => null);
final quantityProvider = StateProvider<int>((ref) => 1);

// class BrandDropDown extends ConsumerWidget {
//   final List<String> items;
//   const BrandDropDown({
//     super.key,
//     required this.items,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedBrand = ref.watch(selectedBrandProvider);
//     return DropdownButtonFormField<String>(
//       value: selectedBrand,
//       style: const TextStyle(
//         fontSize: 16.0,
//         height: 1.5,
//         color: Colors.black87,
//       ),
//       decoration: inputDecoration(label: "Select Brand"),
//       onChanged: (newValue) {
//         ref.read(selectedBrandProvider.notifier).state = newValue;
//       },
//       hint: const Text("Select Brand"),
//       items: items.map<DropdownMenuItem<String>>((value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//       menuMaxHeight: MediaQuery.of(context).size.height / 2,
//     );
//   }
// }

// class BrandDropDown extends ConsumerWidget {
//   final List<String> items;
//   const BrandDropDown({
//     super.key,
//     required this.items,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedBrand = ref.watch(selectedBrandProvider);
//     return DropdownButtonFormField<String>(
//       value: selectedBrand,
//       style: const TextStyle(
//         fontSize: 16.0,
//         height: 1.5,
//         color: Colors.black87,
//       ),
//       dropdownColor: Colors.white,
//       decoration: inputDecoration(label: "Select Brand"),
//       onChanged: (newValue) {
//         // Reset selected model when a new brand is selected
//         ref.read(selectedBrandProvider.notifier).state = newValue;
//         ref.read(selectedModelProvider.notifier).state =
//             null; // Clear selected model
//         ref.read(selectedModelIdProvider.notifier).state =
//             null; // Clear model id
//       },
//       hint: const Text("Select Brand"),
//       items: items.map<DropdownMenuItem<String>>((value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//       menuMaxHeight: MediaQuery.of(context).size.height / 2,
//     );
//   }
// }

class BrandDropDown extends ConsumerWidget {
  final List<String> items;
  const BrandDropDown({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBrand = ref.watch(selectedBrandProvider);
    return DropdownButtonFormField<String>(
      value: selectedBrand,
      style: const TextStyle(
        fontSize: 16.0,
        height: 1.5,
        color: Colors.black87,
      ),
      dropdownColor: Colors.white,
      decoration: inputDecoration(label: "Select Brand"),
      onChanged: (newValue) {
        // Reset selected model when a new brand is selected
        ref.read(selectedBrandProvider.notifier).state = newValue;
        ref.read(selectedModelProvider.notifier).state =
            null; // Clear selected model
        ref.read(selectedModelIdProvider.notifier).state =
            null; // Clear model id
      },
      hint: const Text("Select Brand"),
      items: items.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      menuMaxHeight: MediaQuery.of(context).size.height / 2,
      // Add validation
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a brand';
        }
        return null; // No error
      },
    );
  }
}

final getModelsProvider =
    FutureProvider.autoDispose.family((ref, String? brand) async {
  final productRepo = ref.watch(productRepoProvider);
  final data = await productRepo.getAllProducts(brand: brand);
  return data;
});

final selectedModelIdProvider = StateProvider<String?>((ref) => null);

// class ModelDropDawn extends ConsumerWidget {
//   const ModelDropDawn({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedBrand = ref.watch(selectedBrandProvider);
//     final selectedModel = ref.watch(selectedModelProvider);
//     final getModels = ref.watch(getModelsProvider(selectedBrand));

//     return getModels.when(
//       data: (data) {
//         if (data == null || data['products'] == null) {
//           return const Text("No models available");
//         }

//         final List<Map<String, dynamic>> products =
//             List<Map<String, dynamic>>.from(data['products']);
//         final List<String> modelNames = products
//             .where((product) => product['Model'] != null)
//             .map((product) => product['Model'] as String)
//             .toList();

//         if (modelNames.isEmpty) {
//           return const Text("No models available");
//         }

//         return DropdownButtonFormField<String>(
//           value: selectedModel,
//           style: const TextStyle(
//             fontSize: 16.0,
//             height: 1.5,
//             color: Colors.black87,
//           ),
//           dropdownColor: Colors.white,
//           decoration: inputDecoration(label: "Select Model"),
//           onChanged: (newValue) {
//             ref.read(selectedModelProvider.notifier).state = newValue;

//             final selectedProduct =
//                 products.firstWhere((product) => product['Model'] == newValue);
//             ref.read(selectedModelIdProvider.notifier).state =
//                 selectedProduct['_id'];
//           },
//           hint: const Text("Select Model"),
//           items: modelNames.map<DropdownMenuItem<String>>((model) {
//             return DropdownMenuItem<String>(
//               value: model,
//               child: Text(model),
//             );
//           }).toList(),
//           // validator: (value) {
//           //   if (value == null || value.isEmpty) {
//           //     return 'Please select a Model';
//           //   }
//           //   return null; // No error
//           // },
//           menuMaxHeight: MediaQuery.of(context).size.height / 2,
//         );
//       },
//       error: (error, stackTrace) => Text("Error loading data: $error"),
//       loading: () => const SizedBox(),
//     );
//   }
// }

class ModelDropDawn extends ConsumerWidget {
  const ModelDropDawn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBrand = ref.watch(selectedBrandProvider);
    final selectedModel = ref.watch(selectedModelProvider);
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
          width: double.infinity, // Ensure it takes full width available
          child: DropdownButtonFormField<String>(
            value: selectedModel,
            style: const TextStyle(
              fontSize: 16.0,
              height: 1.5,
              color: Colors.black87,
            ),
            dropdownColor: Colors.white,
            decoration: inputDecoration(label: "Select Model"),
            onChanged: (newValue) {
              ref.read(selectedModelProvider.notifier).state = newValue;

              final selectedProduct = products
                  .firstWhere((product) => product['Model'] == newValue);
              ref.read(selectedModelIdProvider.notifier).state =
                  selectedProduct['_id'];
            },
            hint: const Text("Select Model"),
            items: modelNames.map<DropdownMenuItem<String>>((model) {
              return DropdownMenuItem<String>(
                value: model,
                child: Text(model),
              );
            }).toList(),
            menuMaxHeight: MediaQuery.of(context).size.height / 2,
            icon: const Icon(Icons.arrow_drop_down), // Default dropdown icon
            isExpanded: true, // Ensures that dropdown stretches to fit the text
          ),
        );
      },
      error: (error, stackTrace) => Text("Error loading data: $error"),
      loading: () => const SizedBox(),
    );
  }
}

final selectedSegmentProvider = StateProvider<String?>((ref) => null);

class SegmentDropDown extends ConsumerWidget {
  const SegmentDropDown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Predefined list of 5 items
    final List<String> modelNames = [
      "100K",
      "70-100K",
      "40-70K",
      "> 40 K",
      "< 40 K",
      "30-40K",
      "20-30K",
      "15-20K",
      "10-15K",
      "6-10K",
      "Tab>40k",
      "Tab<40k",
      "Wearable"
    ];

    final selectedModel = ref.watch(selectedModelProvider);

    return DropdownButtonFormField<String>(
      value: selectedModel,
      style: const TextStyle(
        fontSize: 16.0,
        height: 1.5,
        color: Colors.black87,
      ),
      dropdownColor: Colors.white,
      decoration: inputDecoration(label: "Select Segment"),
      onChanged: (newValue) {
        ref.read(selectedModelProvider.notifier).state = newValue;
      },
      hint: const Text("Select Segment"),
      items: modelNames.map<DropdownMenuItem<String>>((model) {
        return DropdownMenuItem<String>(
          value: model,
          child: Text(model),
        );
      }).toList(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a Segment';
        }
        return null; // No error
      },
      menuMaxHeight: MediaQuery.of(context).size.height / 2,
    );
  }
}

class PaymentModeDropDawn extends ConsumerWidget {
  final List<String> items;

  const PaymentModeDropDawn({super.key, required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentMode = ref.watch(paymentModeProvider);
    return DropdownButtonFormField<String>(
      value: paymentMode,
      style: const TextStyle(
        fontSize: 16.0,
        height: 1.5,
        color: Colors.black87,
      ),
      dropdownColor: Colors.white,
      decoration: inputDecoration(label: "Payment Mode"),
      onChanged: (newValue) {
        ref.read(paymentModeProvider.notifier).state = newValue;
      },
      hint: const Text("Payment Mode"),
      items: items.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select Payment Mode';
        }
        return null; // No error
      },
    );
  }
}

class QuantitySelector extends ConsumerWidget {
  const QuantitySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(quantityProvider);

    return InputDecorator(
      decoration:
          inputDecoration(label: 'Select Quantity'), // Use the function here
      child: SizedBox(
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                if (quantity > 1) {
                  ref.read(quantityProvider.notifier).state--;
                }
              },
              icon: const Icon(Icons.remove, color: Colors.black54),
            ),
            Text(
              '$quantity',
              style: const TextStyle(fontSize: 18),
            ),
            IconButton(
              onPressed: () {
                ref.read(quantityProvider.notifier).state++;
              },
              icon: const Icon(Icons.add, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

InputDecoration inputDecoration({required String label}) {
  return InputDecoration(
    fillColor: const Color(0XFFfafafa),
    contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    errorStyle: const TextStyle(color: Colors.red),
    labelStyle: const TextStyle(
      fontSize: 15.0,
      color: Colors.black54,
      fontWeight: FontWeight.w500,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Colors.black12,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xff1F0A68), width: 1),
    ),
    labelText: label, // Use the required label parameter here
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.amber, width: 0.5),
    ),
  );
}















// class ModelDropDawn extends ConsumerWidget {
//   const ModelDropDawn({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedBrand = ref.watch(selectedBrandProvider);
//     final selectedModel = ref.watch(selectedModelProvider);
//     final getModels = ref.watch(getModelsProvider(selectedBrand));

//     return getModels.when(
//       data: (data) {
//         // Extract model names from the products list
//         final List<String> modelNames = (data['products'] as List)
//             .map((product) => product['Model'] as String)
//             .toList();

//         return DropdownButtonFormField<String>(
//           value: selectedModel,
//           style: const TextStyle(
//             fontSize: 16.0,
//             height: 1.5,
//             color: Colors.black87,
//           ),
//           decoration: inputDecoration(label: "Select Model"),
//           onChanged: (newValue) {
//             ref.read(selectedModelProvider.notifier).state = newValue;
//           },
//           hint: const Text("Select Model"),
//           items: modelNames.map<DropdownMenuItem<String>>((model) {
//             return DropdownMenuItem<String>(
//               value: model,
//               child: Text(model),
//             );
//           }).toList(),
//           menuMaxHeight: MediaQuery.of(context).size.height / 2,
//         );
//       },
//       error: (error, stackTrace) => Text("Error loading data"),
//       loading: () => const Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }

// class PriceDropDawn extends ConsumerWidget {
//   final List<String> items;

//   const PriceDropDawn({super.key, required this.items});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedPrice = ref.watch(selectedPriceProvider);
//     return DropdownButtonFormField<String>(
//       value: selectedPrice,
//       style: const TextStyle(
//         fontSize: 16.0,
//         height: 1.5,
//         color: Colors.black87,
//       ),
//       decoration: inputDecoration(label: "Select Price"),
//       onChanged: (newValue) {
//         ref.read(selectedPriceProvider.notifier).state = newValue;
//       },
//       hint: const Text("Select Price"),
//       items: items.map<DropdownMenuItem<String>>((value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }