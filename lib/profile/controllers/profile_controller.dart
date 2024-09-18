import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/profile/repo/profileRepo.dart';

import '../../auth/repo/auth_repo.dart';
import '../../utils/secure_storage.dart';

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

      if (res['data']['verified'] == false) {
        await ref
            .read(secureStoargeProvider)
            .writeData(key: 'authToken', value: "${res['token']}");
        // navigatePushReplacement(const StatusScreen());
        return res;
      } else {
        // navigatePushReplacement(const SalesDashboard());
      }

      return res;
    } catch (e) {
      print('Error in dealerRegisterController: $e');
      throw e;
    }
  }
}
