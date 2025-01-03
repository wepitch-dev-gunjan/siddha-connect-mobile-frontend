import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/auth/repo/auth_repo.dart';
import 'package:siddha_connect/salesDashboard/screen/sales_dashboard.dart';
import 'package:siddha_connect/utils/navigation.dart';
import 'package:siddha_connect/utils/secure_storage.dart';
import 'package:siddha_connect/auth/screens/status_screen.dart';

final authControllerProvider = Provider.autoDispose((ref) {
  final authRepo = ref.watch(authRepoProvider);

  return AuthController(authRepo: authRepo, ref: ref);
});

class AuthController {
  final Ref ref;
  final AuthRepo authRepo;

  AuthController({required this.authRepo, required this.ref});

  registerController({required Map data}) async {
    try {
      final res = await authRepo.userRegisterRepo(data: data);
      if (res['user']['verified'] == false) {
        ref
            .watch(secureStoargeProvider)
            .writeData(key: 'authToken', value: res['token']);
        navigateTo(const StatusScreen());
      } else {
        ref
            .watch(secureStoargeProvider)
            .writeData(key: 'authToken', value: res['token']);
        navigateTo(const SalesDashboard());
      }
      return res;
    } catch (e) {
      log(e.toString());
    }
  }

  userLogin({required Map data}) async {
    try {
      final res = await authRepo.userLoginRepo(data: data);
      if (res['message'] == 'User logged in successfully' &&
          res['verified'] == true) {
        log("Token=====${res['token']}");
        await ref
            .read(secureStoargeProvider)
            .writeData(key: 'authToken', value: "${res['token']}");

        navigateTo(const SalesDashboard());
      } else {
        await ref
            .read(secureStoargeProvider)
            .writeData(key: 'authToken', value: "${res['token']}");
        navigateTo(const StatusScreen());
      }
      return res;
    } catch (e) {
      log(e.toString());
    }
  }

  dealerRegisterController({required Map data}) async {
    try {
      final res = await authRepo.dealerRegisterRepo(data: data);
      if (res['data']['verified'] == false) {
        await ref
            .read(secureStoargeProvider)
            .writeData(key: 'authToken', value: "${res['token']}");
        navigatePushReplacement(const StatusScreen());
        return res;
      } else {
        navigatePushReplacement(const SalesDashboard());
      }
      return res;
    } catch (e) {
      log(e.toString());
    }
  }
}
