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
  AutoDisposeProviderRef<Object?> ref;
  final AuthRepo authRepo;

  AuthController({required this.authRepo, required this.ref});

  registerController({required Map data}) async {
    try {
      final res = await authRepo.userRegisterRepo(data: data);
      log("res$res");
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
    } catch (e) {}
  }

  userLogin({required Map data}) async {
    try {
      final res = await authRepo.userLoginRepo(data: data);
      log("RespLogin$res");
      if (res['message'] == 'User logged in successfully' &&
          res['verified'] == true) {
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
    } catch (e) {}
  }

  dealerRegisterController({required Map data}) async {
    try {
      final res = await authRepo.dealerRegisterRepo(data: data);
      log("resDealer$res");
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
      print('Error in dealerRegisterController: $e');
      throw e;
    }
  }
}
