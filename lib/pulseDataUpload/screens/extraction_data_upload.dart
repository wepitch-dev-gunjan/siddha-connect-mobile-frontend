import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/common_style.dart';
import '../../utils/cus_appbar.dart';
import '../components/floating_add_button.dart';
import '../components/table.dart';
import 'pulse_data_upload.dart';

final formVisibilityProvider = StateProvider<bool>((ref) => false);

class PulseDataUpload extends ConsumerStatefulWidget {
  const PulseDataUpload({super.key});

  @override
  ConsumerState<PulseDataUpload> createState() => _PulseDataUploadState();
}

class _PulseDataUploadState extends ConsumerState<PulseDataUpload> {
  late TextEditingController dealerCode;

  @override
  void initState() {
    super.initState();
    dealerCode = TextEditingController();
  }

  @override
  void dispose() {
    dealerCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFormVisible = ref.watch(formVisibilityProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopNames(),
              ShowTable(),
            ],
          ),
          if (isFormVisible)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  ref.read(formVisibilityProvider.notifier).state = false;
                },
                child: Container(
                  color: Colors.black54, // Background overlay
                  child: Center(child: DealerForm(dealerCode: dealerCode)),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: isFormVisible ? null : const AddButton(),
    );
  }
}



class AddButton extends ConsumerWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        ref.read(formVisibilityProvider.notifier).state = true;
      },
      shape: const CircleBorder(),
      backgroundColor: AppColor.primaryColor,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
