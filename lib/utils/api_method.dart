import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiMethod {
  Dio dio = Dio();
  final String url;
  final String? token;
  final Map? data;
  final Map<String, dynamic>? queryParameters;

  Map<String, dynamic> headers = {
    'Content-Type': 'application/json; charset=utf-8'
  };

  ApiMethod({required this.url, this.token, this.data, this.queryParameters});

  Future getDioRequest() async {
    try {
      if (token != null) {
        headers['Authorization'] = "$token";
      }
      Response response =
          await dio.get(url, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (err) {
      log("get statusCode: ${err.response?.statusCode.toString()}");
      log("get type: ${err.response?.data.toString()}");
    } 
  }

  Future postDioRequest({required Map data}) async {
    try {
      if (token != null) {
        headers['Authorization'] = "$token";
      }
      Response response =
          await dio.post(url, data: data, options: Options(headers: headers));
      return response.data;
    } on DioException {
      rethrow;
    }
  }

  Future putDioRequest({required Map data}) async {
    try {
      if (token != null) {
        headers['Authorization'] = "$token";
      }
      Response response =
          await dio.put(url, data: data, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (err) {
      log("put statusCode: ${err.response?.statusCode.toString()}");
      log("put type: ${err.response?.data.toString()}");
    }
  }

  Future putDioFormData({required FormData data}) async {
    try {
      if (token != null) {
        headers['Authorization'] = "$token";
      }
      Response response =
          await dio.put(url, data: data, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (err) {
      log("putFormData statusCode: ${err.response?.statusCode.toString()}");
      log("putFormData type: ${err.response?.data.toString()}");
    }
  }

  Future postDioFormData({required FormData data}) async {
    try {
      if (token != null) {
        headers['Authorization'] = "$token";
      }
      Response response =
          await dio.post(url, data: data, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (err) {
      log("postFormData statusCode: ${err.response?.statusCode.toString()}");
      log("postFormData type: ${err.response?.data.toString()}");
    }
  }
}



class ApiUrl {
  static String baseUrl = dotenv.env['BASEURL'] ??"";
  static String getSalesDashboardData = "$baseUrl/sales/dashboard";
  static String getChannelData = "$baseUrl/sales/channel-wise";
  static String getSegmentData = "$baseUrl/sales/segment-wise";
  static String uploadSalesData = "$baseUrl/sales";
  static String userRegister = "$baseUrl/user/register";
  static String userLogin = "$baseUrl/login";
  static String getProfile = "$baseUrl/userForUser";
  static String getAllSubordinates = "$baseUrl/sales/get-all-subordinates";
  static String getDropDawn = "$baseUrl/sales/segment-wise/";
   static String getModelData = "$baseUrl/model-data";
}
