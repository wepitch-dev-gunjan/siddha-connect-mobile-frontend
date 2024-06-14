import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/utils/api_method.dart';

final salesRepoProvider = Provider((ref) => SalesDashboardRepo());

class SalesDashboardRepo {
  getSalesDashboardData( {String? tdFormet, String? dataFormet}) async {
    try {
      String url = ApiUrl.getSalesDashboardData;
      if (tdFormet != null) {
        url += '?td_format=$tdFormet';
      }
      if (dataFormet != null) {
        url += '&data_format=$dataFormet';
      }

      final response = await ApiMethod(url: url, ).getDioRequest();
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  // getSalesDashboardData({String? tdFormet, String? dataFormet}) async {
  //   try {
  //     Map<String, dynamic> queryParams = {};

  //     if (tdFormet != null) {
  //       queryParams['tdFormet'] = tdFormet;
  //     }
  //     if (dataFormet != null) {
  //       queryParams['dataFormet'] = dataFormet;
  //     }
  //     final response = await ApiMethod(
  //             url: ApiUrl.getSalesDashboardData, queryParameters: queryParams)
  //         .getDioRequest();
  //     return response;
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  getChannelData() async {
    try {
      final response =
          await ApiMethod(url: ApiUrl.getChannelData).getDioRequest();
      return response;
    } catch (e) {
      log(e.toString());
    }
  }
}
