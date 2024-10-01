import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/utils/message.dart';
import 'package:siddha_connect/utils/secure_storage.dart';

import '../../../utils/api_method.dart';

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
        url += '?query=$brand';
      }

      final response = await ApiMethod(url: url).getDioRequest();

      log("GetAAllProdutct$response");
      return response;
    } catch (e) {
      // log(e.toString());
      return null;
    }
  }

  addRecord({required Map data}) async {
    try {
      log("Data being sent: $data");
      final token = await ref.read(secureStoargeProvider).readData('authToken');

      log("token$token");

      final response = await ApiMethod(url: ApiUrl.addRecord, token: token)
          .postDioRequest(data: data);

      log("Response: $response");

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
}
