import 'dart:developer';
import 'package:dio/dio.dart';

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
      token != null ? headers['Authorization'] = "$token" : null;
      Response response = await dio.get(url, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (err) {
      // log("get statusCode ${err.response?.statusCode.toString()}");
      // log("get type ${err.response?.data.toString()} ");
    }
  }

  Future postDioRequest({required Map data}) async {
    try {
      token != null ? headers['Authorization'] = "$token" : null;
      Response response =
          await dio.post(url, data: data, options: Options(headers: headers));
      return response.data;
    } on DioException {
      rethrow;
    }
  }

  Future putDioRequest({required Map data}) async {
    try {
      token != null ? headers['Authorization'] = "$token" : null;

      Response response =
          await dio.put(url, data: data, options: Options(headers: headers));

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (err) {
      // log("post statusCode ${err.response?.statusCode.toString()}");
      // log("post type ${err.response?.data.toString()} ");
    }
  }

  Future putDioFormData({required FormData data}) async {
    try {
      token != null ? headers['Authorization'] = "$token" : null;
      Response response =
          await dio.put(url, data: data, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (err) {
      // log("post statusCode ${err.response?.statusCode.toString()}");
      // log("post type ${err.response?.data.toString()} ");
    }
  }

  Future postDioFormData({required FormData data}) async {
    try {
      token != null ? headers['Authorization'] = "$token" : null;
      Response response =
          await dio.post(url, data: data, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (err) {
      // log("post statusCode ${err.response?.statusCode.toString()}");
      // log("post type ${err.response?.data.toString()} ");
    }
  }
}

class ApiUrl {
  static const baseUrl = "https://www.siddhaconnect.com";
  static const getSalesDashboardData = "$baseUrl/sales/dashboard";
  static const getChannelData = "$baseUrl/sales/channel-wise";
  static const getSegmentData = "$baseUrl/sales/segment-wise";
  static const getTseData = "$baseUrl/sales/tse-wise";
  static const getAbmData = "$baseUrl/sales/abm-wise";
  static const getAreaData = "$baseUrl/sales/cluster-wise";
  static const getAsmData = "$baseUrl/sales/asm-wise";
  static const getRsoData = "$baseUrl/sales/rso-wise";
  static const uploadSalesData = "$baseUrl/sales";
  static const userRegister = "$baseUrl/user/register";
  static const userLogin = "$baseUrl/login";

  // static const verifyOtp = "$baseUrl/otp";
  // static const createUser = "$baseUrl/user";
}
