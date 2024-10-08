import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/profile/repo/profile_repo.dart';
import 'package:siddha_connect/profile/screen/dealerProfile/get_dealer_profile.dart';
import 'package:siddha_connect/utils/message.dart';
import 'package:siddha_connect/utils/navigation.dart';

final profileControllerProvider = Provider.autoDispose((ref) {
  final profileRepo = ref.watch(profileRepoProvider);

  return ProfileController(profileRepo: profileRepo, ref: ref);
});

class ProfileController {
  AutoDisposeProviderRef<Object?> ref;
  final ProfileRepo profileRepo;

  ProfileController({required this.profileRepo, required this.ref});

  dealerProfileUpdateController({required Map data}) async {
    try {
      final res = await profileRepo.dealerProfileUpdateRepo(data: data);
      if (res['message'] == "Dealer profile updated successfully.") {
       var refreshdData= ref.refresh(getDealerProfileProvider);
        navigatePushReplacement(const ProfileScreen());
        showSnackBarMsg("${res['message']}", color: Colors.green);
      }
      return res;
    } catch (e) {
      log('Error in dealerRegisterController: $e');
    }
  }
}
