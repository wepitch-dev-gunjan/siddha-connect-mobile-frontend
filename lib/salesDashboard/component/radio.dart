import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/utils/common_style.dart';
import 'package:siddha_connect/utils/sizes.dart';

final selectedOption1Provider = StateProvider<String>((ref) => 'YTD');
final selectedOption2Provider = StateProvider<String>((ref) => 'Value');

class TopRadioButtons extends ConsumerWidget {
  const TopRadioButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedOption1 = ref.watch(selectedOption1Provider);
    final selectedOption2 = ref.watch(selectedOption2Provider);
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 8, left: 10, right: 10, bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.only(right: 5),
                  height: 45,
                  width: width(context),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      CustomRadioButton(
                          value: "YTD",
                          groupValue: selectedOption1,
                          onChanged: (value) {
                            ref.read(selectedOption1Provider.notifier).state =
                                value!;
                          }),
                      const Spacer(),
                      CustomRadioButton(
                        value: "MTD",
                        groupValue: selectedOption1,
                        onChanged: (value) {
                          ref.read(selectedOption1Provider.notifier).state =
                              value!;
                        },
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: 45,
                  width: width(context),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      CustomRadioButton(
                          value: "Value",
                          groupValue: selectedOption2,
                          onChanged: (value) {
                            ref.read(selectedOption2Provider.notifier).state =
                                value!;
                          }),
                      const Spacer(),
                      CustomRadioButton(
                          value: "Volume",
                          groupValue: selectedOption2,
                          onChanged: (value) {
                            ref.read(selectedOption2Provider.notifier).state =
                                value!;
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomRadioButton extends StatelessWidget {
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const CustomRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColor.primaryColor
                      : AppColor.primaryColor,
                  width: 2.0,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10.0,
                        height: 10.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    )
                  : null,
            ),
            widthSizedBox(5.0),
            Text(
              value,
              style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
            ),
            widthSizedBox(15.0)
          ],
        ),
      ),
    );
  }
}
