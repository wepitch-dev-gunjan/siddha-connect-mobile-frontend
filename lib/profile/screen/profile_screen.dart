import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final userProfile = ref.watch(getProfileProvider);
    return const Scaffold(
      body: Column(children: [Center(child: Text("data"),)],),
    );
  }
}