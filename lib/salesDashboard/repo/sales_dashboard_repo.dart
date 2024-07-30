import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/utils/api_method.dart';

final salesRepoProvider = Provider((ref) => SalesDashboardRepo());

class SalesDashboardRepo {
  getSalesDashboardData({String? tdFormat, String? dataFormat}) async {
    try {
    String url = urlFormat(ApiUrl.getSalesDashboardData, tdFormat, dataFormat);
      final response = await ApiMethod(
        url: url,
      ).getDioRequest();
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  getChannelData({String? tdFormat, String? dataFormat}) async {
    try {
    String url = urlFormat(ApiUrl.getChannelData, tdFormat, dataFormat);
      final response = await ApiMethod(url: url).getDioRequest();
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  getSegmentData({String? tdFormat, String? dataFormat}) async {
    try {
     String url = urlFormat(ApiUrl.getSegmentData, tdFormat, dataFormat);
      final response = await ApiMethod(url: url).getDioRequest();
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

 getTseData({String? tdFormat, String? dataFormat}) async {
  try {
    String url = urlFormat(ApiUrl.getTseData, tdFormat, dataFormat);
    final response = await ApiMethod(url: url).getDioRequest();
    return response;
  } catch (e) {
    log(e.toString());
    return null; 
  }
}

 getAbmData({String? tdFormat, String? dataFormat}) async {
  try {
    String url = urlFormat(ApiUrl.getAbmData, tdFormat, dataFormat);
    final response = await ApiMethod(url: url).getDioRequest();
    return response;
  } catch (e) {
    log(e.toString());
    return null; 
  }
}

 getAreaData({String? tdFormat, String? dataFormat}) async {
  try {
    String url = urlFormat(ApiUrl.getAreaData, tdFormat, dataFormat);
    final response = await ApiMethod(url: url).getDioRequest();
    return response;
  } catch (e) {
    log(e.toString());
    return null; 
  }
}
 getAsmData({String? tdFormat, String? dataFormat}) async {
  try {
    String url = urlFormat(ApiUrl.getAsmData, tdFormat, dataFormat);
    final response = await ApiMethod(url: url).getDioRequest();
    return response;
  } catch (e) {
    log(e.toString());
    return null; 
  }
}

 getRsoData({String? tdFormat, String? dataFormat}) async {
  try {
    String url = urlFormat(ApiUrl.getRsoData, tdFormat, dataFormat);
    final response = await ApiMethod(url: url).getDioRequest();
    return response;
  } catch (e) {
    log(e.toString());
    return null; 
  }
}
}





String urlFormat(String baseUrl, String? tdFormat, String? dataFormat) {
  String url = baseUrl;
  if (tdFormat != null) {
    url += '?td_format=$tdFormat';
  }
  if (dataFormat != null) {
    url += tdFormat != null ? '&data_format=$dataFormat' : '?data_format=$dataFormat';
  }
  return url;
}

