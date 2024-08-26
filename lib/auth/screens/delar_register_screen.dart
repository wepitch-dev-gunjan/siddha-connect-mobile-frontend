import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/auth/controllers/auth_controller.dart';
import 'package:siddha_connect/auth/screens/delar/wife_info.dart';
import 'package:siddha_connect/utils/buttons.dart';
import 'delar/business_info.dart';
import 'delar/delar_info.dart';
import 'delar/family_info.dart';
import 'delar/other_family_dates.dart';
import 'delar/other_family_info.dart';
import 'delar/owner_info.dart';

class DelarRegisterScreen extends ConsumerWidget {
  DelarRegisterScreen({super.key});

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
    final familyInfoKey = GlobalKey<FamilyInfoState>();
    final otherFamilyInfoKey = GlobalKey<OtherFamilyMemberInfoState>();
    final otherImportantDatesKey = GlobalKey<OtherImportantFamilyDatesState>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Dealer Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                DelarInfo(
                  shopAddress: shopAddress,
                  delerCode: delarCode,
                  shopName: shopName,
                  shopArea: shopArea,
                ),
                OwnerInfo(
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
                BusinessInfo(
                  businessType: businessType,
                  businessYears: businessYears,
                  specialNotes: specialNotes,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Btn(
          btnName: "Register",
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
              ref.read(authControllerProvider).dealerRegisterController(data: {
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
