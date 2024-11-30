import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/extraction/components/drop_downs.dart';
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
                            final positions = data?['positions'] ?? [];

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

// class CusDropdown extends ConsumerWidget {
//   final String selectedPosition;

//   const CusDropdown({super.key, required this.selectedPosition});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedItem = ref.watch(selectedItemProvider);
//     final subOrdinates = ref.watch(subordinateProvider);

//     return subOrdinates.when(
//       data: (data) {
//         final subordinates = data[selectedPosition] ?? [];
//         if (selectedItem == null && subordinates.isNotEmpty) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             ref.read(selectedItemProvider.notifier).state = subordinates[0];
//           });
//         }

//         return DropdownButtonFormField<String>(
//           dropdownColor: Colors.white,
//           value: selectedItem,
//           style: const TextStyle(
//               fontSize: 16.0, height: 1.5, color: Colors.black87),
//           decoration: InputDecoration(
//               fillColor: const Color(0XFFfafafa),
//               contentPadding:
//                   const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//               errorStyle: const TextStyle(color: Colors.red),
//               labelStyle: const TextStyle(
//                   fontSize: 15.0,
//                   color: Colors.black54,
//                   fontWeight: FontWeight.w500),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: const BorderSide(
//                     color: Colors.black12,
//                   )),
//               errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: const BorderSide(
//                   color: Colors.red, // Error border color
//                   width: 1,
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide:
//                       const BorderSide(color: Color(0xff1F0A68), width: 1)),
//               labelText: selectedPosition,
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide:
//                       const BorderSide(color: Colors.amber, width: 0.5))),
//           onChanged: (newValue) {
//             ref.read(selectedItemProvider.notifier).state = newValue!;
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
//         child: CircularProgressIndicator(),
//       ),
//     );
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
        if (selectedItem == null && subordinates.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(selectedItemProvider.notifier).state = subordinates[0];
          });
        }

        return DropdownButtonFormField<String>(
          dropdownColor: Colors.white,
          value: selectedItem,
          decoration: inputDecoration(label: selectedPosition),
          onChanged: (newValue) {
            ref.read(selectedItemProvider.notifier).state = newValue!;
          },
          items: subordinates.map<DropdownMenuItem<String>>((value) {
            final isSelected = value == selectedItem;
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(bottom: 10),
                width: width(context),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColor.primaryColor
                      : Colors.grey[100], // Change color when selected
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: isSelected
                        ? Colors.blue
                        : Colors.black12, // Change border color when selected
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : Colors.black87, // Change text color when selected
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    if (value != "ALL")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReportData(
                            title: "Target",
                            value: "N/A",
                            isSelected: isSelected,
                          ),
                          ReportData(
                            title: "MTD",
                            value: "N/A",
                            isSelected: isSelected,
                          ),
                          ReportData(
                            title: "LMTD",
                            value: "N/A",
                            isSelected: isSelected,
                          ),
                          ReportData(
                            title: "GWTH%",
                            value: "N/A %",
                            isSelected: isSelected,
                          ),
                          ReportData(
                            title: "REQ.ADS",
                            value: "N/A",
                            isSelected: isSelected,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
          selectedItemBuilder: (BuildContext context) {
            return subordinates.map<Widget>((value) {
              return Text(
                value,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              );
            }).toList(); // Explicitly cast to List<Widget>
          },
        );
      },
      error: (error, stackTrace) => const Text("Something went wrong"),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class ReportData extends StatelessWidget {
  final String title, value;
  final bool isSelected;
  const ReportData(
      {super.key,
      required this.title,
      required this.value,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 12.0, color: isSelected ? Colors.white : Colors.grey),
        ),
        Text(
          value,
          style: TextStyle(
              fontSize: 12.0, color: isSelected ? Colors.white : Colors.grey),
        ),
      ],
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

    // List<String> dealers = ["Dealer 1", "Dealer 2", "Dealer 3"];

    String dropdownLabel = selectedDealer.isEmpty
        ? dealerCategory
        : "$dealerCategory/$selectedDealer";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButtonFormField<String>(
          dropdownColor: Colors.white,
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
            _showPopup(context, ref, newValue!);
            // Update selectedOptionProvider when a new value is selected
            ref.read(dealerCategoryProvider.notifier).state = newValue;
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

  void _showPopup(BuildContext context, WidgetRef ref, String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            title: Text("$name Options"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text("View List"),
                  onTap: () {
                    Navigator.pop(context);
                    _showDealers(context, ref, name, "List");
                  },
                ),
                ListTile(
                  title: const Text("View Report"),
                  onTap: () {
                    Navigator.pop(context);
                    _showDealers(context, ref, name, "Report");
                  },
                ),
              ],
            ),
            contentPadding: const EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ));
      },
    );
  }

  void _showDealers(
      BuildContext context, WidgetRef ref, String name, String type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("$name - $type"),
          content: Consumer(
            builder: (context, ref, child) {
              final dealerDataProvider = ref.watch(getDealerListDataProvider);

              return dealerDataProvider.when(
                data: (dealerData) {
                  log("DealerData$dealerData");
                  if (dealerData == null || dealerData.isEmpty) {
                    return const Center(
                      child: Text("No dealers available"),
                    );
                  }

                  final dealerWidgets = dealerData.map<Widget>((dealer) {
                    final buyer = dealer['BUYER'].toString();
                    final buyerCode = dealer['BUYER CODE'].toString();

                    return ListTile(
                      title: Text(buyer),
                      subtitle: Text(buyerCode),
                      onTap: () {
                        ref.read(selectedDealerProvider.notifier).state =
                            buyerCode;

                        Navigator.pop(context);
                      },
                    );
                  }).toList();

                  return SizedBox(
                    height: 400.h,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: dealerWidgets,
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
}
