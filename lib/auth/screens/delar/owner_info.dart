import 'package:flutter/material.dart';
import '../../../salesDashboard/component/date_picker.dart';
import '../../../utils/fields.dart';
import '../../../utils/sizes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final birthDateProvider = StateProvider<DateTime?>((ref) => null);
final passwordVisibilityProvider = StateProvider<bool>((ref) => false);

class OwnerInfo extends ConsumerWidget {
  final TextEditingController name;
  final TextEditingController position;
  final TextEditingController contactNumber;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController homeAddress;
  final TextEditingController birthDay;

  const OwnerInfo(
      {super.key,
      required this.name,
      required this.position,
      required this.contactNumber,
      required this.email,
      required this.homeAddress,
      required this.birthDay,
      required this.password});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final selectedDate = ref.watch(birthDateProvider);.
    final isPasswordVisible = ref.watch(passwordVisibilityProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Owner Information',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        heightSizedBox(10.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Name",
          maxLines: 1,
          controller: name,
          keyboardType: TextInputType.name,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Position",
          maxLines: 1,
          controller: position,
          keyboardType: TextInputType.text,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Contact Number",
          maxLines: 1,
          maxLength: 10,
          controller: contactNumber,
          keyboardType: TextInputType.number,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Email",
          maxLines: 1,
          controller: email,
          keyboardType: TextInputType.emailAddress,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Password",
          maxLines: 1,
          obscureText: !isPasswordVisible,
          suffixIcon: IconButton(
            onPressed: () {
              ref.read(passwordVisibilityProvider.notifier).state =
                  !isPasswordVisible;
            },
            icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off),
          ),
          controller: password,
          keyboardType: TextInputType.visiblePassword,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Home Address",
          maxLines: 1,
          controller: homeAddress,
          keyboardType: TextInputType.streetAddress,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Birthday",
          maxLines: 1,
          controller: birthDay,
          keyboardType: TextInputType.text,
          validator: validateField,
          readOnly: true,
          onTap: () async {
            final selectedDate = await selectDate(context);
            if (selectedDate != null) {
              ref.read(birthDateProvider.notifier).state = selectedDate;
              birthDay.text = formatDate(selectedDate);
            }
          },
        ),
      ],
    );
  }

  String formatDate(DateTime date) {
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}

// Future<DateTime?> selectDate(BuildContext context) async {
//   final DateTime? pickedDate = await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(1900),
//     lastDate: DateTime.now(),
//   );
//   return pickedDate;
// }
