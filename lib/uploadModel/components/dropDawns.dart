import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedBrandProvider = StateProvider<String?>((ref) => null);
final selectedModelProvider = StateProvider<String?>((ref) => null);
final selectedPriceProvider = StateProvider<String?>((ref) => null);
final paymentModeProvider = StateProvider<String?>((ref) => null);
final quantityProvider = StateProvider<int>((ref) => 1);

class BrandDropDawn extends ConsumerWidget {
  final List<String> items;
  const BrandDropDawn({
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
    );
  }
}

class ModelDropDawn extends ConsumerWidget {
  final List<String> items;

  const ModelDropDawn({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBrand = ref.watch(selectedBrandProvider);
    final selectedModel = ref.watch(selectedModelProvider);

    return DropdownButtonFormField<String>(
      value: selectedModel,
      style: const TextStyle(
        fontSize: 16.0,
        height: 1.5,
        color: Colors.black87,
      ),
      decoration: inputDecoration(label: "Select Model"),
      onChanged: (newValue) {
        ref.read(selectedModelProvider.notifier).state = newValue;
      },
      hint: const Text("Select Model"),
      items: items.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class PriceDropDawn extends ConsumerWidget {
  final List<String> items;

  const PriceDropDawn({super.key, required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPrice = ref.watch(selectedPriceProvider);
    return DropdownButtonFormField<String>(
      value: selectedPrice,
      style: const TextStyle(
        fontSize: 16.0,
        height: 1.5,
        color: Colors.black87,
      ),
      decoration: inputDecoration(label: "Select Price"),
      onChanged: (newValue) {
        ref.read(selectedPriceProvider.notifier).state = newValue;
      },
      hint: const Text("Select Price"),
      items: items.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
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
