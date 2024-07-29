import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/uploadSalesData/repo/upload_data_repo.dart';
import 'package:siddha_connect/utils/buttons.dart';
import 'package:siddha_connect/utils/common_style.dart';
import 'package:siddha_connect/utils/navigation.dart';
import 'package:siddha_connect/utils/sizes.dart';
import '../salesDashboard/screen/sales_dashboard.dart';
import '../utils/cus_appbar.dart';
import '../utils/drawer.dart';

final fileNameProvider = StateProvider.autoDispose<String?>((ref) => null);
final filePathProvider = StateProvider<String?>((ref) => null);
final isLoadingProvider = StateProvider<bool>((ref) => false);
final isCancelRequestedProvider = StateProvider<bool>((ref) => false);

class UploadSalesData extends ConsumerWidget {
  const UploadSalesData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: const CustomAppBar(),
      drawer: const CusDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              UploadContainer(isLoading: isLoading),
              heightSizedBox(30.0),
              Btn(
                btnName: "Upload",
                onPressed: () async {
                  final filePath = ref.read(filePathProvider);
                  if (filePath != null) {
                    ref.read(isLoadingProvider.notifier).state = true;
                    try {
                      await ref
                          .read(SalesDataUploadRepoProvider)
                          .salesDataUpload(
                            file: File(filePath),
                          );
                      if (!ref.read(isCancelRequestedProvider)) {
                       
                        // navigatePushReplacement(SalesDashboard());
                      }
                    } catch (e) {
                      // Handle the error
                    } finally {
                      ref.read(isLoadingProvider.notifier).state = false;
                      ref.read(filePathProvider.notifier).state = null;
                      ref.read(fileNameProvider.notifier).state = null;
                    }
                  } else {
                    showErrorDialog(
                      message: 'No file selected. Please upload a .csv file.',
                      context: context,
                    );
                  }
                },
              ),
              heightSizedBox(10.0),
              Text(
                "OR",
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff7F7F7F),
                  ),
                ),
              ),
              heightSizedBox(10.0),
              OutlinedBtn(
                btnName: "Cancel",
                onPressed: () {
                  if (!isLoading) {
                    navigatePushReplacement(const SalesDashboard());
                  } else {
                    ref.read(isCancelRequestedProvider.notifier).state = true;
                    ref.read(isLoadingProvider.notifier).state = false;
                    // Navigator.pop(context);
                  }
                },
              ),
              heightSizedBox(20.0),
              const Divider(indent: 50.0, endIndent: 50.0)
            ],
          ),
        ),
      ),
    );
  }
}

class UploadContainer extends ConsumerWidget {
  final bool isLoading;
  const UploadContainer({
    super.key,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileName = ref.watch(fileNameProvider);
    return Column(
      children: [
        heightSizedBox(50.0),
        InkWell(
          onTap: () {
            pickFile(context, ref);
          },
          child: Container(
            height: 130.h,
            width: 350.w,
            decoration: BoxDecoration(
                color: const Color(0xffF7F7F7),
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.circular(15.0)),
            child: Center(
              child: Container(
                height: 64.h,
                width: 230.w,
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    border: Border.all(width: 0.2),
                    borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      fileName ?? "Upload CSV Sales Data File",
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          color: Color(0xff9F9D9D),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    heightSizedBox(5.0),
                    SvgPicture.asset(
                      'assets/images/uploadBold.svg',
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        heightSizedBox(30.0),
        if (isLoading)
          const CircularProgressIndicator(
            color: AppColor.primaryColor,
          )
        else
          SvgPicture.asset("assets/images/uploadvector.svg"),
      ],
    );
  }
}

Future pickFile(BuildContext context, WidgetRef ref) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    PlatformFile file = result.files.first;

    if (file.extension == 'csv') {
      log('File name: ${file.name}');
      ref.read(fileNameProvider.notifier).state = file.name;
      ref.read(filePathProvider.notifier).state = file.path;
      return file.path;
    } else {
      showErrorDialog(
          message:
              'This file format is not supported. Please upload a .csv file.',
          context: context);
    }
  }
}

void showErrorDialog({required String message, required BuildContext context}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColor.whiteColor,
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
