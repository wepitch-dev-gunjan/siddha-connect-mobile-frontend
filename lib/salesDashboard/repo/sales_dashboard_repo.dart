import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/utils/api_method.dart';

final salesRepoProvider =
    Provider.autoDispose((ref) => SalesDashboardRepo(ref: ref));

class SalesDashboardRepo {
  final AutoDisposeProviderRef<Object?> ref;
  SalesDashboardRepo({required this.ref});

  getSalesDashboardData(
      {String? tdFormat,
      String? dataFormat,
      String? firstDate,
      String? lastDate,
      String? position,
      String? name}) async {
    try {
      String url = urlFormat(ApiUrl.getSalesDashboardData, tdFormat, dataFormat,
          firstDate, lastDate, position, name);
      log("dashboardurl$url");
      final response = await ApiMethod(
        url: url,
      ).getDioRequest();
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  getChannelWiseData(
      {String? tdFormat,
      String? dataFormat,
      String? firstDate,
      String? lastDate,
      String? position,
      String? name}) async {
    try {
      String url = urlFormat(ApiUrl.getChannelData, tdFormat, dataFormat,
          firstDate, lastDate, position, name);
      final response = await ApiMethod(url: url).getDioRequest();
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  getSegmentAllData(
      {String? tdFormat,
      String? dataFormat,
      String? firstDate,
      String? lastDate,
      String? position,
      String? name}) async {
    try {
      String url = urlFormat(ApiUrl.getSegmentData, tdFormat, dataFormat,
          firstDate, lastDate, position, name);
      final response = await ApiMethod(url: url).getDioRequest();
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  getSegmentWiseData(
      {String? tdFormat,
      String? dataFormat,
      String? firstDate,
      String? lastDate,
      String? name,
      String? position}) async {
    try {
      String url = urlFormatTse(ApiUrl.getDropDawn, tdFormat, dataFormat,
          firstDate, lastDate, name, position);
      final response = await ApiMethod(url: url).getDioRequest();

      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  getModelWiseData(
      {String? tdFormat,
      String? dataFormat,
      String? firstDate,
      String? lastDate,
      String? name,
      String? position}) async {
    try {
      String url = urlFormatTse(ApiUrl.getModelData, tdFormat, dataFormat,
          firstDate, lastDate, name, position);
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
      final response = await ApiMethod(url: subordinateUrl).getDioRequest();
      return response;
    } catch (e) {
      log("Error in getAllSubordinates: $e");
      return null;
    }
  }

  getDealerSegmetData({
    String? startDate,
    String? endDate,
    String? dataFormat,
    String? dealerCode,
    String? tdFormat,
  }) async {
    try {
      String url = dealerSegmentUrl(ApiUrl.getDealerSegmentData, startDate,
          endDate, dataFormat, dealerCode, tdFormat);

      final response = await ApiMethod(url: url).getDioRequest();
      log("dealrSegmentData$response");
      return response;
    } catch (e) {}
  }

  getDealerDashboardData(
      {String? startDate,
      String? endDate,
      String? dataFormat,
      String? dealerCode,
      String? tdFormat}) async {
    try {
      String url = dealerSegmentUrl(ApiUrl.getDealerDashboardData, startDate,
          endDate, dataFormat, dealerCode, tdFormat);

      final response = await ApiMethod(url: url).getDioRequest();
      // log("dealrSegmentData$response");
      return response;
    } catch (e) {}
  }
}

String dealerSegmentUrl(String baseUrl, String? startDate, String? endDate,
    String? dataFormat, String? dealerCode, String? tdFormat) {
  String url = baseUrl;

  // log("dealerCode=====?$dealerCode");

  Map<String, String?> queryParams = {
    'start_date': startDate,
    'end_date': endDate,
    'data_format': dataFormat,
    'td_format': tdFormat,
    'dealer_code': dealerCode,
  };

  String queryString = queryParams.entries
      .where((entry) => entry.value != null)
      .map((entry) => '${entry.key}=${entry.value}')
      .join('&');

  if (queryString.isNotEmpty) {
    url += '?$queryString';
  }

  return url;
}

String urlFormat(
  String baseUrl,
  String? tdFormat,
  String? dataFormat,
  String? firstDate,
  String? lastDate,
  String? position,
  String? name,
) {
  String url = baseUrl;
  List<String> params = [];

  if (tdFormat != null) {
    params.add('td_format=$tdFormat');
  }
  if (dataFormat != null) {
    params.add('data_format=$dataFormat');
  }
  if (firstDate != null) {
    params.add('start_date=$firstDate');
  }
  if (lastDate != null) {
    params.add('end_date=$lastDate');
  }
  if (position != null) {
    params.add('position=$position');
  }
  if (name != null) {
    params.add('name=$name');
  }

  if (params.isNotEmpty) {
    url += '?${params.join('&')}';
  }

  return url;
}

String urlFormatTse(String baseUrl, String? tdFormat, String? dataFormat,
    String? firstDate, String? lastDate, String? name, String? position) {
  String url = baseUrl;
  if (position != null) {
    url += position.toLowerCase();
  }

  Map<String, String?> queryParams = {
    'start_date': firstDate,
    'end_date': lastDate,
    'data_format': dataFormat,
    if (position != null && name != null) position: name,
  };

  String queryString = queryParams.entries
      .where((entry) => entry.value != null)
      .map((entry) => '${entry.key}=${entry.value}')
      .join('&');

  if (queryString.isNotEmpty) {
    url += '?$queryString';
  }

  return url;
}


// String urlFormatTse(String baseUrl, String? tdFormat, String? dataFormat,
//     String? firstDate, String? lastDate, String? name, String? position) {
//   String url = baseUrl;
//   if (position != null) {
//     url += position;
//   }
//   if (firstDate != null) {
//     url +=
//         position != null ? '?start_date=$firstDate' : '?start_date=$firstDate';
//   }
//   if (lastDate != null) {
//     url += firstDate != null ? '&end_date=$lastDate' : '?data_format=$lastDate';
//   }
//   if (dataFormat != null) {
//     url += (firstDate != null || lastDate != null)
//         ? '&data_format=$dataFormat'
//         : '?data_format=$dataFormat';
//   }
//   if (name != null) {
//     url += (firstDate != null || lastDate != null || dataFormat != null)
//         ? '&$position=$name'
//         : '&$position=$name';
//   }

//   return url;
// }


// String urlFormat(String baseUrl, String? tdFormat, String? dataFormat,
//     String? firstDate, String? lastDate) {
//   String url = baseUrl;

//   if (tdFormat != null) {
//     url += '?td_format=$tdFormat';
//   }

//   if (dataFormat != null) {
//     url += tdFormat != null
//         ? '&data_format=$dataFormat'
//         : '?data_format=$dataFormat';
//   }

//   if (firstDate != null) {
//     url += (tdFormat != null || dataFormat != null)
//         ? '&start_date=$firstDate'
//         : '?start_date=$firstDate';
//   }

//   if (lastDate != null) {
//     url += (tdFormat != null || dataFormat != null || firstDate != null)
//         ? '&end_date=$lastDate'
//         : '?end_date=$lastDate';
//   }

//   return url;
// }
