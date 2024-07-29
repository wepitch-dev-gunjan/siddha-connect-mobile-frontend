import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/auth/repo/auth_repo.dart';

final authControllerProvider = Provider.autoDispose((ref) {
  final authRepo = ref.watch(authRepoProvider);

  return AuthController(authRepo: authRepo, ref: ref);
});

class AuthController {
  AutoDisposeProviderRef<Object?> ref;
  final AuthRepo authRepo;

  AuthController({required this.authRepo, required this.ref});

  registerController({required Map data}) async {
    final res = await authRepo.userRegisterRepo(data: data);
    return res;
  }

  userLogin({required Map data}) async {
    try {
      final res = await authRepo.userLoginRepo(data: data);
      return res;
    } catch (e) {}
  }
}
