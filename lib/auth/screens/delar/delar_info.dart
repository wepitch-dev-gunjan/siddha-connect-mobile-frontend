import 'package:flutter/material.dart';
import '../../../utils/fields.dart';
import '../../../utils/sizes.dart';

class DelarInfo extends StatelessWidget {
  final TextEditingController delerCode;
  final TextEditingController shopName;
  final TextEditingController shopArea;
  final TextEditingController shopAddress;
  const DelarInfo({
    super.key,
    required this.delerCode,
    required this.shopName,
    required this.shopArea,
    required this.shopAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Dealer Information',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        heightSizedBox(10.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Dealer Code",
          maxLines: 1,
          controller: delerCode,
          keyboardType: TextInputType.text,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Shop Name",
          maxLines: 1,
          controller: shopName,
          keyboardType: TextInputType.text,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Shop Area",
          maxLines: 1,
          controller: shopArea,
          keyboardType: TextInputType.text,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Shop Address",
          maxLines: 1,
          controller: shopAddress,
          keyboardType: TextInputType.streetAddress,
          validator: validateField,
        ),
      ],
    );
  }
}
