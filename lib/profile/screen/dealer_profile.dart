import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/profile/repo/profileRepo.dart';

import 'package:siddha_connect/utils/fields.dart';
import 'package:siddha_connect/utils/navigation.dart';
import 'package:siddha_connect/utils/sizes.dart';
import '../../utils/common_style.dart';
import '../../utils/drawer.dart';
import '../../utils/providers.dart';

final getDealerProfileProvider = FutureProvider.autoDispose((ref) async {
  final getDealerVerified =
      await ref.watch(profileRepoProvider).getDealerProfile();
  return getDealerVerified;
});

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dealer = ref.watch(dealerRoleProvider);
    final userData = dealer == "dealer"
        ? ref.watch(getDealerProfileProvider)
        : ref.watch(userProfileProvider);
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
            log("data$data");
            return SingleChildScrollView(
              child: Column(
                children: [
                  ClipOval(
                    child: Image.asset(
                      "assets/images/noImage.png",
                      height: 119,
                      width: 110,
                    ),
                  ),
                  Text(
                    data['data']['owner']['name'],
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                      fontSize: 22.sp,
                    )),
                  ),
                  GestureDetector(
                      onTap: () {
                        // navigateTo(EditDelarProfileScreen());
                      },
                      child: Text(
                        "Edit Profile",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff3300FF))),
                      )),
                  heightSizedBox(20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
                              text: data['data']['owner']['birthday']),
                          password: TextEditingController(),
                        ),
                        GetBusinessInfo(
                          businessType: TextEditingController(
                              text: data['data']['businessDetails']
                                  ['typeOfBusiness']),
                          businessYears: TextEditingController(
                              text: data['data']['businessDetails']
                                      ['yearsInBusiness']
                                  .toString()),
                        )
                      ],
                    ),
                  ),
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
          readOnly: true,
          contentPadding: contentPadding,
          labelText: "Dealer Code",
          maxLines: 1,
          controller: delerCode,
          keyboardType: TextInputType.text,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          readOnly: true,
          contentPadding: contentPadding,
          labelText: "Shop Name",
          maxLines: 1,
          controller: shopName,
          keyboardType: TextInputType.text,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          readOnly: true,
          contentPadding: contentPadding,
          labelText: "Shop Area",
          maxLines: 1,
          controller: shopArea,
          keyboardType: TextInputType.text,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          readOnly: true,
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
  final TextEditingController password;
  final TextEditingController homeAddress;
  final TextEditingController birthDay;

  const GetOwnerInfo(
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
          readOnly: true,
          controller: name,
          keyboardType: TextInputType.name,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Position",
          maxLines: 1,
          readOnly: true,
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
          readOnly: true,
          controller: contactNumber,
          keyboardType: TextInputType.number,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Email",
          maxLines: 1,
          readOnly: true,
          controller: email,
          keyboardType: TextInputType.emailAddress,
          validator: validateField,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Home Address",
          maxLines: 1,
          readOnly: true,
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
        ),
      ],
    );
  }
}

class GetBusinessInfo extends ConsumerWidget {
  final TextEditingController businessType;
  final TextEditingController businessYears;

  const GetBusinessInfo({
    super.key,
    required this.businessType,
    required this.businessYears,
  });

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
          controller: businessType,
        ),
        heightSizedBox(8.0),
        TxtField(
          contentPadding: contentPadding,
          labelText: "Years in Business",
          maxLines: 1,
          maxLength: 2,
          controller: businessYears,
        ),
      ],
    );
  }
}
