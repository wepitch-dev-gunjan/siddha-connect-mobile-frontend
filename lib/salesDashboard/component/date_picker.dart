import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/common_style.dart';

class DatePickerContainer extends StatelessWidget {
  const DatePickerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 40.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(11)),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              DatePickerComponent(initialYear: "2023", initialMonth: "April"),
              Spacer(),
              DatePickerComponent(initialYear: "2024", initialMonth: "April"),
            ],
          ),
        ),
      ),
    );
  }
}

Future<DateTime?> selectDate(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime.now(),
  );

  return pickedDate;
}

class DatePickerComponent extends StatefulWidget {
  final String initialYear;
  final String initialMonth;

  const DatePickerComponent({
    super.key,
    required this.initialYear,
    required this.initialMonth,
  });

  @override
  _DatePickerComponentState createState() => _DatePickerComponentState();
}

class _DatePickerComponentState extends State<DatePickerComponent> {
  late String year;
  late String month;
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  void initState() {
    super.initState();
    year = widget.initialYear;
    month = widget.initialMonth;
  }

  void _updateDate(DateTime pickedDate) {
    setState(() {
      year = pickedDate.year.toString();
      month = months[pickedDate.month - 1]; // Convert month number to string
    });
  }

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
        const SizedBox(width: 13.0),
        InkWell(
          onTap: () async {
            final pickedDate = await selectDate(context);
            if (pickedDate != null) {
              _updateDate(pickedDate);
            }
          },
          child: Row(
            children: [
              Text(
                month,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
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
