import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/utils/api_method.dart';
import 'package:siddha_connect/utils/secure_storage.dart';
import '../../utils/message.dart';

final profileRepoProvider =
    Provider.autoDispose((ref) => ProfileRepo(ref: ref));

class ProfileRepo {
  final Ref ref;
  ProfileRepo({required this.ref});

  getProfile() async {
    try {
      final token = await ref.read(secureStoargeProvider).readData('authToken');

      final response =
          await ApiMethod(url: ApiUrl.getProfile, token: token).getDioRequest();

      // log("Profile=====>>>>>>>$response");
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  getDealerProfile() async {
    try {
      final token = await ref.read(secureStoargeProvider).readData('authToken');

      final response =
          await ApiMethod(url: ApiUrl.getDealerProfile, token: "Bearer $token")
              .getDioRequest();

      // log("Profile=====>>>>>>>$response");
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  dealerProfileUpdateRepo({required Map data}) async {
    try {
      final token = await ref.read(secureStoargeProvider).readData('authToken');
      final response = await ApiMethod(
              url: ApiUrl.dealerProfileUpdate, token: "Bearer $token")
          .putDioRequest(data: data);
      // log("profileUpdateData$response");
      return response;
    } on DioException catch (e) {
      showSnackBarMsg("${e.response?.data['error']}", color: Colors.red);
      return null;
    }
  }
}

final profileStatusControllerProvider = StateProvider.autoDispose((ref) async {
  final getprofileStatus = await ref.watch(profileRepoProvider).getProfile();
  return getprofileStatus;
});
