import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/dashboard_options.dart';
import '../../utils/common_style.dart';
import '../../utils/providers.dart';
import '../component/dashboard_small_btn.dart';
import '../repo/sales_dashboard_repo.dart';

final modelWiseDataProvider = FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final getModelData = await ref.watch(salesRepoProvider).getModelWiseData(
      firstDate: options.firstDate,
      lastDate: options.lastDate,
      tdFormat: options.tdFormat,
      dataFormat: options.dataFormat);
  return getModelData;
});

final dealerModelDataProvider = FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final getModelData = await ref
      .watch(salesRepoProvider)
      .getDealerModelWiseData(
          firstDate: options.firstDate,
          lastDate: options.lastDate,
          tdFormat: options.tdFormat,
          dataFormat: options.dataFormat);
  return getModelData;
});

class ModelTable extends ConsumerWidget {
  const ModelTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dealerRole = ref.watch(dealerRoleProvider);
    final selectedBtn = ref.watch(selectedIndexProvider);
    final modelData = dealerRole == "dealer"
        ? ref.watch(dealerModelDataProvider)
        : ref.watch(modelWiseDataProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth / 12;
    return modelData.when(
      data: (data) {
        if (data == null || data['columns'] == null || data['data'] == null) {
          return const Center(child: Text('No data available.'));
        }

        final columns = data['columns'] ?? [];
        final rows = data['data'] ?? [];
        return Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: const DividerThemeData(
              color: Colors.white,
            ),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2.2,
            child: DataTable2(
              headingRowHeight: 50,
              dividerThickness: 2.5,
              columnSpacing: columnSpacing,
              fixedTopRows: 2,
              showBottomBorder: true,
              minWidth: 2200,
              horizontalMargin: 0,
              bottomMargin: 5,
              headingRowColor: WidgetStateColor.resolveWith(
                (states) => const Color(0xffD9D9D9),
              ),
              columns: [
                for (var column in columns)
                  DataColumn(
                    label: Center(
                      child: Text(
                        column ?? 'Unknown',
                        textAlign: TextAlign.center,
                        style: topStyle,
                      ),
                    ),
                  ),
              ],
              rows: List.generate(rows.length, (index) {
                final row = rows[index] ?? {};

                return DataRow(
                  color: WidgetStateColor.resolveWith(
                    (states) => const Color(0xffEEEEEE),
                  ),
                  cells: [
                    DataCell(Center(
                        child: Text(row['Price Band']?.toString() ?? ''))),
                    DataCell(Center(
                        child: Text(
                      row['Market Name']?.toString() ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ))),
                    DataCell(Center(
                        child: Text(row['MODEL NAME']?.toString() ?? ''))),
                    DataCell(Center(
                        child: Text(row['Model Target']?.toString() ?? ''))),
                    DataCell(
                        Center(child: Text(row['LMTD']?.toString() ?? ''))),
                    DataCell(Center(child: Text(row['MTD']?.toString() ?? ''))),
                    DataCell(
                        Center(child: Text(row['FTD Vol']?.toString() ?? ''))),
                    DataCell(
                        Center(child: Text(row['% Gwth']?.toString() ?? ''))),
                    DataCell(Center(child: Text(row['ADS']?.toString() ?? ''))),
                    DataCell(Center(child: Text(row['DP']?.toString() ?? ''))),
                    DataCell(
                        Center(child: Text(row['Mkt Stk']?.toString() ?? ''))),
                    DataCell(
                        Center(child: Text(row['Dmdd Stk']?.toString() ?? ''))),
                    DataCell(Center(child: Text(row['M+S']?.toString() ?? ''))),
                    DataCell(Center(child: Text(row['DOS']?.toString() ?? ''))),
                  ],
                );
              }),
            ),
          ),
        );
      },
      error: (error, stackTrace) => const Center(
        child: Text("Something Went Wrong"),
      ),
      loading: () => const Padding(
        padding: EdgeInsets.only(top: 150),
        child: Center(
          child: CircularProgressIndicator(
            color: AppColor.primaryColor,
          ),
        ),
      ),
    );
  }
}

final getModelDataPositionWiseProvider =
    FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final getModelData = await ref
      .watch(salesRepoProvider)
      .getModelPositionWiseData(
          tdFormat: options.tdFormat,
          dataFormat: options.dataFormat,
          firstDate: options.firstDate,
          lastDate: options.lastDate,
          name: options.name,
          position: options.position!.toUpperCase());
  return getModelData;
});

final getSalesDataModelWiseForEmployee =
    FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final getModelWiseEmployeeData = await ref
      .watch(salesRepoProvider)
      .getSalesDataModelWiseForEmployes(
          tdFormat: options.tdFormat,
          dataFormat: options.dataFormat,
          firstDate: options.firstDate,
          lastDate: options.lastDate,
          dealerCode: options.dealerCode);
  return getModelWiseEmployeeData;
});

class ModelTablePositionWise extends ConsumerWidget {
  const ModelTablePositionWise({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth / 12;
    final selectedPosition = ref.watch(selectedPositionProvider);
    final modelData = selectedPosition == "DEALER"
        ? ref.watch(getSalesDataModelWiseForEmployee)
        : ref.watch(getModelDataPositionWiseProvider);

    return modelData.when(
      data: (data) {
        if (data == null || data['columns'] == null || data['data'] == null) {
          return const Center(child: Text('No data available.'));
        }
        final columns = data['columns'] ?? [];
        final rows = data['data'] ?? [];
        return Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: const DividerThemeData(
              color: Colors.white,
            ),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2.2,
            child: DataTable2(
              headingRowHeight: 50,
              dividerThickness: 2.5,
              columnSpacing: columnSpacing,
              fixedTopRows: 2,
              showBottomBorder: true,
              minWidth: 2000,
              horizontalMargin: 0,
              bottomMargin: 5,
              headingRowColor: WidgetStateColor.resolveWith(
                (states) => const Color(0xffD9D9D9),
              ),
              columns: [
                for (var column in columns)
                  DataColumn(
                    label: Center(
                      child: Text(
                        column ?? 'Unknown',
                        textAlign: TextAlign.center,
                        style: topStyle,
                      ),
                    ),
                  ),
              ],
              rows: List.generate(rows.length, (index) {
                final row = rows[index] ?? {};

                return DataRow(
                  color: WidgetStateColor.resolveWith(
                    (states) => const Color(0xffEEEEEE),
                  ),
                  cells: [
                    DataCell(Center(
                        child: Text(row['Price Band']?.toString() ?? ''))),
                    DataCell(Center(
                        child: Text(row['Market Name']?.toString() ?? ''))),
                    DataCell(Center(
                        child: Text(row['MODEL NAME']?.toString() ?? ''))),
                    DataCell(Center(
                        child: Text(row['Model Target']?.toString() ?? ''))),
                    DataCell(
                        Center(child: Text(row['LMTD']?.toString() ?? ''))),
                    DataCell(Center(child: Text(row['MTD']?.toString() ?? ''))),
                    DataCell(
                        Center(child: Text(row['FTD Vol']?.toString() ?? ''))),
                    DataCell(
                        Center(child: Text(row['% Gwth']?.toString() ?? ''))),
                    DataCell(Center(child: Text(row['ADS']?.toString() ?? ''))),
                    DataCell(Center(child: Text(row['DP']?.toString() ?? ''))),
                    DataCell(
                        Center(child: Text(row['Mkt Stk']?.toString() ?? ''))),
                    DataCell(
                        Center(child: Text(row['Dmdd Stk']?.toString() ?? ''))),
                    DataCell(Center(child: Text(row['M+S']?.toString() ?? ''))),
                    DataCell(Center(child: Text(row['DOS']?.toString() ?? ''))),
                  ],
                );
              }),
            ),
          ),
        );
      },
      error: (error, stackTrace) => const Center(
        child: Text("Something Went Wrong"),
      ),
      loading: () => const Padding(
        padding: EdgeInsets.only(top: 150),
        child: Center(
          child: CircularProgressIndicator(
            color: AppColor.primaryColor,
          ),
        ),
      ),
    );
  }
}

var topStyle = GoogleFonts.lato(
  textStyle: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600),
);
