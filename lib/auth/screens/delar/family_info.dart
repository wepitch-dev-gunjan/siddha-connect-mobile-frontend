import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/auth/screens/delar/wife_info.dart';
import 'package:siddha_connect/utils/common_style.dart';
import '../../../profile/screen/dealerProfile/get_dealer_profile.dart';
import '../../../salesDashboard/component/date_picker.dart';
import '../../../utils/fields.dart';
import '../../../utils/sizes.dart';

class UpdateFamilyInfo extends ConsumerStatefulWidget {
  const UpdateFamilyInfo({super.key});

  @override
  UpdateFamilyInfoState createState() => UpdateFamilyInfoState();
}

class UpdateFamilyInfoState extends ConsumerState<UpdateFamilyInfo> {
  List<Map<String, dynamic>> childrenData = [];
  List<Widget> childrenFields = [];
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> ageControllers = [];
  List<TextEditingController> birthdayControllers = [];

  @override
  void initState() {
    super.initState();
    loadProviderChildrenData();
  }

  void loadProviderChildrenData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userData = ref.watch(getDealerProfileProvider);

      userData.when(
        data: (data) {
          setState(() {
            final children = data?['data']['owner']['children'];
            if (children != null && children.isNotEmpty) {
              childrenData = List<Map<String, dynamic>>.from(children)
                  .map((child) => {
                        "name": child['name'] ?? "",
                        "age": child['age']?.toString() ?? "",
                        "birthday": child['birthday'] != null
                            ? child['birthday'].split('T')[0]
                            : "",
                      })
                  .toList();

              for (var child in childrenData) {
                addChildField(
                  name: child['name'],
                  age: child['age'],
                  birthday: child['birthday'],
                );
              }
            } else {
              // Add a default field if children data is empty
              addChildField();
            }
          });
        },
        loading: () {},
        error: (error, stackTrace) {},
      );
    });
  }

  // Modified addChildField to accept initial values
  void addChildField({String? name, String? age, String? birthday}) {
    setState(() {
      final nameController = TextEditingController(text: name ?? "");
      final ageController = TextEditingController(text: age ?? "");
      final birthdayController = TextEditingController(text: birthday ?? "");

      nameControllers.add(nameController);
      ageControllers.add(ageController);
      birthdayControllers.add(birthdayController);

      childrenFields.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightSizedBox(10.0),
          TxtField(
            contentPadding: contentPadding,
            labelText: "Name",
            maxLines: 1,
            keyboardType: TextInputType.name,
            controller: nameController,
          ),
          heightSizedBox(8.0),
          TxtField(
            contentPadding: contentPadding,
            labelText: "Age",
            maxLines: 1,
            maxLength: 2,
            keyboardType: TextInputType.number,
            controller: ageController,
          ),
          heightSizedBox(8.0),
          TxtField(
            contentPadding: contentPadding,
            labelText: "Birthday",
            maxLines: 1,
            keyboardType: TextInputType.text,
            controller: birthdayController,
            readOnly: true, // Prevent manual text input
            onTap: () async {
              final pickedDate = await selectDate(context);
              if (pickedDate != null) {
                setState(() {
                  birthdayController.text = formatDate(pickedDate);
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
          'Children',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ...childrenFields,
        heightSizedBox(8.0),
        AddMoreBtn(
          onTap: () {
            addChildField();
          },
        ),
        heightSizedBox(8.0),
      ],
    );
  }
}

class FamilyInfo extends StatefulWidget {
  const FamilyInfo({super.key});

  @override
  FamilyInfoState createState() => FamilyInfoState();
}

class FamilyInfoState extends State<FamilyInfo> {
  List<Widget> childrenFields = [];
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> ageControllers = [];
  List<TextEditingController> birthdayControllers = [];

  @override
  void initState() {
    super.initState();
    addChildField();
  }

  void addChildField() {
    setState(() {
      final nameController = TextEditingController();
      final ageController = TextEditingController();
      final birthdayController = TextEditingController();

      nameControllers.add(nameController);
      ageControllers.add(ageController);
      birthdayControllers.add(birthdayController);

      childrenFields.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightSizedBox(10.0),
          TxtField(
            contentPadding: contentPadding,
            labelText: "Name",
            maxLines: 1,
            keyboardType: TextInputType.name,
            controller: nameController,
          ),
          heightSizedBox(8.0),
          TxtField(
            contentPadding: contentPadding,
            labelText: "Age",
            maxLines: 1,
            maxLength: 2,
            keyboardType: TextInputType.number,
            controller: ageController,
          ),
          heightSizedBox(8.0),
          TxtField(
            contentPadding: contentPadding,
            labelText: "Birthday",
            maxLines: 1,
            keyboardType: TextInputType.text,
            controller: birthdayController,
            readOnly: true, // Prevent manual text input
            onTap: () async {
              final pickedDate = await selectDate(context);
              if (pickedDate != null) {
                setState(() {
                  birthdayController.text = formatDate(pickedDate);
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
          'Children',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ...childrenFields,
        heightSizedBox(8.0),
        AddMoreBtn(
          onTap: () {
            addChildField();
          },
        ),
        heightSizedBox(8.0),
      ],
    );
  }
}

class AddMoreBtn extends StatelessWidget {
  final Function()? onTap;
  const AddMoreBtn({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 100,
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(21),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  size: 20,
                  color: AppColor.whiteColor,
                ),
                Text(
                  "Add More",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          )),
    );
  }
}
