import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/profile/repo/profileRepo.dart';
import 'package:siddha_connect/utils/fields.dart';
import 'package:siddha_connect/utils/navigation.dart';
import 'package:siddha_connect/utils/sizes.dart';
import '../../../utils/common_style.dart';
import 'updateDealer_profile.dart';

final getDealerProfileProvider = FutureProvider.autoDispose((ref) async {
  final getDealerVerified =
      await ref.watch(profileRepoProvider).getDealerProfile();
  return getDealerVerified;
});

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(getDealerProfileProvider);

    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          foregroundColor: AppColor.whiteColor,
          backgroundColor: AppColor.primaryColor,
          titleSpacing: 0,
          centerTitle: false,
          title: SvgPicture.asset("assets/images/logo.svg"),
        ),
        body: userData.when(
          data: (data) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  heightSizedBox(10.0),
                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/images/profilepic.png"),
                  ),
                  Text(
                    data['data']['owner']['name'],
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                      fontSize: 22.sp,
                    )),
                  ),
                  heightSizedBox(10.0),
                  GestureDetector(
                    onTap: () {
                      navigateTo(DelarProfileEditScreen());
                    },
                    child: Container(
                        height: 30.h,
                        width: 130.w,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            "Edit Profile",
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white)),
                          ),
                        )),
                  ),
                  heightSizedBox(20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        DelarInfoGet(
                            delerCode: TextEditingController(
                                text: data['data']['dealerCode']),
                            shopName: TextEditingController(
                                text: data['data']['shopName']),
                            shopArea: TextEditingController(
                                text: data['data']['shopArea']),
                            shopAddress: TextEditingController(
                                text: data['data']['shopAddress'])),
                        GetOwnerInfo(
                          name: TextEditingController(
                              text: data['data']['owner']['name']),
                          position: TextEditingController(
                              text: data['data']['owner']['position']),
                          contactNumber: TextEditingController(
                              text: data['data']['owner']['contactNumber']),
                          email: TextEditingController(
                              text: data['data']['owner']['email']),
                          homeAddress: TextEditingController(
                              text: data['data']['owner']['homeAddress']),
                          birthDay: TextEditingController(
                              text: (data['data']['owner']['birthday'])
                                  .split('T')[0]),
                        ),
                        GetFamilyInfo(
                          wifeName: TextEditingController(
                              text: data['data']['owner']['wife']['name']),
                          wifeBirthday: TextEditingController(
                              text: (data['data']['owner']['wife']
                                          ['birthday'] !=
                                      null)
                                  ? data['data']['owner']['wife']['birthday']
                                      .split('T')[0]
                                  : ''),
                        ),
                        GetChildrensInfo(
                            children: data['data']['owner']['children']),
                        GetOtherFamilyMember(
                          familyMembers: data['data']['owner']
                              ['otherFamilyMembers'],
                        ),
                        GetOtherImportantDates(
                          importantDates: data['data']
                              ['otherImportantFamilyDates'],
                        ),
                        GetAnniversaryInfo(
                          shopAnniversary: TextEditingController(
                              text: (data['data']['anniversaryDate'] != null)
                                  ? data['data']['anniversaryDate']
                                      .split('T')[0]
                                  : ''),
                        ),
                        GetBusinessInfo(
                          businessType: TextEditingController(
                              text: data['data']['businessDetails']
                                  ['typeOfBusiness']),
                          businessYears: TextEditingController(
                              text: data['data']['businessDetails']
                                      ['yearsInBusiness']
                                  .toString()),
                          comunationController: TextEditingController(
                              text: data['data']['businessDetails']
                                  ['preferredCommunicationMethod']),
                          specialNotes: TextEditingController(
                              text: data['data']['specialNotes']),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          error: (error, stackTrace) => const Text("Something went wrong"),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}

class DelarInfoGet extends StatelessWidget {
  final TextEditingController delerCode;
  final TextEditingController shopName;
  final TextEditingController shopArea;
  final TextEditingController shopAddress;

  const DelarInfoGet({
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
          enabled: false,
          contentPadding: contentPadding,
          labelText: "Dealer Code",
          maxLines: 1,
          controller: delerCode,
          keyboardType: TextInputType.text,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          enabled: false,
          contentPadding: contentPadding,
          labelText: "Shop Name",
          maxLines: 1,
          controller: shopName,
          keyboardType: TextInputType.text,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          enabled: false,
          contentPadding: contentPadding,
          labelText: "Shop Area",
          maxLines: 1,
          controller: shopArea,
          keyboardType: TextInputType.text,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          enabled: false,
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

class GetOwnerInfo extends ConsumerWidget {
  final TextEditingController name;
  final TextEditingController position;
  final TextEditingController contactNumber;
  final TextEditingController email;
  final TextEditingController homeAddress;
  final TextEditingController birthDay;

  const GetOwnerInfo({
    super.key,
    required this.name,
    required this.position,
    required this.contactNumber,
    required this.email,
    required this.homeAddress,
    required this.birthDay,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          enabled: false,
          controller: name,
          keyboardType: TextInputType.name,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Position",
          maxLines: 1,
          enabled: false,
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
          enabled: false,
          controller: contactNumber,
          keyboardType: TextInputType.number,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Email",
          maxLines: 1,
          enabled: false,
          controller: email,
          keyboardType: TextInputType.emailAddress,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Home Address",
          maxLines: 1,
          enabled: false,
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
          enabled: false,
        ),
      ],
    );
  }
}

class GetFamilyInfo extends ConsumerWidget {
  final TextEditingController wifeName;
  final TextEditingController wifeBirthday;

  const GetFamilyInfo({
    super.key,
    required this.wifeName,
    required this.wifeBirthday,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Family Info',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        heightSizedBox(10.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Wife's Name",
          maxLines: 1,
          controller: wifeName,
          enabled: false,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Wife's Birthday",
          maxLines: 1,
          maxLength: 2,
          controller: wifeBirthday,
          enabled: false,
        ),
      ],
    );
  }
}

class GetBusinessInfo extends ConsumerWidget {
  final TextEditingController businessType;
  final TextEditingController businessYears;
  final TextEditingController comunationController;
  final TextEditingController specialNotes;
  const GetBusinessInfo(
      {super.key,
      required this.businessType,
      required this.businessYears,
      required this.comunationController,
      required this.specialNotes});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          enabled: false,
          controller: businessType,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Years in Business",
          maxLines: 1,
          enabled: false,
          maxLength: 2,
          controller: businessYears,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Comunation Method",
          maxLines: 1,
          enabled: false,
          maxLength: 2,
          controller: comunationController,
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
          enabled: false,
          keyboardType: TextInputType.text,
          controller: specialNotes,
        ),
      ],
    );
  }
}

class GetChildrensInfo extends ConsumerWidget {
  final List<dynamic> children;

  const GetChildrensInfo({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return children.isEmpty
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Childrens',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              heightSizedBox(10.0),
              ...children.map((child) {
                // Create a TextEditingController for each child
                final nameController =
                    TextEditingController(text: child['name']);
                final ageController =
                    TextEditingController(text: child['age'].toString());
                final birthDayController = TextEditingController(
                  text: child['birthday'] != null
                      ? (child['birthday'] as String).split('T')[0]
                      : '',
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TxtField(
                      contentPadding: contentPadding,
                      labelText: "Name",
                      maxLines: 1,
                      enabled: false,
                      controller: nameController,
                    ),
                    heightSizedBox(8.0),
                    TxtField(
                      contentPadding: contentPadding,
                      labelText: "Age",
                      maxLines: 1,
                      enabled: false,
                      controller: ageController,
                    ),
                    heightSizedBox(8.0),
                    TxtField(
                      contentPadding: contentPadding,
                      labelText: "Birthday",
                      maxLines: 1,
                      enabled: false,
                      controller: birthDayController,
                    ),
                    heightSizedBox(10.0),
                  ],
                );
              }).toList(),
            ],
          );
  }
}

class GetOtherFamilyMember extends ConsumerWidget {
  final List<dynamic> familyMembers;

  const GetOtherFamilyMember({
    super.key,
    required this.familyMembers,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return familyMembers.isEmpty
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Other Family Members',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              heightSizedBox(10.0),
              ...familyMembers.map((child) {
                // Create a TextEditingController for each child
                final nameController =
                    TextEditingController(text: child['name']);
                final relationController =
                    TextEditingController(text: child['relation'].toString());

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TxtField(
                      contentPadding: contentPadding,
                      labelText: "Name",
                      maxLines: 1,
                      enabled: false,
                      controller: nameController,
                    ),
                    heightSizedBox(8.0),
                    TxtField(
                      contentPadding: contentPadding,
                      labelText: "Relation",
                      maxLines: 1,
                      enabled: false,
                      controller: relationController,
                    ),
                    heightSizedBox(8.0),
                  ],
                );
              }).toList(),
            ],
          );
  }
}

class GetOtherImportantDates extends ConsumerWidget {
  final List<dynamic> importantDates;

  const GetOtherImportantDates({
    super.key,
    required this.importantDates,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return importantDates.isEmpty
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Other Important Family Dates',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              heightSizedBox(10.0),
              ...importantDates.map((child) {
                String formattedDate = child['date'] != null
                    ? (child['date'] as String).split('T')[0]
                    : '';

                final descriptionController =
                    TextEditingController(text: child['description']);
                final dateController =
                    TextEditingController(text: formattedDate);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TxtField(
                      contentPadding: contentPadding,
                      labelText: "Description",
                      maxLines: 1,
                      enabled: false,
                      controller: descriptionController,
                    ),
                    heightSizedBox(8.0),
                    TxtField(
                      contentPadding: contentPadding,
                      labelText: "Date",
                      maxLines: 1,
                      enabled: false,
                      controller: dateController,
                    ),
                    heightSizedBox(8.0),
                  ],
                );
              }).toList(),
            ],
          );
  }
}

class GetAnniversaryInfo extends ConsumerWidget {
  final TextEditingController shopAnniversary;

  const GetAnniversaryInfo({
    super.key,
    required this.shopAnniversary,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          labelText: "Shop Anniversary",
          maxLines: 1,
          enabled: false,
          controller: shopAnniversary,
          keyboardType: TextInputType.name,
          validator: validateField,
        ),
      ],
    );
  }
}
