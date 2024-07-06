import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/utils/api_method.dart';

final SalesDataUploadRepoProvider = Provider((ref) {
  return SalesDataUploadRepo();
});

class SalesDataUploadRepo {
  salesDataUpload({required File file, }) async {
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
        ),
      });
      final response = await ApiMethod(url: ApiUrl.UploadSalesData)
          .postDioFormData(data: formData);

      log("Sales Data $response");
      return response;
    } catch (e) {}
  }
}
