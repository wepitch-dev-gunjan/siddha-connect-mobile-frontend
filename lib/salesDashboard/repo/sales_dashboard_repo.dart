import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/utils/api_method.dart';

final salesRepoProvider = Provider((ref) => SalesDashboardRepo());

class SalesDashboardRepo {
  getSalesDashboardData() async {
    try {
      final response =
          await ApiMethod(url: ApiUrl.getSalesDashboardData).getDioRequest();
      return response;
    } catch (e) {
      log(e.toString());
    }
  }
}
