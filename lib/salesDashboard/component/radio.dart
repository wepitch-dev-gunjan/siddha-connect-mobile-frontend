import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/utils/common_style.dart';
import 'package:siddha_connect/utils/sizes.dart';

final selectedOption1Provider = StateProvider<String>((ref) => 'MTD');
final selectedOption2Provider = StateProvider<String>((ref) => 'value');

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
              const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    ref.read(selectedOption1Provider.notifier).state = "YTD";
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    margin: EdgeInsets.only(right: 5.w),
                    // height: 40.h,
                    width: width(context),
                    decoration: BoxDecoration(
                        border: Border.all(width: .8),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        CustomRadioButton(
                            value: "YTD",
                            displayValue: "YTD",
                            groupValue: selectedOption1,
                            onChanged: (value) {
                              ref.read(selectedOption1Provider.notifier).state =
                                  value!;
                            }),
                        const Spacer(),
                        CustomRadioButton(
                          value: "MTD",
                          displayValue: "MTD",
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
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    ref.read(selectedOption2Provider.notifier).state = "value";
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    // height: 40.h,
                    width: width(context),
                    decoration: BoxDecoration(
                        border: Border.all(width: .8),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        CustomRadioButton(
                            value: "value",
                            displayValue: "Value",
                            groupValue: selectedOption2,
                            onChanged: (value) {
                              ref.read(selectedOption2Provider.notifier).state =
                                  value!;
                            }),
                        const Spacer(),
                        CustomRadioButton(
                            value: "volume",
                            displayValue: "Volume",
                            groupValue: selectedOption2,
                            onChanged: (value) {
                              ref.read(selectedOption2Provider.notifier).state =
                                  value!;
                            })
                      ],
                    ),
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

// class TopRadioButtons extends ConsumerWidget {
//   const TopRadioButtons({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedOption1 = ref.watch(selectedOption1Provider);
//     final selectedOption2 = ref.watch(selectedOption2Provider);
//     return Column(
//       children: [
//         Padding(
//           padding:
//               const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             decoration: BoxDecoration(
//               border: Border.all(
//                 width: 0.5,
//                 color: AppColor.primaryColor,
//               ),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CustomRadioButton(
//                   value: "MTD",
//                   displayValue: "MTD",
//                   groupValue: selectedOption1,
//                   onChanged: (value) {
//                     ref.read(selectedOption1Provider.notifier).state = value!;
//                   },
//                 ),
//                 widthSizedBox(20.0),
//                 Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 10),
//                   height: 20,
//                   width: 1,
//                   color: Colors.grey,
//                 ),
//                 widthSizedBox(20.0),
//                 CustomRadioButton(
//                   value: "value",
//                   displayValue: "Value",
//                   groupValue: selectedOption2,
//                   onChanged: (value) {
//                     ref.read(selectedOption2Provider.notifier).state = value!;
//                   },
//                 ),
//                 const Spacer(),
//                 CustomRadioButton(
//                   value: "volume",
//                   displayValue: "Volume",
//                   groupValue: selectedOption2,
//                   onChanged: (value) {
//                     ref.read(selectedOption2Provider.notifier).state = value!;
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class CustomRadioButton extends StatelessWidget {
  final String value;
  final String displayValue;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const CustomRadioButton({
    super.key,
    required this.value,
    required this.displayValue,
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
              width: 15.w,
              height: 16.h,
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
                        width: 7.w,
                        height: 8.h,
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
              displayValue,
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 10.sp,
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
