import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../salesDashboard/component/date_picker.dart';
import '../../../utils/fields.dart';
import '../../../utils/sizes.dart';

final wifeBirthDateProvider = StateProvider<DateTime?>((ref) => null);

class WifeInfo extends ConsumerWidget {
  const WifeInfo({
    super.key,
    required this.wifeName,
    required this.wifeBirthday,
  });

  final TextEditingController wifeName;
  final TextEditingController wifeBirthday;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the provider to get the current selected date
    final wifeBirth = ref.watch(wifeBirthDateProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Family Information',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Wife's Name",
          maxLines: 1,
          keyboardType: TextInputType.name,
          controller: wifeName,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Wife's Birthday",
          maxLines: 1,
          keyboardType: TextInputType.text,
          controller: wifeBirthday,
          readOnly: true, // Prevent manual text input
          onTap: () async {
            final pickedDate = await selectDate(context);
            if (pickedDate != null) {
              ref.read(wifeBirthDateProvider.notifier).state = pickedDate;
              wifeBirthday.text = formatDate(pickedDate);
            }
          },
        ),
      ],
    );
  }
}

String formatDate(DateTime date) {
  final year = date.year.toString();
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '$year-$month-$day';
}
