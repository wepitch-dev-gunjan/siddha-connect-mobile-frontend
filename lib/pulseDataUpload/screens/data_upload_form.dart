// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:siddha_connect/utils/sizes.dart';

// import '../components/dropDawns.dart';

// class UploadForm extends ConsumerWidget {
//   const UploadForm({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           heightSizedBox(10.0),
//           BrandDropDown1(
//             items: [
//               "Samsung",
//               "Apple",
//               "Oppo",
//               "Vivo",
//               "OnePlus",
//               "Realme",
//               "Xiaomi",
//               "Motorola",
//               "Others (>100K)",
//               "Others (70-100K)",
//               "Others (40-70K)",
//               "Others (30-40K)",
//               "Others (20-30K)",
//               "Others (15-20K)",
//               "Others (10-15K)",
//               "Others (6-10K)"
//             ],
//           ),
//           Expanded(child: ModelDropDown())
//         ],
//       ),
//     );
//   }
// }

// class BrandDropDown1 extends ConsumerWidget {
//   final List<String> items;
//   const BrandDropDown1({
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
//       hint: Text("Select Brand"),
//       items: items.map<DropdownMenuItem<String>>((value) {
//         return Column(
//           children: [
//             DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             ),
//           ],
//         );
//       }).toList(),
//       menuMaxHeight: MediaQuery.of(context).size.height / 2,
//       // Add validation
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please select a brand';
//         }
//         return null; // No error
//       },
//     );
//   }
// }

// class ModelDropDown extends ConsumerStatefulWidget {
//   const ModelDropDown({super.key});

//   @override
//   _ModelDropDownState createState() => _ModelDropDownState();
// }

// class _ModelDropDownState extends ConsumerState<ModelDropDown> {
//   TextEditingController searchController = TextEditingController();
//   List<String> filteredModelNames = [];

//   @override
//   Widget build(BuildContext context) {
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

//         // Initialize the filtered model list if it's empty
//         if (filteredModelNames.isEmpty) {
//           filteredModelNames = modelNames;
//         }

//         return Column(
//           children: [
//             // Search bar
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: TextField(
//                 controller: searchController,
//                 decoration: InputDecoration(
//                   labelText: 'Search Models',
//                   prefixIcon: const Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     filteredModelNames = modelNames
//                         .where((model) =>
//                             model.toLowerCase().contains(value.toLowerCase()))
//                         .toList();
//                   });
//                 },
//               ),
//             ),
//             // List of models with checkboxes
//             Expanded(
//               child: ListView.builder(
//                 itemCount: filteredModelNames.length,
//                 itemBuilder: (context, index) {
//                   final modelName = filteredModelNames[index];
//                   final isSelected = selectedModel == modelName;

//                   return CheckboxListTile(
//                     title: Text(modelName),
//                     value: isSelected,
//                     onChanged: (bool? checked) {
//                       if (checked == true) {
//                         ref.read(selectedModelProvider.notifier).state =
//                             modelName;

//                         final selectedProduct = products.firstWhere(
//                             (product) => product['Model'] == modelName);
//                         ref.read(selectedModelIdProvider.notifier).state =
//                             selectedProduct['_id'];
//                       } else {
//                         ref.read(selectedModelProvider.notifier).state = null;
//                         ref.read(selectedModelIdProvider.notifier).state = null;
//                       }
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         );
//       },
//       error: (error, stackTrace) => Text("Error loading data: $error"),
//       loading: () => const CircularProgressIndicator(),
//     );
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }
// }
