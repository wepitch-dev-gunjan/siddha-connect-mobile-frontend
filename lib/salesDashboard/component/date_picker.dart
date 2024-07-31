import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/common_style.dart';

final firstDateProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, 1);
});

final lastDateProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

class DatePickerContainer extends ConsumerWidget {
  const DatePickerContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateTime firstDate = ref.watch(firstDateProvider);
    final DateTime lastDate = ref.watch(lastDateProvider);

    log("first$firstDate");
    log("Last$lastDate");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 38.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              DatePickerComponent(
                initialYear: firstDate.year.toString(),
                initialMonth: _monthName(firstDate.month),
                initialDay: _formatDay(firstDate.day),
                onDatePicked: (pickedDate) {
                  ref.read(firstDateProvider.notifier).state = pickedDate;
                },
              ),
              const Spacer(),
              DatePickerComponent(
                initialYear: lastDate.year.toString(),
                initialMonth: _monthName(lastDate.month),
                initialDay: _formatDay(lastDate.day),
                onDatePicked: (pickedDate) {
                  ref.read(lastDateProvider.notifier).state = pickedDate;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _monthName(int month) {
    const List<String> months = [
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
      'December',
    ];
    return months[month - 1];
  }

  static String _formatDay(int day) {
    return day < 10 ? '0$day' : day.toString();
  }
}

Future<DateTime?> selectDate(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1970),
    lastDate: DateTime.now(),
  );

  return pickedDate;
}

class DatePickerComponent extends StatefulWidget {
  final String initialYear;
  final String initialMonth;
  final String initialDay;
  final Function(DateTime) onDatePicked;

  const DatePickerComponent({
    super.key,
    required this.initialYear,
    required this.initialMonth,
    required this.initialDay,
    required this.onDatePicked,
  });

  @override
  DatePickerComponentState createState() => DatePickerComponentState();
}

class DatePickerComponentState extends State<DatePickerComponent> {
  late String year;
  late String month;
  late String day;
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
    day = widget.initialDay;
  }

  String _formatDay(int day) {
    return day < 10 ? '0$day' : day.toString();
  }

  void _updateDate(DateTime pickedDate) {
    setState(() {
      year = pickedDate.year.toString();
      month = months[pickedDate.month - 1];
      day = _formatDay(pickedDate.day);
    });
    widget.onDatePicked(pickedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          day,
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 13,
              color: AppColor.whiteColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 8.0),
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
                    fontSize: 13,
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_drop_down,
                color: AppColor.whiteColor,
              ),
              Text(
                year,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 13,
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w600,
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
