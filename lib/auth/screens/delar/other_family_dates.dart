import 'package:flutter/material.dart';
import 'package:siddha_connect/auth/screens/delar/wife_info.dart';

import '../../../salesDashboard/component/date_picker.dart';
import '../../../utils/fields.dart';
import '../../../utils/sizes.dart';
import 'family_info.dart';

class OtherImportantFamilyDates extends StatefulWidget {
  const OtherImportantFamilyDates({super.key});

  @override
  OtherImportantFamilyDatesState createState() =>
      OtherImportantFamilyDatesState();
}

class OtherImportantFamilyDatesState extends State<OtherImportantFamilyDates> {
  List<Widget> familyDateFields = [];
  List<TextEditingController> descriptionControllers = [];
  List<TextEditingController> dateControllers = [];

  @override
  void initState() {
    super.initState();
    addFamilyDateField();
  }

  void addFamilyDateField() {
    setState(() {
      final descriptionController = TextEditingController();
      final dateController = TextEditingController();

      descriptionControllers.add(descriptionController);
      dateControllers.add(dateController);

      familyDateFields.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightSizedBox(10.0),
          TxtField(
            contentPadding: contentPadding,
            labelText: "Description",
            maxLines: 1,
            keyboardType: TextInputType.text,
            controller: descriptionController,
          ),
          heightSizedBox(8.0),
          TxtField(
            contentPadding: contentPadding,
            labelText: "Date",
            maxLines: 1,
            keyboardType: TextInputType.text, // Change this to text for date
            controller: dateController,
            readOnly: true, // Prevent manual text input
            onTap: () async {
              final pickedDate = await selectDate(context);
              if (pickedDate != null) {
                setState(() {
                  dateController.text = formatDate(pickedDate);
                });
              }
            },
          ),
        ],
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Other Important Family Dates',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ...familyDateFields,
        heightSizedBox(8.0),
        AddMoreBtn(
          onTap: () {
            addFamilyDateField();
          },
        ),
        heightSizedBox(8.0),
      ],
    );
  }
}
