import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/profile/controllers/profile_controller.dart';
import '../../../auth/screens/delar/business_info.dart';
import '../../../auth/screens/delar/family_info.dart';
import '../../../auth/screens/delar/other_family_dates.dart';
import '../../../auth/screens/delar/other_family_info.dart';
import '../../../auth/screens/delar/owner_info.dart';
import '../../../auth/screens/delar/wife_info.dart';
import '../../../salesDashboard/component/date_picker.dart';
import '../../../utils/buttons.dart';
import '../../../utils/fields.dart';
import '../../../utils/sizes.dart';
import 'getDealer_profile.dart';

class DelarProfileEditScreen extends ConsumerWidget {
  DelarProfileEditScreen({super.key});
  final TextEditingController delarCode = TextEditingController();
  final TextEditingController shopName = TextEditingController();
  final TextEditingController shopArea = TextEditingController();
  final TextEditingController shopAddress = TextEditingController();
  final TextEditingController ownerName = TextEditingController();
  final TextEditingController ownerPosition = TextEditingController();
  final TextEditingController ownerContactNumber = TextEditingController();
  final TextEditingController ownerEmail = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController ownerHomeAddress = TextEditingController();
  final TextEditingController ownerBirthDay = TextEditingController();
  final TextEditingController wifeName = TextEditingController();
  final TextEditingController wifeBirthDay = TextEditingController();
  final TextEditingController anniversaryDate = TextEditingController();
  final TextEditingController businessType = TextEditingController();
  final TextEditingController businessYears = TextEditingController();
  final TextEditingController specialNotes = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(getDealerProfileProvider);
    final familyInfoKey = GlobalKey<FamilyInfoState>();
    final otherFamilyInfoKey = GlobalKey<OtherFamilyMemberInfoState>();
    final otherImportantDatesKey = GlobalKey<OtherImportantFamilyDatesState>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Edit Profile"),
      ),
      body: userData.when(
        data: (data) {
          delarCode.text = data['data']['dealerCode'] ?? '';
          shopName.text = data['data']['shopName'] ?? '';
          shopArea.text = data['data']['shopArea'] ?? '';
          shopAddress.text = data['data']['shopAddress'] ?? '';
          ownerName.text = data['data']['owner']['name'] ?? '';
          ownerPosition.text = data['data']['owner']['position'] ?? '';
          ownerContactNumber.text =
              data['data']['owner']['contactNumber'] ?? '';
          ownerEmail.text = data['data']['owner']['email'] ?? '';
          ownerHomeAddress.text = data['data']['owner']['homeAddress'] ?? '';
          ownerBirthDay.text = data['data']['owner']['birthday'] ?? '';
          wifeName.text = data['data']['owner']['wife']['name'] ?? '';
          wifeBirthDay.text = data['data']['owner']['wife']['birthday'] ?? '';

          anniversaryDate.text = data['anniversaryDate'] ?? '';
          businessType.text =
              data['data']['businessDetails']['typeOfBusiness'] ?? '';
          businessYears.text =
              data['data']['businessDetails']['yearsInBusiness'].toString() ??
                  '';
          specialNotes.text = data['data']['specialNotes'] ?? '';
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    UpdateDelarInfo(
                      shopAddress: shopAddress,
                      delerCode: delarCode,
                      shopName: shopName,
                      shopArea: shopArea,
                    ),
                    UpdateOwnerInfo(
                      name: ownerName,
                      position: ownerPosition,
                      contactNumber: ownerContactNumber,
                      email: ownerEmail,
                      homeAddress: ownerHomeAddress,
                      birthDay: ownerBirthDay,
                      password: password,
                    ),
                    WifeInfo(
                      wifeName: wifeName,
                      wifeBirthday: wifeBirthDay,
                    ),
                    FamilyInfo(
                      key: familyInfoKey,
                    ),
                    OtherFamilyMemberInfo(
                      key: otherFamilyInfoKey,
                    ),
                    OtherImportantFamilyDates(
                      key: otherImportantDatesKey,
                    ),
                    AnniversaryInfo(
                      anniversaryDate: anniversaryDate,
                    ),
                    UpdateBusinessInfo(
                      businessType: businessType,
                      businessYears: businessYears,
                      specialNotes: specialNotes,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        error: (error, stackTrace) => const Text("Something went wrong"),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Btn(
          btnName: "Update Profile",
          onPressed: () {
            final preferredCommunicationMethod =
                ref.read(preferredCommunicationProvider);

            final childrenData = List.generate(
              familyInfoKey.currentState!.nameControllers.length,
              (index) {
                final ageText = familyInfoKey
                    .currentState!.ageControllers[index].text
                    .trim();
                final age = ageText.isNotEmpty ? int.tryParse(ageText) : null;

                final birthdayText = familyInfoKey
                    .currentState!.birthdayControllers[index].text
                    .trim();
                final birthday = birthdayText.isNotEmpty ? birthdayText : "";

                return {
                  "name": familyInfoKey
                      .currentState!.nameControllers[index].text
                      .trim(),
                  "age": age,
                  "birthday": birthday,
                };
              },
            );

            final otherFamilyMembersData = List.generate(
              otherFamilyInfoKey.currentState!.nameControllers.length,
              (index) => {
                "name": otherFamilyInfoKey
                    .currentState!.nameControllers[index].text
                    .trim(),
                "relation": otherFamilyInfoKey
                    .currentState!.relationControllers[index].text
                    .trim(),
              },
            );

            final businessYearsText = businessYears.text.trim();
            final yearsInBusiness = businessYearsText.isNotEmpty
                ? int.tryParse(businessYearsText)
                : null;

            final otherImportantFamilyDates = List.generate(
              otherImportantDatesKey
                  .currentState!.descriptionControllers.length,
              (index) {
                final description = otherImportantDatesKey
                    .currentState!.descriptionControllers[index].text
                    .trim();
                final dateText = otherImportantDatesKey
                    .currentState!.dateControllers[index].text
                    .trim();
                final date = dateText.isNotEmpty ? dateText : "";

                return {
                  "description": description,
                  "date": date,
                };
              },
            );

            if (formKey.currentState!.validate()) {
              ref
                  .read(profileControllerProvider)
                  .dealerProfileUpdateController(data: {
                "dealerCode": delarCode.text.trim().isNotEmpty
                    ? delarCode.text.trim()
                    : "",
                "shopName":
                    shopName.text.trim().isNotEmpty ? shopName.text.trim() : "",
                "shopArea":
                    shopArea.text.trim().isNotEmpty ? shopArea.text.trim() : "",
                "shopAddress": shopAddress.text.trim().isNotEmpty
                    ? shopAddress.text.trim()
                    : "",
                "owner": {
                  "name": ownerName.text.trim().isNotEmpty
                      ? ownerName.text.trim()
                      : "",
                  "position": ownerPosition.text.trim().isNotEmpty
                      ? ownerPosition.text.trim()
                      : "",
                  "contactNumber": ownerContactNumber.text.trim().isNotEmpty
                      ? ownerContactNumber.text.trim()
                      : "",
                  "email": ownerEmail.text.trim().isNotEmpty
                      ? ownerEmail.text.trim()
                      : "",
                  "homeAddress": ownerHomeAddress.text.trim().isNotEmpty
                      ? ownerHomeAddress.text.trim()
                      : "",
                  "birthday": ownerBirthDay.text.trim().isNotEmpty
                      ? ownerBirthDay.text.trim()
                      : "",
                  "wife": {
                    "name": wifeName.text.trim().isNotEmpty
                        ? wifeName.text.trim()
                        : "",
                    "birthday": wifeBirthDay.text.trim().isNotEmpty
                        ? wifeBirthDay.text.trim()
                        : "",
                  },
                  "children": childrenData,
                  "otherFamilyMembers": otherFamilyMembersData,
                },
                "anniversaryDate": anniversaryDate.text.trim().isNotEmpty
                    ? anniversaryDate.text.trim()
                    : "",
                "otherImportantFamilyDates": otherImportantFamilyDates,
                "businessDetails": {
                  "typeOfBusiness": businessType.text.trim().isNotEmpty
                      ? businessType.text.trim()
                      : "",
                  "yearsInBusiness": yearsInBusiness,
                  "preferredCommunicationMethod": preferredCommunicationMethod,
                },
                "password": password.text,
                "specialNotes": specialNotes.text.trim().isNotEmpty
                    ? specialNotes.text.trim()
                    : "",
              });
            }
          },
        ),
      ),
    );
  }
}

class UpdateDelarInfo extends StatelessWidget {
  final TextEditingController delerCode;
  final TextEditingController shopName;
  final TextEditingController shopArea;
  final TextEditingController shopAddress;
  const UpdateDelarInfo({
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
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Shop Name",
          maxLines: 1,
          controller: shopName,
          keyboardType: TextInputType.text,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Shop Area",
          maxLines: 1,
          controller: shopArea,
          keyboardType: TextInputType.text,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Shop Address",
          maxLines: 1,
          controller: shopAddress,
          keyboardType: TextInputType.streetAddress,
        ),
      ],
    );
  }
}

final birthDateProvider = StateProvider<DateTime?>((ref) => null);

class UpdateOwnerInfo extends ConsumerWidget {
  final TextEditingController name;
  final TextEditingController position;
  final TextEditingController contactNumber;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController homeAddress;
  final TextEditingController birthDay;

  const UpdateOwnerInfo(
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
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Position",
          maxLines: 1,
          controller: position,
          keyboardType: TextInputType.text,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Contact Number",
          maxLines: 1,
          maxLength: 10,
          controller: contactNumber,
          keyboardType: TextInputType.number,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Email",
          maxLines: 1,
          controller: email,
          keyboardType: TextInputType.emailAddress,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Home Address",
          maxLines: 1,
          controller: homeAddress,
          keyboardType: TextInputType.streetAddress,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Birthday",
          maxLines: 1,
          controller: birthDay,
          keyboardType: TextInputType.text,
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
