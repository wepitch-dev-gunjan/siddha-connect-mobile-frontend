import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/utils/sizes.dart';
import '../../common/dashboard_options.dart';
import '../../utils/common_style.dart';
import '../../utils/providers.dart';
import '../repo/sales_dashboard_repo.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);
final selectedPositionProvider = StateProvider<String>((ref) => 'All');
final selectedItemProvider = StateProvider<String?>((ref) => null);

class SmallCusBtn extends ConsumerWidget {
  const SmallCusBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDealer = ref.watch(dealerRoleProvider);
    final selectedIndex = ref.watch(selectedIndexProvider);
    final selectedPosition = ref.watch(selectedPositionProvider);
    final subOrdinates = ref.watch(subordinateProvider);

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
                        child: subOrdinates.when(
                          data: (data) {
                            if (data == null || data['positions'] == null) {
                              return const Text("No positions available");
                            }

                            final positions = data['positions'];

                            if (positions.isEmpty) {
                              return const Text("No positions available");
                            }

                            return Row(
                              children:
                                  List.generate(positions.length + 1, (index) {
                                if (index == positions.length) {
                                  // Static DEALER button after all positions
                                  return GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(selectedIndexProvider.notifier)
                                          .state = positions.length + 1;
                                      ref
                                          .read(
                                              selectedPositionProvider.notifier)
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
                                        color: selectedIndex ==
                                                positions.length + 1
                                            ? AppColor.primaryColor
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                            color: AppColor.primaryColor,
                                            width: 1.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'DEALER',
                                          style: GoogleFonts.lato(
                                            color: selectedIndex ==
                                                    positions.length + 1
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
                                  return GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(selectedIndexProvider.notifier)
                                          .state = index + 1;
                                      ref
                                          .read(
                                              selectedPositionProvider.notifier)
                                          .state = positions[index];
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
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                            color: AppColor.primaryColor,
                                            width: 1.0),
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
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }),
                            );
                          },
                          error: (error, stackTrace) =>
                              const Text("Something went wrong"),
                          loading: () => const Text("Loading...."),
                        ),
                      ),
                    ),
                  ],
                ),
                heightSizedBox(8.0),
                if (selectedIndex != 0 && selectedPosition != "DEALER")
                  CusDropdown(selectedPosition: selectedPosition),
                if (selectedPosition == "DEALER") ...[
                  heightSizedBox(8.0),
                  const DealerSelectionDropdown()
                ],
              ],
            ),
          );
  }
}

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

final getDealerListDataProvider = FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final getDealerList = await ref
      .watch(salesRepoProvider)
      .getDealerListForEmployeeData(
          tdFormat: options.tdFormat,
          dataFormat: options.dataFormat,
          startDate: options.firstDate,
          endDate: options.lastDate,
          dealerCategory: options.dealerCategory);
  return getDealerList;
});

final selectedDealerProvider = StateProvider<String>((ref) => "");
final dealerCategoryProvider = StateProvider<String>((ref) => "ALL");

class DealerSelectionDropdown extends ConsumerWidget {
  const DealerSelectionDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dealerCategory = ref.watch(dealerCategoryProvider);
    final selectedDealer = ref.watch(selectedDealerProvider);
    final dealerListData = ref.watch(getDealerListDataProvider);

    List<String> dealers = ["Dealer 1", "Dealer 2", "Dealer 3"];

    // Update dropdownLabel to show the selected option and dealer
    String dropdownLabel = selectedDealer.isEmpty
        ? dealerCategory
        : "$dealerCategory/$selectedDealer";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButtonFormField<String>(
          value: dealerCategory,
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
                  color: Colors.red,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: Color(0xff1F0A68), width: 1)),
              labelText: dropdownLabel,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide:
                      const BorderSide(color: Colors.amber, width: 0.5))),
          onChanged: (String? newValue) {
            // Show popup dialog based on selected option
            _showPopup(context, ref, newValue!, dealers);
            // Update selectedOptionProvider when a new value is selected
            ref.read(dealerCategoryProvider.notifier).state = newValue!;
            // Reset selected dealer when a new option is selected
            ref.read(selectedDealerProvider.notifier).state = "";
          },
          items: const [
            DropdownMenuItem(value: "ALL", child: Text("ALL")),
            DropdownMenuItem(value: "KRO", child: Text("KRO")),
            DropdownMenuItem(value: "NPO", child: Text("NPO")),
          ],
        ),
      ],
    );
  }

  // Show popup to choose between View List and View Report
  void _showPopup(
      BuildContext context, WidgetRef ref, String name, List<String> dealers) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text("$name Options"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text("View List"),
                  onTap: () {
                    Navigator.pop(context);
                    // Show dealers list dialog
                    _showDealers(context, ref, name, "List");
                  },
                ),
                ListTile(
                  title: const Text("View Report"),
                  onTap: () {
                    Navigator.pop(context);
                    // Show dealers report dialog
                    _showDealers(context, ref, name, "Report");
                  },
                ),
              ],
            ),
            contentPadding: EdgeInsets.all(16.0),
            // Wrap AlertDialog with a Container or SizedBox to increase the width
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ));
      },
    );
  }

  // void _showDealers(
  //     BuildContext context, WidgetRef ref, String name, String type) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SizedBox(
  //         width: MediaQuery.of(context).size.width,
  //         child: AlertDialog(
  //           title: Text("$name - $type"),
  //           content: Consumer(
  //             builder: (context, ref, child) {
  //               // Fetch the dealer data from the provider
  //               final dealerDataProvider = ref.watch(getDealerListDataProvider);

  //               return dealerDataProvider.when(
  //                 data: (dealerData) {
  //                   log("DealerData====$dealerData");

  //                   // Map the dealerData (List<Map<String, String>>) and extract the 'BUYER' field
  //                   final dealers = dealerData
  //                       .map<String>(
  //                           (dealer) => dealer['BUYER CODE'].toString())
  //                       .toList();

  //                   // Convert the mapped dealers to a list of ListTile widgets
  //                   final dealerWidgets = dealers
  //                       .map<Widget>((dealer) => ListTile(
  //                             title: Text(dealer),
  //                             onTap: () {
  //                               // Update the selected dealer
  //                               ref
  //                                   .read(selectedDealerProvider.notifier)
  //                                   .state = dealer;

  //                               Navigator.pop(context); // Close the dialog
  //                             },
  //                           ))
  //                       .toList(); // Convert Iterable to List<Widget>

  //                   return SizedBox(
  //                     height: 400.h,
  //                     child: SingleChildScrollView(
  //                       child: Column(
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: dealerWidgets, // Now it's List<Widget>
  //                       ),
  //                     ),
  //                   );
  //                 },
  //                 error: (error, stackTrace) => const Center(
  //                   child: Text("Something went wrong"),
  //                 ),
  //                 loading: () => const Center(
  //                   child: CircularProgressIndicator(),
  //                 ),
  //               );
  //             },
  //           ),
  //           // contentPadding: const EdgeInsets.all(10.0),
  //           // Wrap AlertDialog with a Container or SizedBox to increase the width
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10.0),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  void _showDealers(
      BuildContext context, WidgetRef ref, String name, String type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$name - $type"),
          content: Consumer(
            builder: (context, ref, child) {
              // Fetch the dealer data from the provider
              final dealerDataProvider = ref.watch(getDealerListDataProvider);

              return dealerDataProvider.when(
                data: (dealerData) {
                  log("DealerData====$dealerData");

                  // Map the dealerData and extract both 'BUYER' and 'BUYER CODE'
                  final dealerWidgets = dealerData.map<Widget>((dealer) {
                    final buyer = dealer['BUYER'].toString();
                    final buyerCode = dealer['BUYER CODE'].toString();

                    return ListTile(
                      title: Text(buyer), // Display 'BUYER'
                      subtitle: Text(buyerCode), // Display 'BUYER CODE'
                      onTap: () {
                        // Update the selected dealer with 'BUYER CODE'
                        ref.read(selectedDealerProvider.notifier).state =
                            buyerCode;

                        Navigator.pop(context); // Close the dialog
                      },
                    );
                  }).toList(); // Convert Iterable to List<Widget>

                  return SizedBox(
                    height: 400.h,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: dealerWidgets, // List<Widget>
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
              );
            },
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        );
      },
    );
  }

  // void _showDealers(
  //     BuildContext context, WidgetRef ref, String name, String type) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("$name - $type"),
  //         content: Consumer(
  //           builder: (context, ref, child) {
  //             // Fetch the dealer data from the provider
  //             final dealerDataProvider = ref.watch(getDealerListDataProvider);

  //             return dealerDataProvider.when(
  //               data: (dealerData) {
  //                 log("DealerData====$dealerData");

  //                 // Map the dealerData (List<Map<String, String>>) and extract the 'BUYER' field
  //                 final dealers = dealerData
  //                     .map<String>((dealer) => dealer['BUYER'].toString())
  //                     .toList();

  //                 // Convert the mapped dealers to a list of ListTile widgets
  //                 final dealerWidgets = dealers
  //                     .map<Widget>((dealer) => ListTile(
  //                           title: Text(dealer),
  //                           onTap: () {
  //                             // Update the selected dealer
  //                             ref.read(selectedDealerProvider.notifier).state =
  //                                 dealer;

  //                             Navigator.pop(context); // Close the dialog
  //                           },
  //                         ))
  //                     .toList(); // Convert Iterable to List<Widget>

  //                 return SingleChildScrollView(
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: dealerWidgets, // Now it's List<Widget>
  //                   ),
  //                 );
  //               },
  //               error: (error, stackTrace) => const Center(
  //                 child: Text("Something went wrong"),
  //               ),
  //               loading: () => const Center(
  //                 child: CircularProgressIndicator(),
  //               ),
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }
}
