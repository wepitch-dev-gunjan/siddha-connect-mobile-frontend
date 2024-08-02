import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/utils/api_method.dart';
import 'package:siddha_connect/utils/secure_storage.dart';

final salesRepoProvider =
    Provider.autoDispose((ref) => SalesDashboardRepo(ref: ref));

class SalesDashboardRepo {
  final AutoDisposeProviderRef<Object?> ref;
  SalesDashboardRepo({required this.ref});

  getSalesDashboardData(
      {String? tdFormat,
      String? dataFormat,
      String? firstDate,
      String? lastDate}) async {
    try {
      String url = urlFormat(ApiUrl.getSalesDashboardData, tdFormat, dataFormat,
          firstDate, lastDate);
      final response = await ApiMethod(
        url: url,
      ).getDioRequest();
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  getChannelData(
      {String? tdFormat,
      String? dataFormat,
      String? firstDate,
      String? lastDate}) async {
    try {
      String url = urlFormat(
          ApiUrl.getChannelData, tdFormat, dataFormat, firstDate, lastDate);
      final response = await ApiMethod(url: url).getDioRequest();
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  getSegmentData(
      {String? tdFormat,
      String? dataFormat,
      String? firstDate,
      String? lastDate}) async {
    try {
      log("firstTimE$firstDate");
      log("lastTime$lastDate");
      String url = urlFormat(
          ApiUrl.getSegmentData, tdFormat, dataFormat, firstDate, lastDate);
      final response = await ApiMethod(url: url).getDioRequest();
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  segmentWiseData(
      {String? tdFormat,
      String? dataFormat,
      String? firstDate,
      String? lastDate,
      String? name,
      String? position}) async {
    try {
      log("lastTseDate$lastDate");
      log("FirstTseDate$firstDate");

      String url = urlFormatTse(ApiUrl.getDropDawn, tdFormat, dataFormat,
          firstDate, lastDate, name,position);
      log("urltse$url");
      final response = await ApiMethod(url: url).getDioRequest();
      log("tseResp$response");
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // getDropDawn({String? name, String? position}) async {
  //   try {
  //     String subordinateUrl = ApiUrl.getDropDawn;
  //     if (position != null) {
  //       subordinateUrl += '?position=$position';
  //     }
  //     if (name != null) {
  //       subordinateUrl += position != null ? '&name=$name' : '?name=$name';
  //     }

  //     log("Constructed URL: $subordinateUrl");

  //     final response = await ApiMethod(url: subordinateUrl).getDioRequest();
  //     log("Subordinate response: ${response}");
  //     return response;
  //   } catch (e) {
  //     log("Error in getAllSubordinates: $e");
  //     return null;
  //   }
  // }

  getAbmData(
      {String? tdFormat,
      String? dataFormat,
      String? firstDate,
      String? lastDate}) async {
    try {
      String url = urlFormat(
          ApiUrl.getAbmData, tdFormat, dataFormat, firstDate, lastDate);
      final response = await ApiMethod(url: url).getDioRequest();
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  getAreaData(
      {String? tdFormat,
      String? dataFormat,
      String? firstDate,
      String? lastDate}) async {
    try {
      String url = urlFormat(
          ApiUrl.getAreaData, tdFormat, dataFormat, firstDate, lastDate);
      final response = await ApiMethod(url: url).getDioRequest();
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  getAsmData(
      {String? tdFormat,
      String? dataFormat,
      String? firstDate,
      String? lastDate}) async {
    try {
      String url = urlFormat(
          ApiUrl.getAsmData, tdFormat, dataFormat, firstDate, lastDate);
      final response = await ApiMethod(url: url).getDioRequest();
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  getRsoData(
      {String? tdFormat,
      String? dataFormat,
      String? firstDate,
      String? lastDate}) async {
    try {
      String url = urlFormat(
          ApiUrl.getRsoData, tdFormat, dataFormat, firstDate, lastDate);
      final response = await ApiMethod(url: url).getDioRequest();
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  getAllSubordinates({String? name, String? position}) async {
    try {
      String subordinateUrl = ApiUrl.getAllSubordinates;
      if (position != null) {
        subordinateUrl += '?position=$position';
      }
      if (name != null) {
        subordinateUrl += position != null ? '&name=$name' : '?name=$name';
      }

      log("Constructed URL: $subordinateUrl");

      final response = await ApiMethod(url: subordinateUrl).getDioRequest();
      log("Subordinate response: ${response}");
      return response;
    } catch (e) {
      log("Error in getAllSubordinates: $e");
      return null;
    }
  }
}

String urlFormat(String baseUrl, String? tdFormat, String? dataFormat,
    String? firstDate, String? lastDate) {
  String url = baseUrl;

  if (tdFormat != null) {
    url += '?td_format=$tdFormat';
  }

  if (dataFormat != null) {
    url += tdFormat != null
        ? '&data_format=$dataFormat'
        : '?data_format=$dataFormat';
  }

  if (firstDate != null) {
    url += (tdFormat != null || dataFormat != null)
        ? '&start_date=$firstDate'
        : '?start_date=$firstDate';
  }

  if (lastDate != null) {
    url += (tdFormat != null || dataFormat != null || firstDate != null)
        ? '&end_date=$lastDate'
        : '?end_date=$lastDate';
  }

  return url;
}

String urlFormatTse(String baseUrl, String? tdFormat, String? dataFormat,
    String? firstDate, String? lastDate, String? name, String? position) {
  String url = baseUrl;

  if (position != null) {
    url += position;
  }

  if (firstDate != null) {
    url +=
        position != null ? '?start_date=$firstDate' : '?start_date=$firstDate';
  }

  if (lastDate != null) {
    url += firstDate != null ? '&end_date=$lastDate' : '?data_format=$lastDate';
  }

  if (dataFormat != null) {
    url += (firstDate != null || lastDate != null)
        ? '&data_format=$dataFormat'
        : '?data_format=$dataFormat';
  }

  if (name != null) {
    url += (firstDate != null || lastDate != null || dataFormat != null)
        ? '&tse=$name'
        : '&tse=$name';
  }

  return url;
}
