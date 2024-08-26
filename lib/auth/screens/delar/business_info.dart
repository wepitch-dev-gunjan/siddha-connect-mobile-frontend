import 'package:flutter/material.dart';
import '../../../utils/fields.dart';
import '../../../utils/sizes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final preferredCommunicationProvider = StateProvider<String?>((ref) => null);

class BusinessInfo extends ConsumerWidget {
  final TextEditingController businessType;
  final TextEditingController businessYears;
  final TextEditingController specialNotes;

  const BusinessInfo({
    super.key,
    required this.businessType,
    required this.businessYears,
    required this.specialNotes,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPosition = ref.watch(preferredCommunicationProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Business Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        heightSizedBox(10.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Type of Business",
          maxLines: 1,
          controller: businessType,
          keyboardType: TextInputType.text,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Years in Business",
          maxLines: 1,
          maxLength: 2,
          controller: businessYears,
          keyboardType: TextInputType.number,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        DropdownButtonFormField(
          style: const TextStyle(
              fontSize: 16.0, height: 1.5, color: Colors.black87),
          decoration: InputDecoration(
              fillColor: const Color(0XFFfafafa),
              contentPadding: contentPadding,
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
              labelText: "Preferred Communication Method",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide:
                      const BorderSide(color: Colors.amber, width: 0.5))),
          value: selectedPosition,
          onChanged: (newValue) {
            ref.read(preferredCommunicationProvider.notifier).state = newValue;
          },
          items: ['Phone Call', 'Email', 'WhatsApp']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        heightSizedBox(8.0),
        const Text('Special Notes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        heightSizedBox(10.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Special Notes",
          maxLines: 3,
          keyboardType: TextInputType.text,
          controller: specialNotes,
        ),
      ],
    );
  }
}
