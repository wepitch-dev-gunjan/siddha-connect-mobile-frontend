import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/common_style.dart';
import '../../utils/sizes.dart';

Future selectDate(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime.now(),
  );

  if (pickedDate != null) {
    final String formattedDate =
        "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
    return formattedDate;
  }
}

class DatePIckerComponent extends StatelessWidget {
  final String year;
  final String month;
  const DatePIckerComponent({
    super.key,
    required this.year,
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          year,
          style: GoogleFonts.lato(
              textStyle: const TextStyle(
                  color: AppColor.whiteColor, fontWeight: FontWeight.w600)),
        ),
        widthSizedBox(13.0),
        InkWell(
          onTap: () async {
            await selectDate(context);
          },
          child: Row(
            children: [
              Text(
                month,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      color: AppColor.whiteColor, fontWeight: FontWeight.w600),
                ),
              ),
              const Icon(
                Icons.arrow_drop_down,
                color: AppColor.whiteColor,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CusRadio extends StatelessWidget {
  final String selectedOption, text, text1;
  final ValueChanged<String?> onChanged;
  final List<String> options;
  final List<String> labels;

  const CusRadio({
    super.key,
    required this.selectedOption,
    required this.onChanged,
    required this.options,
    required this.labels,
    required this.text,
    required this.text1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 165,
        height: 40.h,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Radio(
              value: 'wire',
              groupValue: 0,
              onChanged: (value) {},
              activeColor: const Color(0xffFFBD11),
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            ),
            Radio(value: 0, groupValue: "YTD", onChanged: (value) {}),
            Text(
              text1,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            ),
          ],
        ));
  }
}
