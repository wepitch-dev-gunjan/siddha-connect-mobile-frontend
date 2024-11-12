import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repo/product_repo.dart';

final selectedModelProvider = StateProvider<String?>((ref) => null);
final selectedCategoryProvider = StateProvider<String?>((ref) => null);
final selectedPriceProvider = StateProvider<String?>((ref) => null);
final paymentModeProvider = StateProvider<String?>((ref) => null);
final quantityProvider = StateProvider<int>((ref) => 1);
final selectedBrandProvider = StateProvider<String?>((ref) => null);

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
        ref.read(selectedBrandProvider.notifier).state = newValue;
      },
      hint: const Text("Select Brand"),
      items: items.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      menuMaxHeight: MediaQuery.of(context).size.height / 2,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a brand';
        }
        return null;
      },
    );
  }
}

// ==============================! Model DropDown !=====================
final selectedModelIdProvider = StateProvider<String?>((ref) => null);
final getModelsProvider =
    FutureProvider.autoDispose.family((ref, String? brand) async {
  final productRepo = ref.watch(productRepoProvider);
  final data = await productRepo.getAllProducts(brand: brand);
  return data;
});

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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a model';
              }
              return null; // No error
            },
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

class CategoryDropDown extends ConsumerWidget {
  final List<String> items;
  const CategoryDropDown({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      style: const TextStyle(
        fontSize: 16.0,
        height: 1.5,
        color: Colors.black87,
      ),
      dropdownColor: Colors.white,
      decoration: inputDecoration(label: "Select Category"),
      onChanged: (newValue) {
        ref.read(selectedCategoryProvider.notifier).state = newValue;
      },
      hint: const Text("Select Category"),
      items: items.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      menuMaxHeight: MediaQuery.of(context).size.height / 2,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a brand';
        }
        return null;
      },
    );
  }
}

InputDecoration inputDecoration({required String label, String? hintText}) {
  return InputDecoration(
    fillColor: const Color(0XFFfafafa),
    contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    errorStyle: const TextStyle(color: Colors.red),
    hintText: hintText ?? "",
    hintStyle: const TextStyle(
      fontSize: 15.0,
      color: Colors.black54,
      fontWeight: FontWeight.w500,
    ),
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