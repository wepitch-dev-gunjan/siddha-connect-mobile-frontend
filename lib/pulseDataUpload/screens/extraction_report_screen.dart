import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repo/product_repo.dart';

final getExtractionReportForAdmin = FutureProvider.autoDispose((ref) async {
  final productRepo = ref.watch(productRepoProvider);
  final data = await productRepo.getExtractionReportForAdmin();
  ref.keepAlive();
  return data;
});

class ExtractionReport extends ConsumerWidget {
  const ExtractionReport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(getExtractionReportForAdmin);
    return Scaffold(
      body: data.when(
        data: (data) {
          return Column(
            children: [],
          );
        },
        error: (error, stackTrace) => const Center(
          child: Text("Something Went Wrong"),
        ),
        loading: () => const Center(
          child: SingleChildScrollView(),
        ),
      ),
    );
  }
}
