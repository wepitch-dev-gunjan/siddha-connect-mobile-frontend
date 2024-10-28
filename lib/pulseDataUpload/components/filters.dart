import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../salesDashboard/component/dashboard_small_btn.dart';
import '../../utils/common_style.dart';
import '../../utils/providers.dart';
import '../../utils/sizes.dart';

class Filters extends ConsumerWidget {
  const Filters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDealer = ref.watch(dealerRoleProvider);
    final selectedIndex = ref.watch(selectedIndexProvider);
    final selectedPosition = ref.watch(selectedPositionProvider);
    final subOrdinates = ref.watch(subordinateProvider);

    // Define the customLabels list with only keys
    final List<String> customLabels = [
      'CODE',
      'TSE',
      'TYPE',
      'AREA',
      'TL NAME',
      'ABM',
      'ASE',
      'ASM',
      'RSO',
      'ZSM'
    ];

    return isDealer == 'dealer'
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref.read(selectedIndexProvider.notifier).state = 0;
                        ref.read(selectedPositionProvider.notifier).state =
                            'All';
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
                          border: Border.all(
                              color: AppColor.primaryColor, width: 1.0),
                        ),
                        child: Center(
                          child: Text(
                            'All',
                            style: GoogleFonts.lato(
                              color: selectedIndex == 0
                                  ? Colors.white
                                  : Colors.black,
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
                          children:
                              List.generate(customLabels.length + 1, (index) {
                            if (index == customLabels.length) {
                              // Static DEALER button after all custom labels
                              return GestureDetector(
                                onTap: () {
                                  ref
                                      .read(selectedIndexProvider.notifier)
                                      .state = customLabels.length + 1;
                                  ref
                                      .read(selectedPositionProvider.notifier)
                                      .state = 'DEALER';
                                  ref
                                      .read(selectedItemProvider.notifier)
                                      .state = null;
                                },
                                child: Container(
                                  width: 70,
                                  height: 30,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color:
                                        selectedIndex == customLabels.length + 1
                                            ? AppColor.primaryColor
                                            : Colors.transparent,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        color: AppColor.primaryColor,
                                        width: 1.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'DEALER',
                                      style: GoogleFonts.lato(
                                        color: selectedIndex ==
                                                customLabels.length + 1
                                            ? Colors.white
                                            : const Color(0xff999292),
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              // Dynamic buttons from customLabels
                              return GestureDetector(
                                onTap: () {
                                  ref
                                      .read(selectedIndexProvider.notifier)
                                      .state = index + 1;
                                  ref
                                      .read(selectedPositionProvider.notifier)
                                      .state = customLabels[index];
                                  ref
                                      .read(selectedItemProvider.notifier)
                                      .state = null;
                                },
                                child: Container(
                                  width: 70,
                                  height: 30,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color: selectedIndex == index + 1
                                        ? AppColor.primaryColor
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        color: AppColor.primaryColor,
                                        width: 1.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      customLabels[index],
                                      style: GoogleFonts.lato(
                                        color: selectedIndex == index + 1
                                            ? Colors.white
                                            : const Color(0xff999292),
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
                heightSizedBox(8.0),
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
    final selectedItem = ref.watch(selectedItemProvider);
    final subOrdinates = ref.watch(subordinateProvider);

    log("SelectedItems$selectedItem");

    return subOrdinates.when(
      data: (data) {
        final subordinates = data[selectedPosition] ?? [];
        if (selectedItem == null && subordinates.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(selectedItemProvider.notifier).state = subordinates[0];
          });
        }

        return DropdownButtonFormField<String>(
          dropdownColor: Colors.white,
          value: selectedItem,
          style: const TextStyle(
              fontSize: 16.0, height: 1.5, color: Colors.black87),
          decoration: InputDecoration(
              fillColor: const Color(0XFFfafafa),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
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
                  borderSide:
                      const BorderSide(color: Color(0xff1F0A68), width: 1)),
              labelText: selectedPosition,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide:
                      const BorderSide(color: Colors.amber, width: 0.5))),
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
