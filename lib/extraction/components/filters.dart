import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/extraction/repo/product_repo.dart';
import '../../utils/common_style.dart';
import '../../utils/sizes.dart';

// final newSelectedIndexProvider = StateProvider<int>((ref) => 0);
// final newSelectedPositionProvider = StateProvider<String>((ref) => 'All');
// final newSelectedItemProvider = StateProvider<String?>((ref) => null);

// class Filters extends ConsumerWidget {
//   const Filters({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedIndex = ref.watch(newSelectedIndexProvider);
//     final selectedPosition = ref.watch(newSelectedPositionProvider);

//     // Define the customLabels list with only keys
//     final List<String> customLabels = [
//       'SEGMENT',
//       'OUTLATE TYPE',
//       'AREA',
//       'ZSM',
//       'ABM',
//       'RSO',
//       'ASE',
//       'ASM',
//       'TSE',
//       'OUTLATE CODE'
//       ////////////============= ISKO OUTLATE CODE  CODE KRNA HAI

//       ///////=================== ISKO OUTLATE TYPE KRNA HAI
//     ];

//     return Padding(
//       padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   ref.read(newSelectedIndexProvider.notifier).state = 0;
//                   ref.read(newSelectedPositionProvider.notifier).state = 'All';
//                   ref.read(newSelectedItemProvider.notifier).state =
//                       null; // Reset selected item
//                 },
//                 child: Container(
//                   width: 70,
//                   height: 30,
//                   margin: const EdgeInsets.only(right: 15.0),
//                   decoration: BoxDecoration(
//                     color: selectedIndex == 0
//                         ? AppColor.primaryColor
//                         : Colors.transparent,
//                     borderRadius: BorderRadius.circular(5.0),
//                     border:
//                         Border.all(color: AppColor.primaryColor, width: 1.0),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'All',
//                       style: GoogleFonts.lato(
//                         color: selectedIndex == 0 ? Colors.white : Colors.black,
//                         textStyle: const TextStyle(
//                             fontWeight: FontWeight.w600, fontSize: 12),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: List.generate(customLabels.length, (index) {
//                       return GestureDetector(
//                         onTap: () {
//                           ref.read(newSelectedIndexProvider.notifier).state =
//                               index + 1;
//                           ref.read(newSelectedPositionProvider.notifier).state =
//                               customLabels[index];
//                           ref.read(newSelectedItemProvider.notifier).state =
//                               null; // Reset selected item
//                         },
//                         child: Container(
//                           width: 70,
//                           height: 30,
//                           margin: const EdgeInsets.symmetric(horizontal: 8.0),
//                           decoration: BoxDecoration(
//                             color: selectedIndex == index + 1
//                                 ? AppColor.primaryColor
//                                 : Colors.transparent,
//                             borderRadius: BorderRadius.circular(5.0),
//                             border: Border.all(
//                                 color: AppColor.primaryColor, width: 1.0),
//                           ),
//                           child: Center(
//                             child: Text(
//                               customLabels[index],
//                               style: GoogleFonts.lato(
//                                 color: selectedIndex == index + 1
//                                     ? Colors.white
//                                     : const Color(0xff999292),
//                                 textStyle: const TextStyle(
//                                     fontWeight: FontWeight.w600, fontSize: 12),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           heightSizedBox(15.0),
//           if (selectedIndex != 0)
//             FiltersDropdown(selectedPosition: selectedPosition),
//         ],
//       ),
//     );
//   }
// }

// final filtersColumnProvider =
//     FutureProvider.family.autoDispose((ref, String type) async {
//   final getFilters = await ref.watch(productRepoProvider).getFilters(type);
//   return getFilters;
// });

// class FiltersDropdown extends ConsumerWidget {
//   final String selectedPosition;

//   const FiltersDropdown({super.key, required this.selectedPosition});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedItem = ref.watch(newSelectedItemProvider);
//     final filters = ref.watch(filtersColumnProvider(selectedPosition));

//     return filters.when(
//       data: (data) {
//         final subordinates = data['uniqueValues'] ?? [];

//         // Automatically set the first item as the selected item if none is selected
//         if (selectedItem == null && subordinates.isNotEmpty) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             ref.read(newSelectedItemProvider.notifier).state = subordinates[0];
//           });
//         }

//         return DropdownButtonFormField(
//           dropdownColor: Colors.white,
//           value: selectedItem,
//           style: const TextStyle(
//               fontSize: 16.0, height: 1.5, color: Colors.black87),
//           decoration: InputDecoration(
//             fillColor: const Color(0XFFfafafa),
//             contentPadding:
//                 const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//             errorStyle: const TextStyle(color: Colors.red),
//             labelStyle: const TextStyle(
//                 fontSize: 15.0,
//                 color: Colors.black54,
//                 fontWeight: FontWeight.w500),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.black12),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(
//                 color: Colors.red, // Error border color
//                 width: 1,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: const BorderSide(
//                   color: Color(0xff1F0A68),
//                   width: 1,
//                 )),
//             labelText: selectedPosition,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: const BorderSide(
//                 color: Colors.amber,
//                 width: 0.5,
//               ),
//             ),
//           ),
//           onChanged: (newValue) {
//             ref.read(newSelectedItemProvider.notifier).state = newValue!;
//           },
//           items: subordinates.map<DropdownMenuItem<String>>((value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//         );
//       },
//       error: (error, stackTrace) => const Text("Something went wrong"),
//       loading: () => const Center(
//         child: SizedBox(
//           height: 10,
//           child: SpinKitThreeInOut(
//             color: AppColor.primaryColor,
//           ),
//         ),
//       ),
//     );
//   }
// }

final newSelectedIndexProvider = StateProvider<int>((ref) => 0);
final newSelectedPositionProvider = StateProvider<String>((ref) => 'All');

// Updated provider to hold selected items as a map
final newSelectedItemsProvider =
    StateProvider<Map<String, List<String>>>((ref) => {});

final filtersColumnProvider =
    FutureProvider.family.autoDispose((ref, String type) async {
  final getFilters = await ref.watch(productRepoProvider).getFilters(type);
  return getFilters;
});

class Filters extends ConsumerWidget {
  const Filters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(newSelectedIndexProvider);
    final selectedPosition = ref.watch(newSelectedPositionProvider);

    final List<String> customLabels = [
      'SEGMENT',
      'OUTLATE TYPE',
      'AREA',
      'ZSM',
      'ABM',
      'RSO',
      'ASE',
      'ASM',
      'TSE',
      'OUTLATE CODE',
      "STATE",
      "DISTRICT",
      "TOWN"
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  ref.read(newSelectedIndexProvider.notifier).state = 0;
                  ref.read(newSelectedPositionProvider.notifier).state = 'All';
                  ref.read(newSelectedItemsProvider.notifier).state = {};
                },
                child: Container(
                  width: 70,
                  height: 30,
                  margin: const EdgeInsets.only(right: 15.0),
                  decoration: BoxDecoration(
                    color: selectedIndex == 0
                        ? AppColor.primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5.0),
                    border:
                        Border.all(color: AppColor.primaryColor, width: 1.0),
                  ),
                  child: Center(
                    child: Text(
                      'All',
                      style: GoogleFonts.lato(
                        color: selectedIndex == 0 ? Colors.white : Colors.black,
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(customLabels.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          ref.read(newSelectedIndexProvider.notifier).state =
                              index + 1;
                          ref.read(newSelectedPositionProvider.notifier).state =
                              customLabels[index];
                        },
                        child: Container(
                          width: 70,
                          height: 30,
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: selectedIndex == index + 1
                                ? AppColor.primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                                color: AppColor.primaryColor, width: 1.0),
                          ),
                          child: Center(
                            child: Text(
                              customLabels[index],
                              style: GoogleFonts.lato(
                                color: selectedIndex == index + 1
                                    ? Colors.white
                                    : const Color(0xff999292),
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          if (selectedIndex != 0)
            FiltersDropdown(selectedPosition: selectedPosition),
        ],
      ),
    );
  }
}

class FiltersDropdown extends ConsumerWidget {
  final String selectedPosition;

  const FiltersDropdown({super.key, required this.selectedPosition});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItems =
        ref.watch(newSelectedItemsProvider)[selectedPosition] ?? [];
    final filters = ref.watch(filtersColumnProvider(selectedPosition));

    return filters.when(
      data: (data) {
        final subordinates = data['uniqueValues'] ?? [];

        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) {
                return MultiSelectItems(
                  selectedItems: selectedItems,
                  subordinates: subordinates,
                  selectedPosition: selectedPosition,
                );
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(8),
              color: const Color(0XFFfafafa),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    selectedItems.isNotEmpty
                        ? selectedItems.join(", ")
                        : "Select $selectedPosition",
                    style: const TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.black54),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) => const Text("Something went wrong"),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class MultiSelectItems extends ConsumerStatefulWidget {
  final List selectedItems;
  final List subordinates;
  final String selectedPosition;
  const MultiSelectItems({
    super.key,
    required this.selectedItems,
    required this.subordinates,
    required this.selectedPosition,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MultiSelectItemsState();
}

class _MultiSelectItemsState extends ConsumerState<MultiSelectItems> {
  late List<String> selected;

  @override
  void initState() {
    super.initState();
    selected = List.from(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Select ${widget.selectedPosition}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: widget.subordinates.map((item) {
                final isSelected = selected.contains(item);
                return CheckboxListTile(
                  title: Text(item),
                  value: isSelected,
                  onChanged: (checked) {
                    setState(() {
                      if (checked == true) {
                        selected.add(item);
                      } else {
                        selected.remove(item);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  // Update the provider state directly via ref
                  ref.read(newSelectedItemsProvider.notifier).state = {
                    ...ref.read(newSelectedItemsProvider.notifier).state,
                    widget.selectedPosition: selected,
                  };
                  Navigator.pop(context);
                },
                child: const Text("Apply"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class MultiSelectBottomSheet extends StatefulConsumerWidget {
//   final List<String> selectedItems;
//   final List<String> subordinates;
//   final String selectedPosition;

//   const MultiSelectBottomSheet({
//     super.key,
//     required this.selectedItems,
//     required this.subordinates,
//     required this.selectedPosition,
//   });

//   @override
//   _MultiSelectBottomSheetState createState() => _MultiSelectBottomSheetState();
// }

// class _MultiSelectBottomSheetState
//     extends ConsumerState<MultiSelectBottomSheet> {
//   late List<String> selected;

//   @override
//   void initState() {
//     super.initState();
//     selected = List.from(widget.selectedItems);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             "Select ${widget.selectedPosition}",
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 16),
//           Expanded(
//             child: ListView(
//               children: widget.subordinates.map((item) {
//                 final isSelected = selected.contains(item);
//                 return CheckboxListTile(
//                   title: Text(item),
//                   value: isSelected,
//                   onChanged: (checked) {
//                     setState(() {
//                       if (checked == true) {
//                         selected.add(item);
//                       } else {
//                         selected.remove(item);
//                       }
//                     });
//                   },
//                 );
//               }).toList(),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text("Cancel"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   // Update the provider state directly via ref
//                   ref.read(newSelectedItemsProvider.notifier).state = {
//                     ...ref.read(newSelectedItemsProvider.notifier).state,
//                     widget.selectedPosition: selected,
//                   };
//                   Navigator.pop(context);
//                 },
//                 child: const Text("Apply"),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FiltersDropdown extends ConsumerWidget {
//   final String selectedPosition;

//   const FiltersDropdown({super.key, required this.selectedPosition});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedItems = ref.watch(newSelectedItemsProvider)[selectedPosition] ?? [];
//     final filters = ref.watch(filtersColumnProvider(selectedPosition));

//     return filters.when(
//       data: (data) {
//         final subordinates = data['uniqueValues'] ?? [];

//         return GestureDetector(
//           onTap: () {
//             showModalBottomSheet(
//               context: context,
//               isScrollControlled: true,
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//               ),
//               builder: (context) {
//                 return MultiSelectBottomSheet(
//                   selectedItems: selectedItems,
//                   subordinates: subordinates,
//                   selectedPosition: selectedPosition,
//                 );
//               },
//             );
//           },
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.black12),
//               borderRadius: BorderRadius.circular(8),
//               color: const Color(0XFFfafafa),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     selectedItems.isNotEmpty
//                         ? selectedItems.join(", ")
//                         : "Select $selectedPosition",
//                     style: const TextStyle(color: Colors.black54, fontSize: 14),
//                   ),
//                 ),
//                 const Icon(Icons.arrow_drop_down, color: Colors.black54),
//               ],
//             ),
//           ),
//         );
//       },
//       error: (error, stackTrace) => const Text("Something went wrong"),
//       loading: () => const Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }


// class MultiSelectBottomSheet extends StatefulWidget {
//   final List<String> selectedItems;
//   final List<String> subordinates;
//   final String selectedPosition;

//   const MultiSelectBottomSheet({
//     super.key,
//     required this.selectedItems,
//     required this.subordinates,
//     required this.selectedPosition,
//   });

//   @override
//   _MultiSelectBottomSheetState createState() => _MultiSelectBottomSheetState();
// }

// class _MultiSelectBottomSheetState extends State<MultiSelectBottomSheet> {
//   late List<String> selected;

//   @override
//   void initState() {
//     super.initState();
//     selected = List.from(widget.selectedItems);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             "Select ${widget.selectedPosition}",
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 16),
//           Expanded(
//             child: ListView(
//               children: widget.subordinates.map((item) {
//                 final isSelected = selected.contains(item);
//                 return CheckboxListTile(
//                   title: Text(item),
//                   value: isSelected,
//                   onChanged: (checked) {
//                     setState(() {
//                       if (checked == true) {
//                         selected.add(item);
//                       } else {
//                         selected.remove(item);
//                       }
//                     });
//                   },
//                 );
//               }).toList(),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text("Cancel"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   final ref = ref.read(newSelectedItemsProvider.notifier);
//                   ref.state = {
//                     ...ref.state,
//                     widget.selectedPosition: selected,
//                   };
//                   Navigator.pop(context);
//                 },
//                 child: const Text("Apply"),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
