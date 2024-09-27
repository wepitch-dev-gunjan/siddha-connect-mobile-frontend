
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedBrandProvider = StateProvider<String?>((ref) => null);
final selectedModelProvider = StateProvider<String?>((ref) => null);

class BrandDropDawn extends ConsumerWidget {
  final List<String> items;
  final String field;

  const BrandDropDawn({super.key, required this.items, required this.field});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBrand = ref.watch(selectedBrandProvider);
    final selectedModel = ref.watch(selectedModelProvider);

    return DropdownButtonFormField<String>(
      value: field == "Brand" ? selectedBrand : selectedModel,
      style: const TextStyle(
        fontSize: 16.0,
        height: 1.5,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        fillColor: const Color(0XFFfafafa),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
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
        labelText: field == "Brand" ? selectedBrand : selectedModel,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.amber, width: 0.5),
        ),
      ),
      onChanged: (newValue) {
        if (field == "Brand") {
          ref.read(selectedBrandProvider.notifier).state = newValue;
        } else if (field == "Model") {
          ref.read(selectedModelProvider.notifier).state = newValue;
        }
      },
      hint:const  Text("Select Model"),
      items: items.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
