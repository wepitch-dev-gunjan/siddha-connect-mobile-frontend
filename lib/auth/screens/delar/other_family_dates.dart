import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/auth/screens/delar/wife_info.dart';
import 'package:siddha_connect/profile/screen/dealer/getDealer_profile.dart';
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

class UpdateOtherImportantFamilyDates extends ConsumerStatefulWidget {
  const UpdateOtherImportantFamilyDates({super.key});

  @override
  UpdateOtherImportantFamilyDatesState createState() =>
      UpdateOtherImportantFamilyDatesState();
}

class UpdateOtherImportantFamilyDatesState
    extends ConsumerState<UpdateOtherImportantFamilyDates> {
  List<Map<String, dynamic>> familyDatesData = [];
  List<Widget> familyDateFields = [];
  List<TextEditingController> descriptionControllers = [];
  List<TextEditingController> dateControllers = [];

  @override
  void initState() {
    super.initState();
    loadProviderFamilyDatesData();
  }

  // Load data from the provider
  void loadProviderFamilyDatesData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userData = ref.watch(getDealerProfileProvider);

      userData.when(
        data: (data) {
          if (data != null &&
              data['data']['otherImportantFamilyDates'] != null) {
            setState(() {
              final familyDates = List<Map<String, dynamic>>.from(
                  data['data']['otherImportantFamilyDates']);

              familyDatesData = familyDates
                  .map((date) => {
                        "description": date['description'] ?? "",
                        "date": date['date'] != null
                            ? date['date'].split('T')[0]
                            : "",
                      })
                  .toList();

              // Populate the fields with the loaded data
              for (var date in familyDatesData) {
                addFamilyDateField(
                  description: date['description'],
                  date: date['date'],
                );
              }
            });
          }
        },
        loading: () {},
        error: (error, stackTrace) {},
      );
    });
  }

  // Modified addFamilyDateField to accept initial values
  void addFamilyDateField({String? description, String? date}) {
    setState(() {
      final descriptionController =
          TextEditingController(text: description ?? "");
      final dateController = TextEditingController(text: date ?? "");

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
            keyboardType: TextInputType.text, // For date
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
