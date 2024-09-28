import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/cus_appbar.dart';
import '../utils/drawer.dart';
import 'components/floating_add_button.dart';
import 'components/table.dart';

class UploadDailyReport extends ConsumerWidget {
  const UploadDailyReport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employData = ref.watch(userProfileProvider);
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopNames(),
          ShowTable(),
        ],
      ),
      floatingActionButton: AddButton(),
    );
  }
}
