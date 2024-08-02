import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/utils/api_method.dart';
import 'package:siddha_connect/utils/secure_storage.dart';

final profileRepoProvider =
    Provider.autoDispose((ref) => ProfileRepo(ref: ref));

class ProfileRepo {
  final AutoDisposeProviderRef<Object?> ref;
  ProfileRepo({required this.ref});

  getProfile() async {
    try {
      final token =
          await ref.watch(secureStoargeProvider).readData('authToken');

      final response =
          await ApiMethod(url: ApiUrl.getProfile, token: token).getDioRequest();
      // final name = response['name'];
      // final email = response['email'];
      // final role = response['role'];
      // final userData = jsonEncode({'name': name, 'email': email, 'role': role});
      // await ref
      //     .watch(secureStoargeProvider)
      //     .writeData(key: 'userData', value: userData);

      return response;
    } catch (e) {}
  }
}

final profileStatusControllerProvider = StateProvider.autoDispose((ref) async {
  final getprofileStatus = await ref.watch(profileRepoProvider).getProfile();
  return getprofileStatus;
});

final getNameProvider = StateProvider.autoDispose((ref) async {
  final getprofileStatus = await ref.watch(profileRepoProvider).getProfile();
  return getprofileStatus['name'];
});

final getRoleProvider = StateProvider.autoDispose((ref) async {
  final getprofileStatus = await ref.watch(profileRepoProvider).getProfile();
  return getprofileStatus['role'];
});
