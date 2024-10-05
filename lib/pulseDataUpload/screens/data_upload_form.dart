import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/pulseDataUpload/components/table.dart';
import 'package:siddha_connect/pulseDataUpload/repo/product_repo.dart';
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
          child: CircularProgressIndicator(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                ref.refresh(getExtractionRecordProvider);
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

final selectedDealerProvider =
    StateProvider<Map<String, String>?>((ref) => null);

// class DealerDropDown extends ConsumerWidget {
//   final dynamic data;
//   const DealerDropDown({
//     super.key,
//     required this.data,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedDealer = ref.watch(selectedDealerProvider);

//     final List<Map<String, dynamic>> products =
//         List<Map<String, dynamic>>.from(data is List ? data : []);

//     final List<String> modelNames = products
//         .where((product) => product['BUYER'] != null)
//         .map((product) => product['BUYER'] as String)
//         .toList();

//     if (modelNames.isEmpty) {
//       return const Center(child: Text("No dealers available"));
//     }

//     return SizedBox(
//       width: double.infinity,
//       child: TextFormField(
//         readOnly: true,
//         decoration: inputDecoration(label: "Select Dealer"),
//         onTap: () async {
//           final String? selectedDealer = await showModalBottomSheet<String>(
//             backgroundColor: Colors.white,
//             context: context,
//             isScrollControlled: true,
//             builder: (context) {
//               String searchText = ''; // Initialize search text
//               return StatefulBuilder(
//                 builder: (context, setState) {
//                   final filteredDealers = modelNames.where((dealerName) {
//                     return dealerName.toLowerCase().contains(searchText.toLowerCase());
//                   }).toList();

//                   return Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 20.0),
//                         Text(
//                           "Select Dealer",
//                           style: TextStyle(
//                             fontSize: 16.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 10.0),

//                         // Add Cupertino search bar
//                         CupertinoSearchTextField(
//                           placeholder: 'Search Dealer',
//                           onChanged: (value) {
//                             setState(() {
//                               searchText = value; // Update search text
//                             });
//                           },
//                         ),
//                         SizedBox(height: 20.0),

//                         // Display filtered dealers in ListView
//                         Expanded(
//                           child: ListView.builder(
//                             itemCount: filteredDealers.length,
//                             itemBuilder: (context, index) {
//                               final dealerName = filteredDealers[index];
//                               final selectedProduct = products.firstWhere(
//                                   (product) => product['BUYER'] == dealerName);
//                               final buyerCode = selectedProduct['BUYER CODE'];

//                               return ListTile(
//                                 title: Text(dealerName),
//                                 subtitle: Text(buyerCode),
//                                 onTap: () {
//                                   Navigator.pop(context, dealerName);
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             },
//           );

//           if (selectedDealer != null) {
//             final selectedProduct =
//                 products.firstWhere((product) => product['BUYER'] == selectedDealer);
//             ref.read(selectedDealerProvider.notifier).state = {
//               'BUYER': selectedDealer,
//               'BUYER CODE': selectedProduct['BUYER CODE']
//             };
//           }
//         },
//       ),
//     );
//   }
// }

class DealerDropDown extends ConsumerWidget {
  final dynamic data;
  const DealerDropDown({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDealer = ref.watch(selectedDealerProvider);

    final List<Map<String, dynamic>> products =
        List<Map<String, dynamic>>.from(data is List ? data : []);

    final List<Map<String, String>> dealerList = products
        .where((product) =>
            product['BUYER'] != null && product['BUYER CODE'] != null)
        .map((product) => {
              'BUYER': product['BUYER'] as String,
              'BUYER CODE': product['BUYER CODE'] as String,
            })
        .toList();

    if (dealerList.isEmpty) {
      return const Center(child: Text("No dealers available"));
    }

    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        readOnly: true,
        decoration: inputDecoration(label: "Select Dealer"),
        controller: TextEditingController(
          text: selectedDealer?['BUYER'] ?? '',
        ),
        onTap: () async {
          final Map<String, String>? selectedDealer =
              await showModalBottomSheet<Map<String, String>>(
            backgroundColor: Colors.white,
            context: context,
            isScrollControlled: true,
            builder: (context) {
              String searchText = ''; // Initialize search text
              return StatefulBuilder(
                builder: (context, setState) {
                  // Filter dealers based on both BUYER and BUYER CODE
                  final filteredDealers = dealerList.where((dealer) {
                    return dealer['BUYER']!
                            .toLowerCase()
                            .contains(searchText.toLowerCase()) ||
                        dealer['BUYER CODE']!
                            .toLowerCase()
                            .contains(searchText.toLowerCase());
                  }).toList();

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.0),
                        Text(
                          "Select Dealer",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),

                        // Cupertino search bar to search by both dealer name and code
                        CupertinoSearchTextField(
                          placeholder: 'Search Dealer or Code',
                          onChanged: (value) {
                            setState(() {
                              searchText = value; // Update search text
                            });
                          },
                        ),
                        SizedBox(height: 20.0),

                        // Display filtered dealers in ListView
                        Expanded(
                          child: ListView.builder(
                            itemCount: filteredDealers.length,
                            itemBuilder: (context, index) {
                              final dealerName =
                                  filteredDealers[index]['BUYER']!;
                              final dealerCode =
                                  filteredDealers[index]['BUYER CODE']!;

                              return ListTile(
                                title: Text(dealerName),
                                subtitle: Text(dealerCode),
                                onTap: () {
                                  Navigator.pop(context, {
                                    'BUYER': dealerName,
                                    'BUYER CODE': dealerCode,
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );

          // After dealer is selected, update the state and text field
          if (selectedDealer != null) {
            ref.read(selectedDealerProvider.notifier).state = {
              'BUYER': selectedDealer['BUYER']!,
              'BUYER CODE': selectedDealer['BUYER CODE']!,
            };
          }
        },
      ),
    );
  }
}

// class DealerDropDown extends ConsumerWidget {
//   final dynamic data;
//   const DealerDropDown({
//     super.key,
//     required this.data,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedDealer = ref.watch(selectedDealerProvider);

//     final List<Map<String, dynamic>> products =
//         List<Map<String, dynamic>>.from(data is List ? data : []);

//     final List<String> modelNames = products
//         .where((product) => product['BUYER'] != null)
//         .map((product) => product['BUYER'] as String)
//         .toList();

//     if (modelNames.isEmpty) {
//       return const Center(child: Text("No dealers available"));
//     }

//     return SizedBox(
//       width: double.infinity,
//       child: DropdownButtonFormField<String>(
//         value: selectedDealer?['BUYER'],
//         style: const TextStyle(
//           fontSize: 16.0,
//           height: 1.5,
//           color: Colors.black87,
//         ),
//         dropdownColor: Colors.white,
//         decoration: inputDecoration(label: "Select Dealer"),
//         onChanged: (newValue) {
//           final selectedProduct =
//               products.firstWhere((product) => product['BUYER'] == newValue);
//           ref.read(selectedDealerProvider.notifier).state = {
//             'BUYER': newValue!,
//             'BUYER CODE': selectedProduct['BUYER CODE']
//           };
//         },
//         hint: const Text("Select Dealer"),
//         items: modelNames.map<DropdownMenuItem<String>>((model) {
//           final buyerCode = products
//               .firstWhere((product) => product['BUYER'] == model)['BUYER CODE'];
//           return DropdownMenuItem<String>(
//             value: model,
//             child: ListTile(
//               title: Text(model),
//               subtitle: Text(buyerCode),
//             ),
//           );
//         }).toList(),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please select a dealer';
//           }
//           return null;
//         },
//         menuMaxHeight: MediaQuery.of(context).size.height / 2,
//         icon: const Icon(Icons.arrow_drop_down),
//         isExpanded: true,
//         selectedItemBuilder: (BuildContext context) {
//           return modelNames.map((model) {
//             return Text(
//               model,
//               style: const TextStyle(
//                 fontSize: 16.0,
//                 color: Colors.black87,
//               ),
//             );
//           }).toList();
//         },
//       ),
//     );
//   }
// }

final selectedModelProvider = StateProvider<List<String>>((ref) => []);
final selectModelIDProvider1 = StateProvider<List<String>>((ref) => []);
final modelQuantityProvider =
    StateProvider<Map<String, Map<String, dynamic>>>((ref) => {});

// class ModelDropDawnTest extends ConsumerWidget {
//   const ModelDropDawnTest({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedBrand = ref.watch(selectedBrandProvider);
//     ref.listen(selectedBrandProvider, (previous, next) {
//       if (previous != next) {}
//     });

//     final selectedModelIDs = ref.watch(selectModelIDProvider1);
//     final modelQuantities = ref.watch(modelQuantityProvider);
//     final getModels = ref.watch(getModelsProvider(selectedBrand));

//     return getModels.when(
//       data: (data) {
//         if (data == null || data['products'] == null) {
//           return const Text("No models available");
//         }

//         final List<Map<String, dynamic>> products =
//             List<Map<String, dynamic>>.from(data['products']);

//         if (products.isEmpty) {
//           return const Text("No models available");
//         }

//         return SizedBox(
//           width: double.infinity,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 readOnly: true,
//                 decoration: inputDecoration(
//                     label: "Select Models", hintText: "Select Models"),
//                 onTap: () async {
//                   final Map<String, Map<String, dynamic>>?
//                       selectedModelsWithQuantities = await showModalBottomSheet<
//                           Map<String, Map<String, dynamic>>>(
//                     backgroundColor: Colors.white,
//                     context: context,
//                     isScrollControlled: true,
//                     builder: (context) {
//                       final tempSelectedModels =
//                           Map<String, Map<String, dynamic>>.from(
//                               modelQuantities);
//                       String searchText = ''; // Initialize search text

//                       return StatefulBuilder(
//                         builder: (context, setState) {
//                           int totalQuantity = tempSelectedModels.values.fold(
//                               0,
//                               (sum, modelData) =>
//                                   sum + modelData['quantity'] as int);

//                           // Filter products based on search text
//                           final filteredProducts = products.where((product) {
//                             final modelName = product['Model']?.toLowerCase() ?? '';
//                             return modelName.contains(searchText.toLowerCase());
//                           }).toList();

//                           return Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 heightSizedBox(50.0),
//                                 Text(
//                                   "Select Models and Quantities",
//                                   style: GoogleFonts.lato(
//                                       fontSize: 16.sp,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                                 heightSizedBox(5.0),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 4),
//                                       decoration: BoxDecoration(
//                                           border: Border.all(width: 0.1),
//                                           borderRadius:
//                                               BorderRadius.circular(2)),
//                                       child: Center(
//                                         child: Text(
//                                           "Total: $totalQuantity",
//                                           style: GoogleFonts.lato(
//                                               fontSize: 14.sp,
//                                               fontWeight: FontWeight.w500),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 heightSizedBox(5.0),

//                                 // Add Cupertino search bar
//                                 CupertinoSearchTextField(
//                                   placeholder: 'Search Models',
//                                   onChanged: (value) {
//                                     setState(() {
//                                       searchText = value; // Update search text
//                                     });
//                                   },
//                                 ),
//                                 heightSizedBox(10.0),

//                                 Expanded(
//                                   child: SingleChildScrollView(
//                                     child: ListBody(
//                                       children: filteredProducts.map((product) {
//                                         final modelName = product['Model'];
//                                         final modelId = product['_id'];
//                                         final quantity =
//                                             tempSelectedModels[modelId]
//                                                     ?['quantity'] ?? 0;
//                                         final isSelected = quantity > 0;

//                                         return Container(
//                                           decoration: BoxDecoration(
//                                             color: isSelected
//                                                 ? Colors.green
//                                                 : Colors.transparent,
//                                             border: Border.all(
//                                               color: isSelected
//                                                   ? Colors.white
//                                                   : Colors.black,
//                                               width: 0.1,
//                                             ),
//                                             borderRadius:
//                                                 BorderRadius.circular(8.0),
//                                           ),
//                                           margin: const EdgeInsets.symmetric(
//                                               vertical: 8.0),
//                                           padding: const EdgeInsets.all(12.0),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Expanded(
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       modelName,
//                                                       maxLines: 2,
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       style: TextStyle(
//                                                         color: isSelected
//                                                             ? Colors.white
//                                                             : Colors.black,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   IconButton(
//                                                     icon: Icon(
//                                                       Icons.remove,
//                                                       color: isSelected
//                                                           ? Colors.white
//                                                           : Colors.black,
//                                                     ),
//                                                     onPressed: () {
//                                                       if (quantity > 0) {
//                                                         setState(() {
//                                                           tempSelectedModels[
//                                                               modelId] = {
//                                                             'name': modelName,
//                                                             'quantity':
//                                                                 quantity - 1,
//                                                           };
//                                                           if (tempSelectedModels[
//                                                                       modelId]![
//                                                                   'quantity'] == 0) {
//                                                             tempSelectedModels
//                                                                 .remove(
//                                                                     modelId);
//                                                           }
//                                                           totalQuantity = tempSelectedModels
//                                                               .values
//                                                               .fold(
//                                                                   0,
//                                                                   (sum, modelData) =>
//                                                                       sum + modelData['quantity'] as int);
//                                                         });
//                                                       }
//                                                     },
//                                                   ),
//                                                   Text(
//                                                     quantity.toString(),
//                                                     style: TextStyle(
//                                                       color: isSelected
//                                                           ? Colors.white
//                                                           : Colors.black,
//                                                     ),
//                                                   ),
//                                                   IconButton(
//                                                     icon: Icon(
//                                                       Icons.add,
//                                                       color: isSelected
//                                                           ? Colors.white
//                                                           : Colors.black,
//                                                     ),
//                                                     onPressed: () {
//                                                       setState(() {
//                                                         tempSelectedModels[
//                                                             modelId] = {
//                                                           'name': modelName,
//                                                           'quantity':
//                                                               quantity + 1,
//                                                         };
//                                                         totalQuantity = tempSelectedModels
//                                                             .values
//                                                             .fold(
//                                                                 0,
//                                                                 (sum, modelData) =>
//                                                                     sum + modelData['quantity']
//                                                                         as int);
//                                                       });
//                                                     },
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       }).toList(),
//                                     ),
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     TextButton(
//                                       child: const Text(
//                                         'Cancel',
//                                         style: TextStyle(color: Colors.black),
//                                       ),
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                     ),
//                                     TextButton(
//                                       child: const Text(
//                                         'OK',
//                                         style: TextStyle(color: Colors.black),
//                                       ),
//                                       onPressed: () {
//                                         Navigator.of(context)
//                                             .pop(tempSelectedModels);
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   );

//                   if (selectedModelsWithQuantities != null) {
//                     ref.read(modelQuantityProvider.notifier).state =
//                         selectedModelsWithQuantities;

//                     final selectedProductIds =
//                         selectedModelsWithQuantities.keys.toList();
//                     ref.read(selectModelIDProvider1.notifier).state =
//                         selectedProductIds;

//                     final selectedModelNames = selectedModelsWithQuantities
//                         .values
//                         .map((modelData) => modelData['name'] as String)
//                         .toList();
//                     ref.read(selectedModelProvider.notifier).state =
//                         selectedModelNames;
//                   }
//                 },
//               ),
//               const SizedBox(height: 10),
//               const Text("Selected Models:"),
//               ...modelQuantities.entries.map((entry) {
//                 final modelId = entry.key;
//                 final modelData = entry.value;
//                 final modelName = modelData['name'];
//                 final quantity = modelData['quantity'] ?? 1;

//                 return Column(
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(child: Text(modelName)), // Model name
//                         IconButton(
//                           icon: const Icon(Icons.remove),
//                           onPressed: () {
//                             if (quantity > 1) {
//                               final newQuantities =
//                                   Map<String, Map<String, dynamic>>.from(
//                                       modelQuantities);
//                               newQuantities[modelId]!['quantity'] =
//                                   quantity - 1;
//                               ref.read(modelQuantityProvider.notifier).state =
//                                   newQuantities;
//                             }
//                           },
//                         ),
//                         Text(quantity.toString()),
//                         IconButton(
//                           icon: const Icon(Icons.add),
//                           onPressed: () {
//                             final newQuantities =
//                                 Map<String, Map<String, dynamic>>.from(
//                                     modelQuantities);
//                             newQuantities[modelId]!['quantity'] = quantity + 1;
//                             ref.read(modelQuantityProvider.notifier).state =
//                                 newQuantities;
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 );
//               }).toList(),
//             ],
//           ),
//         );
//       },
//       error: (error, stackTrace) => Text("Error loading data: $error"),
//       loading: () => const SizedBox(),
//     );
//   }
// }

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

    // Calculate the total quantity
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
                      final tempSelectedModels =
                          Map<String, Map<String, dynamic>>.from(
                              modelQuantities);
                      String searchText = ''; // Initialize search text

                      return StatefulBuilder(
                        builder: (context, setState) {
                          int totalQuantity = tempSelectedModels.values.fold(
                              0,
                              (sum, modelData) =>
                                  sum + modelData['quantity'] as int);

                          // Filter products based on search text
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

                                // Add Cupertino search bar
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          // border: Border.all(width: 0.5),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            modelName,
                            style: const TextStyle(color: Colors.white),
                          )), // Model name
                          // IconButton(
                          //   icon: const Icon(
                          //     Icons.remove,
                          //     color: Colors.white,
                          //   ),
                          //   onPressed: () {
                          //     if (quantity > 1) {
                          //       final newQuantities =
                          //           Map<String, Map<String, dynamic>>.from(
                          //               modelQuantities);
                          //       newQuantities[modelId]!['quantity'] =
                          //           quantity - 1;
                          //       ref.read(modelQuantityProvider.notifier).state =
                          //           newQuantities;
                          //     }
                          //   },
                          // ),
                          IconButton(
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              if (quantity > 1) {
                                final newQuantities =
                                    Map<String, Map<String, dynamic>>.from(
                                        modelQuantities);
                                newQuantities[modelId]!['quantity'] =
                                    quantity - 1;
                                ref.read(modelQuantityProvider.notifier).state =
                                    newQuantities;
                              } else if (quantity == 1) {
                                // Remove the model if quantity is 1 and user tries to decrease it further
                                final newQuantities =
                                    Map<String, Map<String, dynamic>>.from(
                                        modelQuantities);
                                newQuantities.remove(modelId);
                                ref.read(modelQuantityProvider.notifier).state =
                                    newQuantities;

                                // Update selected model IDs as well
                                final newSelectedModelIds = ref
                                    .read(selectModelIDProvider1)
                                    .where((id) => id != modelId)
                                    .toList();
                                ref
                                    .read(selectModelIDProvider1.notifier)
                                    .state = newSelectedModelIds;

                                // Optionally update the selectedModelProvider too
                                final newSelectedModelNames = ref
                                    .read(selectedModelProvider)
                                    .where((name) => name != modelData['name'])
                                    .toList();
                                ref.read(selectedModelProvider.notifier).state =
                                    newSelectedModelNames;
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
