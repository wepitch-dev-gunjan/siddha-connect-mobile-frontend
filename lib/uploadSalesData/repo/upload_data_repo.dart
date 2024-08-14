import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/utils/api_method.dart';
import '../../salesDashboard/screen/sales_dashboard.dart';
import '../../utils/message.dart';
import '../../utils/navigation.dart';

final salesDataUploadRepoProvider = Provider((ref) {
  return SalesDataUploadRepo();
});

class SalesDataUploadRepo {
  salesDataUpload({required File file}) async {
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
        ),
      });
      final response = await ApiMethod(url: ApiUrl.uploadSalesData)
          .postDioFormData(data: formData);
      if (response == "Data inserted into database") {
        ShowSnackBarMsg(
          "Sales Data Upload Successfully",
          color: Colors.green,
        );
        navigatePushReplacement(const SalesDashboard());
      } else {
        ShowSnackBarMsg(
          "Something went wrong",
          color: Colors.red,
        );
        navigatePushReplacement(const SalesDashboard());
      }

      return response;
    } catch (e) {}
  }

  modelDataUpload({required File file}) async {
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
        ),
      });
      final response = await ApiMethod(url: ApiUrl.uploadModelData)
          .postDioFormData(data: formData);
      if (response == "Model Data inserted into database!") {
        ShowSnackBarMsg("Model Data Upload Successfully", color: Colors.green);
        navigatePushReplacement(const SalesDashboard());
      } else {
        ShowSnackBarMsg("Something went wrong", color: Colors.red);
        navigatePushReplacement(const SalesDashboard());
      }
      return response;
    } catch (e) {}
  }

  channelTargetUpload({required File file}) async {
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
        ),
      });
      final response = await ApiMethod(url: ApiUrl.uploadChannelTargets)
          .putDioFormData(data: formData);
      if (response == "Targets inserted/updated in the database!") {
        ShowSnackBarMsg("Channel Target Data Upload Successfully",
            color: Colors.green);
        navigatePushReplacement(const SalesDashboard());
      } else {
        ShowSnackBarMsg("Something went wrong", color: Colors.red);
        navigatePushReplacement(const SalesDashboard());
      }
      return response;
    } catch (e) {}
  }

  segmentTargetUpload({required File file}) async {
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
        ),
      });
      final response = await ApiMethod(url: ApiUrl.uploadSegmentTargets)
          .putDioFormData(data: formData);
      if (response == "Targets inserted/updated in the database!") {
        ShowSnackBarMsg("Segment Target Data Upload Successfully",
            color: Colors.green);
        navigatePushReplacement(const SalesDashboard());
      } else {
        ShowSnackBarMsg("Something went wrong", color: Colors.red);
        navigatePushReplacement(const SalesDashboard());
      }
      return response;
    } catch (e) {}
  }
}
