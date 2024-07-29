import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/auth/repo/auth_repo.dart';
import 'package:siddha_connect/salesDashboard/screen/sales_dashboard.dart';
import 'package:siddha_connect/utils/message.dart';
import 'package:siddha_connect/utils/navigation.dart';
import 'package:siddha_connect/utils/secure_storage.dart';
import 'package:siddha_connect/utils/status_screen.dart';

final authControllerProvider = Provider.autoDispose((ref) {
  final authRepo = ref.watch(authRepoProvider);

  return AuthController(authRepo: authRepo, ref: ref);
});

class AuthController {
  AutoDisposeProviderRef<Object?> ref;
  final AuthRepo authRepo;

  AuthController({required this.authRepo, required this.ref});

  registerController({required Map data}) async {
    try {
      final res = await authRepo.userRegisterRepo(data: data);
      if (res['user']['verified'] == true) {
        navigateTo(const SalesDashboard());
        ref
            .watch(secureStoargeProvider)
            .writeData(key: 'authToken', value: res['token']);
      } else {
        ref
            .watch(secureStoargeProvider)
            .writeData(key: 'authToken', value: res['token']);
        navigateTo( const StatusScreen());
      }

      return res;
    } catch (e) {}
  }

  userLogin({required Map data}) async {
    try {
      final res = await authRepo.userLoginRepo(data: data);
      if (res['message'] == 'User logged in successfully' &&
          res['verified'] == true) {
        ref
            .read(secureStoargeProvider)
            .writeData(key: 'authToken', value: "${res['token']}");
        navigateTo(const SalesDashboard());
      } else {
        ShowSnackBarMsg("You are not Verified User!", color: Colors.red);
      }
      return res;
    } catch (e) {}
  }
}
