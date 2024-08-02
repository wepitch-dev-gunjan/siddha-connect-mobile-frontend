import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/salesDashboard/component/tabels.dart';
import '../../utils/common_style.dart';
import '../../utils/providers.dart';
import '../tables/tse_table.dart';

final selectedButtonProvider = StateProvider<bool>((ref) => true);

class FullSizeBtn extends ConsumerWidget {
  const FullSizeBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSegmentSelected = ref.watch(selectedButtonProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    ref.read(selectedButtonProvider.notifier).state = true;
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: isSegmentSelected
                            ? AppColor.primaryColor
                            : AppColor.whiteColor,
                        border: Border.all(width: 0.05)),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Segment\n',
                              style: GoogleFonts.lato(
                                color: isSegmentSelected
                                    ? Colors.white
                                    : Colors.black,
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: '(Price bucket)',
                              style: GoogleFonts.lato(
                                color: isSegmentSelected
                                    ? Colors.white
                                    : Colors.black,
                                textStyle: const TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    ref.read(selectedButtonProvider.notifier).state = false;
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: isSegmentSelected
                            ? AppColor.whiteColor
                            : AppColor.primaryColor,
                        border: Border.all(width: 0.05)),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Channel\n',
                              style: GoogleFonts.lato(
                                color: isSegmentSelected
                                    ? Colors.black
                                    : Colors.white,
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: '(DL.Category)',
                              style: GoogleFonts.lato(
                                color: isSegmentSelected
                                    ? Colors.black
                                    : Colors.white,
                                textStyle: const TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isSegmentSelected) const SegmentTable() else const ChannelTable()
      ],
    );
  }
}

final selectedIndexProvider = StateProvider<int>((ref) => 0);
final selectedPositionProvider = StateProvider<String>((ref) => 'All');
final selectedItemProvider = StateProvider<String?>((ref) => null);

class SmallCusBtn extends ConsumerWidget {
  const SmallCusBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    final selectedPosition = ref.watch(selectedPositionProvider);
    final subOrdinates = ref.watch(subordinateProvider);

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  ref.read(selectedIndexProvider.notifier).state = 0;
                  ref.read(selectedPositionProvider.notifier).state = 'All';
                  ref.read(selectedItemProvider.notifier).state = null;
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
                          color:
                              selectedIndex == 0 ? Colors.white : Colors.black,
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12)),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: subOrdinates.when(
                    data: (data) {
                      final positions = data['positions'];

                      return Row(
                        children: List.generate(positions.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              ref.read(selectedIndexProvider.notifier).state =
                                  index + 1;
                              ref
                                  .read(selectedPositionProvider.notifier)
                                  .state = positions[index];
                              ref.read(selectedItemProvider.notifier).state =
                                  null;
                            },
                            child: Container(
                              width: 70,
                              height: 30,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                                  positions[index],
                                  style: GoogleFonts.lato(
                                      color: selectedIndex == index + 1
                                          ? Colors.white
                                          : const Color(0xff999292),
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12)),
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    },
                    error: (error, stackTrace) =>
                        const Text("Something went wrong"),
                    loading: () => Text("Loading....")),
              )),
            ],
          ),
          const SizedBox(height: 10),
          Text('Selected Button: $selectedPosition',
              style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14))),
          if (selectedIndex != 0)
            CusDropdown(selectedPosition: selectedPosition),
        ],
      ),
    );
  }
}

// class CusDropdown extends ConsumerWidget {
//   final String selectedPosition;

//   const CusDropdown({super.key, required this.selectedPosition});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedItem = ref.watch(selectedItemProvider);
//     final subOrdinates = ref.watch(subordinateProvider);

//     return subOrdinates.when(
//         data: (data) {
//           final subordinates = data[selectedPosition] ?? [];

//           return DropdownButtonFormField<String>(
//             value: selectedItem,
//             style: const TextStyle(
//                 fontSize: 16.0, height: 1.5, color: Colors.black87),
//             decoration: InputDecoration(
//                 fillColor: const Color(0XFFfafafa),
//                 contentPadding:
//                     const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//                 errorStyle: const TextStyle(color: Colors.red),
//                 labelStyle: const TextStyle(
//                     fontSize: 15.0,
//                     color: Colors.black54,
//                     fontWeight: FontWeight.w500),
//                 enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: const BorderSide(
//                       color: Colors.black12,
//                     )),
//                 errorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: const BorderSide(
//                     color: Colors.red, // Error border color
//                     width: 1,
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide:
//                         const BorderSide(color: Color(0xff1F0A68), width: 1)),
//                 labelText: selectedPosition,
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5),
//                     borderSide:
//                         const BorderSide(color: Colors.amber, width: 0.5))),
//             onChanged: (newValue) {
//               ref.read(selectedItemProvider.notifier).state = newValue!;
//             },
//             items: subordinates.map<DropdownMenuItem<String>>((value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//           );
//         },
//         error: (error, stackTrace) => const Text("Something went wrong"),
//         loading: () => const Center(
//               child: CircularProgressIndicator(),
//             ));
//   }
// }


class CusDropdown extends ConsumerWidget {
  final String selectedPosition;

  const CusDropdown({super.key, required this.selectedPosition});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(selectedItemProvider);
    final subOrdinates = ref.watch(subordinateProvider);

    return subOrdinates.when(
      data: (data) {
        final subordinates = data[selectedPosition] ?? [];

        // If there is no selected item and subordinates are not empty, set the first item as selected
        if (selectedItem == null && subordinates.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(selectedItemProvider.notifier).state = subordinates[0];
          });
        }

        return DropdownButtonFormField<String>(
          value: selectedItem,
          style: const TextStyle(
              fontSize: 16.0, height: 1.5, color: Colors.black87),
          decoration: InputDecoration(
              fillColor: const Color(0XFFfafafa),
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: 12.0),
              errorStyle: const TextStyle(color: Colors.red),
              labelStyle: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.black12,
                  )),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.red, // Error border color
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                      color: Color(0xff1F0A68), width: 1)),
              labelText: selectedPosition,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                      color: Colors.amber, width: 0.5))),
          onChanged: (newValue) {
            ref.read(selectedItemProvider.notifier).state = newValue!;
          },
          items: subordinates.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        );
      },
      error: (error, stackTrace) => const Text("Something went wrong"),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// class SmallCusBtn extends ConsumerWidget {
//   const SmallCusBtn({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedIndex = ref.watch(selectedIndexProvider);
//     final selectedPosition = ref.watch(selectedPositionProvider);
//     final subOrdinates = ref.watch(subordinateProvider);

//     return Padding(
//       padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   ref.read(selectedIndexProvider.notifier).state = 0;
//                   ref.read(selectedPositionProvider.notifier).state = 'All';
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
//                           color:
//                               selectedIndex == 0 ? Colors.white : Colors.black,
//                           textStyle: const TextStyle(
//                               fontWeight: FontWeight.w600, fontSize: 12)),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: subOrdinates.when(
//                     data: (data) {
//                       final positions = data['positions'];

//                       return Row(
//                         children: List.generate(positions.length, (index) {
//                           return GestureDetector(
//                             onTap: () {
//                               ref.read(selectedIndexProvider.notifier).state =
//                                   index + 1;
//                               ref
//                                   .read(selectedPositionProvider.notifier)
//                                   .state = positions[index];
//                             },
//                             child: Container(
//                               width: 70,
//                               height: 30,
//                               margin:
//                                   const EdgeInsets.symmetric(horizontal: 8.0),
//                               decoration: BoxDecoration(
//                                 color: selectedIndex == index + 1
//                                     ? AppColor.primaryColor
//                                     : Colors.transparent,
//                                 borderRadius: BorderRadius.circular(5.0),
//                                 border: Border.all(
//                                     color: AppColor.primaryColor, width: 1.0),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   positions[index],
//                                   style: GoogleFonts.lato(
//                                       color: selectedIndex == index + 1
//                                           ? Colors.white
//                                           : const Color(0xff999292),
//                                       textStyle: const TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 12)),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                       );
//                     },
//                     error: (error, stackTrace) =>
//                         const Text("Something went wrong"),
//                     loading: () => const Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Text('Selected Button: $selectedPosition',
//               style: GoogleFonts.lato(
//                   textStyle: const TextStyle(
//                       fontWeight: FontWeight.w600, fontSize: 14))),
//           selectedIndex == 0
//               ? SizedBox()
//               : DropdownButtonFormField<String>(
//                   style: const TextStyle(
//                       fontSize: 16.0, height: 1.5, color: Colors.black87),
//                   decoration: InputDecoration(
//                       fillColor: const Color(0XFFfafafa),
//                       contentPadding: const EdgeInsets.symmetric(
//                           vertical: 8.0, horizontal: 12.0),
//                       errorStyle: const TextStyle(color: Colors.red),
//                       labelStyle: const TextStyle(
//                           fontSize: 15.0,
//                           color: Colors.black54,
//                           fontWeight: FontWeight.w500),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: const BorderSide(
//                             color: Colors.black12,
//                           )),
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: const BorderSide(
//                           color: Colors.red, // Error border color
//                           width: 1,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: const BorderSide(
//                               color: Color(0xff1F0A68), width: 1)),
//                       labelText: selectedPosition,
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5),
//                           borderSide: const BorderSide(
//                               color: Colors.amber, width: 0.5))),
//                   // value: selectedPosition.isEmpty ? null : selectedPosition,
//                   onChanged: (newValue) {
//                     ref.read(selectedPositionProvider.notifier).state =
//                         newValue!;
//                   },
//                   items: ['TSE', 'RSO', 'Position 3']
//                       .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   // items: tseList.toSet().map<DropdownMenuItem<String>>((String value) {
//                   //   return DropdownMenuItem<String>(
//                   //     value: value,
//                   //     child: Text(value),
//                   //   );
//                   // }).toList(),
//                 ),
//         ],
//       ),
//     );
//   }
// }

final buttons = ['All', 'TSE', 'AREA', 'ABM', 'ASM', 'RSO'];

// final selectedIndexProvider = StateProvider<int>((ref) => 0);
