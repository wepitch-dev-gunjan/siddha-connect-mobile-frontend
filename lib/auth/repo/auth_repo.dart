import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/utils/api_method.dart';
import 'package:siddha_connect/utils/message.dart';

final authRepoProvider = Provider.autoDispose((ref) => AuthRepo(ref));

class AuthRepo {
  final AutoDisposeProviderRef<Object?> ref;
  AuthRepo(this.ref);

  userRegisterRepo({required Map data}) async {
    try {
      final response =
          await ApiMethod(url: ApiUrl.userRegister).postDioRequest(data: data);
      return response;
    } catch (e) {}
  }

  userLoginRepo({required Map data}) async {
    try {
      final response =
          await ApiMethod(url: ApiUrl.userLogin).postDioRequest(data: data);

      if (response['error'] == "Invalid credentials") {
        ShowSnackBarMsg(response['error'], color: Colors.red);
      }
      return response;
    } on DioException catch (e) {
      ShowSnackBarMsg("${e.response!.data['error']}", color: Colors.red);
    }
  }
}
