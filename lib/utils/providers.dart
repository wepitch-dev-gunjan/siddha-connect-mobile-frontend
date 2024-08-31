import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/profile/repo/profileRepo.dart';
import '../auth/repo/auth_repo.dart';
import '../salesDashboard/repo/sales_dashboard_repo.dart';

final getProfileProvider = FutureProvider.autoDispose((ref) async {
  final getProfile = await ref.watch(profileRepoProvider).getProfile();
  return getProfile;
});

final userProvider =
    FutureProvider.autoDispose<Map<String, String>>((ref) async {
  final userdata = await ref.watch(profileStatusControllerProvider);
  final name = userdata['name'] as String;
  final position = userdata['role'] as String;
  return {'name': name, 'position': position};
});

final subordinateProvider = FutureProvider.autoDispose((ref) async {
  final user = await ref.watch(userProvider.future);
  final name = user['name']?.trim() ?? '';
  final position = user['position']?.trim() ?? '';

  log("name$name");
  log("position$position");

  final getSubordinate = await ref
      .watch(salesRepoProvider)
      .getAllSubordinates(name: name, position: position);
  return getSubordinate;
});




final isDealerVerifiedProvider = StateProvider.autoDispose((ref) async {
  final getDealerVerified =
      await ref.watch(authRepoProvider).isDealerVerified();
  return getDealerVerified;
});