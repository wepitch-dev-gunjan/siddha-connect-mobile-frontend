import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/attendence/attendence_screen.dart';
import 'package:siddha_connect/attendence/geotag.dart';
import 'package:siddha_connect/utils/message.dart';
import 'package:siddha_connect/utils/navigation.dart';

import '../../profile/screen/employeeProfile/employ_profile.dart';
import '../../utils/api_method.dart';

final attendenceRepoProvider =
    Provider.autoDispose((ref) => AttendenceRepo(ref: ref));

class AttendenceRepo {
  final Ref ref;
  AttendenceRepo({required this.ref});

  getGeoTagInfomation({String? dealerCode}) async {
    try {
      final response = await ApiMethod(
              url:
                  "${ApiUrl.getUpdatedGeoTagForEmployee}?dealerCode=$dealerCode")
          .getDioRequest();

      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  // dealerGeoTag({required Map data}) async {
  //   log("Data123====>>>>!!!!!!!!!$data");
  //   try {
  //     final response =
  //         await ApiMethod(url: ApiUrl.updateDealerGeoTagForEmployee)
  //             .putDioRequest(data: data);

  //     if (response['success'] == true) {
  //       showSnackBarMsg(response['message'], color: Colors.green);
  //     } else {
  //       showSnackBarMsg("Something went wrong");
  //     }

  //     log("Profile123456=====>>>>>>>$response");
  //     return response;
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  Future<void> dealerGeoTag({required Map<String, dynamic> data}) async {

    try {
      final String? imagePath = data['geotag_picture'];
      FormData formData = FormData.fromMap({
        ...data,
        if (imagePath != null && imagePath.isNotEmpty)
          'geotag_picture': await MultipartFile.fromFile(
            imagePath,
            filename:
                imagePath.split('/').last, // Use the file name from the path
          ),
      });

      ref.read(isImageLoadingProvider.notifier).state = true;
      final response =
          await ApiMethod(url: ApiUrl.updateDealerGeoTagForEmployee)
              .putDioFormData(data: formData);
      log("ImageUpload$response");
      // Handle response
      if (response['success'] == true) {
        ref.read(isImageLoadingProvider.notifier).state = false;
        ref.invalidate(imageProvider);
        navigatePushReplacement(const EmployProfile());
        showSnackBarMsg(response['message'], color: Colors.green);
      } else {
        showSnackBarMsg("Something went wrong");
      }
      return response;
    } catch (e) {
      log("Error: $e");
    }
  }
}
