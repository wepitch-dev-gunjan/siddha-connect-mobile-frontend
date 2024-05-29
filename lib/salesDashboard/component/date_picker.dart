import 'package:flutter/material.dart';
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

