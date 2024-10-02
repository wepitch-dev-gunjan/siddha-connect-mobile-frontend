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
      log("ErrorGetApi=>>$err");
      // log("get statusCode: ${err.response?.statusCode.toString()}");
      // log("get type: ${err.response?.data.toString()}");
    }
  }

  Future postDioRequest({required Map data}) async {
    log(url);
    log(data.toString());
    try {
      if (token != null) {
        headers['Authorization'] = "$token";
      }
      Response response =
          await dio.post(url, data: data, options: Options(headers: headers));

      // log("REspPost${response.data}");
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
  static String baseUrl = dotenv.env['BASEURL'] ?? "";
  static String getEmployeeSalesDashboardData =
      "$baseUrl/sales-data-mtdw/dashboard/employee";
  static String getEmployeeSalesDashboardDataByName =
      "$baseUrl/sales-data-mtdw/dashboard/by-employee-name";
  static String getEmployeeSalesDashboardDataByDealerCode =
      "$baseUrl/sales-data-mtdw/dashboard/by-dealer-code";
  static String getChannelData =
      "$baseUrl/sales-data-mtdw/channel-wise/employee";
  static String getSegmentData =
      "$baseUrl/sales-data-mtdw/segment-wise/employee";
  static String uploadSalesData = "$baseUrl/sales-data-mtdw";
  static String userRegister = "$baseUrl/user/register";
  static String dealerRegister = "$baseUrl/add-dealer";
  static String dealerProfileUpdate = "$baseUrl/edit-dealer";
  static String userLogin = "$baseUrl/login";
  static String getProfile = "$baseUrl/userForUser";
  static String getDealerProfile = "$baseUrl/get-dealer";
  static String isDealerVerified = "$baseUrl/is-dealer-verified";
  static String getAllSubordinates =
      "$baseUrl/sales-data-mtdw/get-all-subordinates-mtdw";
  static String getSegmentPositionWise =
      "$baseUrl/sales-data-mtdw/segment-wise/by-position-category";
  static String getChannelPositionWise =
      "$baseUrl/sales-data-mtdw/channel-wise/by-position-category";
  static String getModelPositionWise =
      "$baseUrl/model-data-mtdw/by-position-category";
  static String getSegmentSubordinateWise =
      "$baseUrl/sales-data-mtdw/segment-wise/by-subordinate-name/";
  static String getChannelSubordinateWise =
      "$baseUrl/sales-data-mtdw/channel-wise/by-subordinate-name/";
  static String getModelSubordinateWise =
      "$baseUrl/model-data-mtdw/by-subordinate-name/";
  static String getModelData = "$baseUrl/model-data/mtdw/employee";
  static String uploadModelData = "$baseUrl/model-data";
  static String uploadChannelTargets = "$baseUrl/channel-targets";
  static String uploadSegmentTargets = "$baseUrl/segment-targets";
  static String getDealerDashboardData =
      "$baseUrl/sales-data-mtdw/dashboard/dealer";
  static String getDealerSegmentData =
      "$baseUrl/sales-data-mtdw/segment-wise/dealer";
  static String getDealerChannelData =
      "$baseUrl/sales-data-mtdw/channel-wise/dealer";
  static String getDealerModelData = "$baseUrl/model-data/mtdw/dealer";
  static String getDealerListForEmployeesData =
      "$baseUrl/sales-data-mtdw/get-dealer-list-for-employees";

  static String getSegmentDataByDealerCode =
      "$baseUrl/sales-data-mtdw/segment-wise/employee/by-dealer-code";
  static String getSalesDataChannelWiseForEmployee =
      "$baseUrl/sales-data-mtdw/channel-wise/employee/by-dealer-code";
  static String getSalesDataModelWiseForEmployee =
      "$baseUrl/model-data-mtdw/employee/by-dealer-code";

//=====================================! Pulse $ Extraction Url !==========================
  static String getAllProducts = "$baseUrl/product/get-all-products";
  static String pulseDataUpload = "$baseUrl/record/add";
  static String extractionDataUpload = "$baseUrl/record/extraction/add";
}
