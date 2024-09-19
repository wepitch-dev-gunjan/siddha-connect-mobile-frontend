import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/auth/screens/delar/family_info.dart';
import '../../../profile/screen/dealer/getDealer_profile.dart';
import '../../../salesDashboard/component/date_picker.dart';
import '../../../utils/fields.dart';
import '../../../utils/sizes.dart';
import 'wife_info.dart';


class OtherFamilyMemberInfo extends ConsumerStatefulWidget {
  const OtherFamilyMemberInfo({super.key});

  @override
  OtherFamilyMemberInfoState createState() => OtherFamilyMemberInfoState();
}

class OtherFamilyMemberInfoState extends ConsumerState<OtherFamilyMemberInfo> {
  List<Widget> familyMemberFields = [];
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> relationControllers = [];

  @override
  void initState() {
    super.initState();
    addFamilyMemberField();
  }

  void addFamilyMemberField() {
    setState(() {
      final nameController = TextEditingController();
      final relationController = TextEditingController();

      nameControllers.add(nameController);
      relationControllers.add(relationController);

      familyMemberFields.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightSizedBox(10.0),
          TxtField(
            contentPadding: contentPadding,
            labelText: "Name",
            maxLines: 1,
            keyboardType: TextInputType.text,
            controller: nameController,
          ),
          heightSizedBox(8.0),
          TxtField(
            contentPadding: contentPadding,
            labelText: "Relation",
            maxLines: 1,
            keyboardType: TextInputType.text,
            controller: relationController,
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
        const Text('Other Family Members',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ...familyMemberFields,
        heightSizedBox(8.0),
        AddMoreBtn(
          onTap: () {
            addFamilyMemberField();
          },
        ),
        heightSizedBox(8.0),
      ],
    );
  }
}

class UpdateOtherFamilyMemberInfo extends ConsumerStatefulWidget {
  const UpdateOtherFamilyMemberInfo({super.key});

  @override
  UpdateOtherFamilyMemberInfoState createState() => UpdateOtherFamilyMemberInfoState();
}

class UpdateOtherFamilyMemberInfoState extends ConsumerState<UpdateOtherFamilyMemberInfo> {
  List<Map<String, dynamic>> familyMembersData = [];
  List<Widget> familyMemberFields = [];
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> relationControllers = [];

  @override
  void initState() {
    super.initState();
    loadProviderFamilyData();
  }

  void loadProviderFamilyData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userData = ref.watch(getDealerProfileProvider);

      userData.when(
        data: (data) {
          if (data != null && data['data']['owner']['otherFamilyMembers'] != null) {
            setState(() {
              final familyMembers = List<Map<String, dynamic>>.from(data['data']['owner']['otherFamilyMembers']);
              familyMembersData = familyMembers
                  .map((member) => {
                        "name": member['name'] ?? "",
                        "relation": member['relation'] ?? "",
                      })
                  .toList();

              for (var member in familyMembersData) {
                addFamilyMemberField(
                  name: member['name'],
                  relation: member['relation'],
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

  // Modified addFamilyMemberField to accept initial values
  void addFamilyMemberField({String? name, String? relation}) {
    setState(() {
      final nameController = TextEditingController(text: name ?? "");
      final relationController = TextEditingController(text: relation ?? "");

      nameControllers.add(nameController);
      relationControllers.add(relationController);

      familyMemberFields.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightSizedBox(10.0),
          TxtField(
            contentPadding: contentPadding,
            labelText: "Name",
            maxLines: 1,
            keyboardType: TextInputType.text,
            controller: nameController,
          ),
          heightSizedBox(8.0),
          TxtField(
            contentPadding: contentPadding,
            labelText: "Relation",
            maxLines: 1,
            keyboardType: TextInputType.text,
            controller: relationController,
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
          'Other Family Members',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ...familyMemberFields,
        heightSizedBox(8.0),
        AddMoreBtn(
          onTap: () {
            addFamilyMemberField();
          },
        ),
        heightSizedBox(8.0),
      ],
    );
  }
}



// class OtherFamilyMemberInfo extends StatefulWidget {
//   const OtherFamilyMemberInfo({super.key});

//   @override
//   OtherFamilyMemberInfoState createState() => OtherFamilyMemberInfoState();
// }

// class OtherFamilyMemberInfoState extends State<OtherFamilyMemberInfo> {
//   List<Widget> familyMemberFields = [];
//   List<TextEditingController> nameControllers = [];
//   List<TextEditingController> relationControllers = [];

//   @override
//   void initState() {
//     super.initState();
//     addFamilyMemberField();
//   }

//   void addFamilyMemberField() {
//     setState(() {
//       final nameController = TextEditingController();
//       final relationController = TextEditingController();

//       nameControllers.add(nameController);
//       relationControllers.add(relationController);

//       familyMemberFields.add(Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           heightSizedBox(10.0),
//           TxtField(
//             contentPadding: contentPadding,
//             labelText: "Name",
//             maxLines: 1,
//             keyboardType: TextInputType.text,
//             controller: nameController,
//           ),
//           heightSizedBox(8.0),
//           TxtField(
//             contentPadding: contentPadding,
//             labelText: "Relation",
//             maxLines: 1,
//             keyboardType: TextInputType.text,
//             controller: relationController,
//           ),
//         ],
//       ));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Other Family Members',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//         ...familyMemberFields,
//         heightSizedBox(8.0),
//         AddMoreBtn(
//           onTap: () {
//             addFamilyMemberField();
//           },
//         ),
//         heightSizedBox(8.0),
//       ],
//     );
//   }
// }




class AnniversaryInfo extends StatelessWidget {
  final TextEditingController anniversaryDate;
  const AnniversaryInfo({
    super.key,
    required this.anniversaryDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Anniversary Information',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        heightSizedBox(10.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: " Shop Anniversary",
          maxLines: 1,
          controller: anniversaryDate,
          keyboardType: TextInputType.text,
          readOnly: true, // Prevent manual text input
          onTap: () async {
            final pickedDate = await selectDate(context);
            if (pickedDate != null) {
              anniversaryDate.text = formatDate(pickedDate);
            }
          },
        ),
      ],
    );
  }
}

class UpdateAnniversaryInfo extends StatelessWidget {
  const UpdateAnniversaryInfo({
    super.key,
    required this.anniversaryDate,
  });

  final TextEditingController anniversaryDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Anniversary Information',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        heightSizedBox(10.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: " Shop Anniversary",
          maxLines: 1,
          controller: anniversaryDate,
          keyboardType: TextInputType.text,
          readOnly: true, // Prevent manual text input
          onTap: () async {
            final pickedDate = await selectDate(context);
            if (pickedDate != null) {
              anniversaryDate.text = formatDate(pickedDate);
            }
          },
        ),
      ],
    );
  }
}
