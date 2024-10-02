import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/utils/message.dart';
import 'package:siddha_connect/utils/secure_storage.dart';
import '../../../utils/api_method.dart';
import '../components/table.dart';

final productRepoProvider =
    Provider.autoDispose((ref) => ProductRepo(ref: ref));

class ProductRepo {
  final AutoDisposeProviderRef<Object?> ref;
  ProductRepo({required this.ref});

  getAllProducts({
    String? brand,
  }) async {
    try {
      String url = ApiUrl.getAllProducts;
      if (brand != null && brand.isNotEmpty) {
        if (brand.contains("Others (>100K)")) {
          brand = "100K";
        } else if (brand.contains("Others (70-100K)")) {
          brand = "70-100K";
        } else if (brand.contains("Others (40-70K)")) {
          brand = "40-70K";
        } else if (brand.contains("Others (30-40K)")) {
          brand = "30-40K";
        } else if (brand.contains("Others (20-30K)")) {
          brand = "20-30K";
        } else if (brand.contains("Others (15-20K)")) {
          brand = "15-20K";
        } else if (brand.contains("Others (10-15K)")) {
          brand = "10-15K";
        } else if (brand.contains("Others (6-10K)")) {
          brand = "6-10K";
        }
        url += '?query=$brand';
      }
      final response = await ApiMethod(url: url).getDioRequest();
      return response;
    } catch (e) {
      return null;
    }
  }

  getExtractionRecord() async {
    try {
      final token = await ref.read(secureStoargeProvider).readData('authToken');
      final response =
          await ApiMethod(url: ApiUrl.getExtractionRecord, token: token)
              .getDioRequest();

      log("ExtractionREcord$response");
      return response;
    } catch (e) {}
  }

  pulseDataUpload({required Map data}) async {
    try {
      final token = await ref.read(secureStoargeProvider).readData('authToken');
      final response =
          await ApiMethod(url: ApiUrl.pulseDataUpload, token: token)
              .postDioRequest(data: data);
      if (response['message'] == "Record added successfully.") {
        showSnackBarMsg(response['message'],
            color: Colors.green, duration: const Duration(seconds: 1));
      } else {
        showSnackBarMsg("Something Went Wrong",
            color: Colors.red, duration: const Duration(seconds: 1));
      }
      return response;
    } catch (e) {
      log("Error submitting data: $e");
    }
  }

  extractionDataUpload({required Map data}) async {
    try {
      final token = await ref.read(secureStoargeProvider).readData('authToken');
      final response =
          await ApiMethod(url: ApiUrl.extractionDataUpload, token: token)
              .postDioRequest(data: data);
      if (response['message'] == "Extraction Record added successfully.") {
        showSnackBarMsg(response['message'],
            color: Colors.green, duration: const Duration(seconds: 1));
        ref.refresh(getExtractionRecordProvider);
      } else {
        showSnackBarMsg("Something Went Wrong",
            color: Colors.red, duration: const Duration(seconds: 1));
      }
      return response;
    } catch (e) {
      log("Error submitting data: $e");
    }
  }
}
