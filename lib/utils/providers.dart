import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/profile/repo/profile_repo.dart';
import '../auth/repo/auth_repo.dart';
import '../salesDashboard/repo/sales_dashboard_repo.dart';




final getProfileProvider = FutureProvider.autoDispose((ref) async {
  final getProfile = await ref.watch(profileRepoProvider).getProfile();
  return getProfile;
});

// final getDealerProfileProvider = FutureProvider.autoDispose((ref) async {
//   final getDealerProfile = await ref.watch(authRepoProvider).isDealerVerified();
//   return getDealerProfile;
// });

final dealerRoleProvider = StateProvider.autoDispose<String?>((ref) => "");
final dealerCodeProvider = StateProvider.autoDispose<String?>((ref) => "");
final dealerNameProvider = StateProvider.autoDispose<String?>((ref) => "");

final userProvider =
    FutureProvider.autoDispose<Map<String, String>>((ref) async {
  final userdata = await ref.watch(profileStatusControllerProvider);
  final name = userdata['name'] as String;
  final position = userdata['role'] as String;
  return {'name': name, 'position': position};
});

final dealerProvider =
    FutureProvider.autoDispose<Map<String, String>>((ref) async {
  final dealerData = await ref.watch(isDealerVerifiedProvider);
  final name = dealerData['name'] as String;
  final role = dealerData['role'] as String;
  final code = dealerData['code'] as String;

  // Assign to StateProviders
  ref.read(dealerNameProvider.notifier).state = name;
  ref.read(dealerRoleProvider.notifier).state = role;
  ref.read(dealerCodeProvider.notifier).state = code;

  return {'name': name, 'role': role, 'code': code};
});

final subordinateProvider = FutureProvider.autoDispose((ref) async {
  final getSubordinate =
      await ref.watch(salesRepoProvider).getAllSubordinates();
  return getSubordinate;
});

final isDealerVerifiedProvider = StateProvider.autoDispose((ref) async {
  final getDealerVerified =
      await ref.watch(authRepoProvider).isDealerVerified();
  return getDealerVerified;
});
