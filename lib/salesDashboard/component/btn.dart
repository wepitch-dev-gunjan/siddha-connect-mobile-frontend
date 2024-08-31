import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/salesDashboard/tables/channel_table.dart';
import 'package:siddha_connect/salesDashboard/tables/model_table.dart';
import 'package:siddha_connect/salesDashboard/tables/segment_position_wise.dart';
import 'package:siddha_connect/utils/sizes.dart';
import '../../auth/screens/splash_screen.dart';
import '../../utils/common_style.dart';
import '../../utils/providers.dart';
import '../tables/segment_table.dart';

final selectedButtonProvider = StateProvider<int>((ref) => 0);

class FullSizeBtn extends ConsumerWidget {
  const FullSizeBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedButtonIndex = ref.watch(selectedButtonProvider);
    final selectedBtn = ref.watch(selectedIndexProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              SegmentedButton(
                title: 'Segment',
                subtitle: '(Price bucket)',
                isSelected: selectedButtonIndex == 0,
                onTap: () =>
                    ref.read(selectedButtonProvider.notifier).state = 0,
              ),
              SegmentedButton(
                title: 'Channel',
                subtitle: '(DL.Category)',
                isSelected: selectedButtonIndex == 1,
                onTap: () =>
                    ref.read(selectedButtonProvider.notifier).state = 1,
              ),
              SegmentedButton(
                title: 'Model',
                subtitle: '(Some Info)',
                isSelected: selectedButtonIndex == 2,
                onTap: () =>
                    ref.read(selectedButtonProvider.notifier).state = 2,
              ),
            ],
          ),
        ),
        if (selectedButtonIndex == 0)
          selectedBtn == 0
              ? const SegmentTable()
              : const SegmentTablePositionWise()
        else if (selectedButtonIndex == 1)
          const ChannelTable()
        else
          const ModelTable(),
      ],
    );
  }
}

class SegmentedButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const SegmentedButton({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: isSelected ? AppColor.primaryColor : AppColor.whiteColor,
            border: Border.all(width: 0.05),
          ),
          child: Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$title\n',
                    style: GoogleFonts.lato(
                      color: isSelected ? Colors.white : Colors.black,
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: subtitle,
                    style: GoogleFonts.lato(
                      color: isSelected ? Colors.white : Colors.black,
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
                              children:
                                  List.generate(positions.length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(selectedIndexProvider.notifier)
                                        .state = index + 1;
                                    ref
                                        .read(selectedPositionProvider.notifier)
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
                                      borderRadius: BorderRadius.circular(5.0),
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
                          loading: () => const Text("Loading....")),
                    )),
                  ],
                ),
                heightSizedBox(8.0),
                if (selectedIndex != 0)
                  CusDropdown(selectedPosition: selectedPosition),
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
