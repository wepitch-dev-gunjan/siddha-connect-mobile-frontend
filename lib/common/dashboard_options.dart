import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../salesDashboard/component/dashboard_small_btn.dart';
import '../salesDashboard/component/date_picker.dart';
import '../salesDashboard/component/radio.dart';

class DashboardOptions {
  final String tdFormat;
  final String dataFormat;
  final String firstDate;
  final String lastDate;
  final String? name;
  final String? position;
  final String? dealerCategory;

  DashboardOptions(
      {required this.tdFormat,
      required this.dataFormat,
      required this.firstDate,
      required this.lastDate,
      this.dealerCategory,
      this.name,
      this.position});
}

final selectedOptionsProvider =
    StateProvider.autoDispose<DashboardOptions>((ref) {
  final selectedOption1 = ref.watch(selectedOption1Provider);
  final selectedOption2 = ref.watch(selectedOption2Provider);
  final position = ref.watch(selectedPositionProvider).toLowerCase();
  final dealerCategory = ref.watch(dealerCategoryProvider);
  final name = ref.watch(selectedItemProvider);
  final DateTime firstDate = ref.watch(firstDateProvider);
  final DateTime lastDate = ref.watch(lastDateProvider);
  final String formattedFirstDate = DateFormat('yyyy-MM-dd').format(firstDate);
  final String formattedLastDate = DateFormat('yyyy-MM-dd').format(lastDate);

  return DashboardOptions(
      tdFormat: selectedOption1,
      dataFormat: selectedOption2,
      firstDate: formattedFirstDate,
      lastDate: formattedLastDate,
      name: name,
      position: position,
      dealerCategory: dealerCategory);
});