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
      log('response$response');
      return response;
    } on DioException catch (e) {
      if (e.response?.data['message'] == 'User Already Exist') {
        ShowSnackBarMsg("User Already Register. Plese Login",
            color: Colors.red);
      } else {
        ShowSnackBarMsg("Something Went Wrong", color: Colors.red);
      }
    }
  }

  userLoginRepo({required Map data}) async {
    try {
      final response =
          await ApiMethod(url: ApiUrl.userLogin).postDioRequest(data: data);

      return response;
    } on DioException catch (e) {
      ShowSnackBarMsg("${e.response!.data['error']}", color: Colors.red);
    }
  }

  dealerRegisterRepo({required Map data}) async {
    try {
      final response = await ApiMethod(url: ApiUrl.dealerRegister)
          .postDioRequest(data: data);
      return response;
    } on DioException catch (e) {
      ShowSnackBarMsg("${e.response?.data['error']}", color: Colors.red);
      return null;
    }
  }
}
