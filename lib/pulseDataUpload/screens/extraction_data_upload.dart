import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/pulseDataUpload/screens/data_upload_form.dart';
import 'package:siddha_connect/utils/navigation.dart';
import '../../utils/common_style.dart';
import '../../utils/cus_appbar.dart';
import '../../utils/sizes.dart';
import '../components/floating_add_button.dart';
import '../components/table.dart';

class ExtractionDataScreen extends StatelessWidget {
  const ExtractionDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopNames(),
              heightSizedBox(10.0),
              const   Expanded(
                child: ShowTable(),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: const AddButton(),
    );
  }
}

class AddButton extends ConsumerWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        navigateTo(const UploadForm());
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
