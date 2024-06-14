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
      log("url=====>---$url");
      token != null ? headers['Authorization'] = "$token" : null;
      Response response = await dio.get(url, queryParameters: queryParameters);
      log("resp=====>---${response.data}");

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (err) {
      log("get statusCode ${err.response?.statusCode.toString()}");
      log("get type ${err.response?.data.toString()} ");
    }
  }

  Future postDioRequest({required Map data}) async {
    try {
      token != null ? headers['Authorization'] = "$token" : null;
      Response response =
          await dio.post(url, data: data, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (err) {
      log("post statusCode ${err.response?.statusCode.toString()}");
      log("post type ${err.response?.data.toString()} ");
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
      log("post statusCode ${err.response?.statusCode.toString()}");
      log("post type ${err.response?.data.toString()} ");
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
      log("post statusCode ${err.response?.statusCode.toString()}");
      log("post type ${err.response?.data.toString()} ");
    }
  }
}

class ApiUrl {
  static const baseUrl = "https://siddha-connect-backend.vercel.app";
  static const getSalesDashboardData = "$baseUrl/sales/dashboard";
  static const getChannelData =
      "$baseUrl/sales/channel-wise?start_date=2024-03-01&end_date=2024-04-15";
  // static const getBrands = "$baseUrl/brand";
  // static const getOffers = "$baseUrl/offer";
  // static const sendOtp = "$baseUrl/otp";
  // static const verifyOtp = "$baseUrl/otp";
  // static const createUser = "$baseUrl/user";
}
