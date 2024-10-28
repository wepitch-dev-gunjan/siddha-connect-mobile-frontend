import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/salesDashboard/component/date_picker.dart';
import 'package:siddha_connect/utils/common_style.dart';
import 'package:siddha_connect/utils/sizes.dart';
import '../../utils/cus_appbar.dart';
import '../components/filters.dart';
import '../repo/product_repo.dart';

final getExtractionReportForAdmin = FutureProvider.autoDispose((ref) async {
  final productRepo = ref.watch(productRepoProvider);
  final data = await productRepo.getExtractionReportForAdmin();
  ref.keepAlive();
  return data;
});

class ExtractionReport extends ConsumerWidget {
  const ExtractionReport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(getExtractionReportForAdmin);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: data.when(
        data: (data) {
          return Column(
            children: [
              heightSizedBox(10.0),
              const DatePickerContainer(),
              heightSizedBox(10.0),
              const Filters(),
              heightSizedBox(10.0),
              const Expanded(
                child: ExtractionDataTable(),
              )
            ],
          );
        },
        error: (error, stackTrace) => const Center(
          child: Text("Something Went Wrong"),
        ),
        loading: () => const Center(
          child: SingleChildScrollView(),
        ),
      ),
    );
  }
}

class ExtractionDataTable extends ConsumerWidget {
  const ExtractionDataTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final extractionData = ref.watch(getExtractionReportForAdmin);
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth / 50;

    double minValue = 0;
    double maxValue = 100;

    return extractionData.when(
      data: (data) {
        if (data == null || data['data'] == null) {
          return const Center(child: Text('No data available.'));
        }

        final columns = [
          "Price Class",
          "Samsung",
          "Vivo",
          "Oppo",
          "Xiaomi",
          "Apple",
          "One Plus",
          "Real Me",
          "Motorola",
          "Others",
          "Rank of Samsung"
        ];
        final rows = data['data'] ?? [];

        return Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: const DividerThemeData(
              color: Colors.white,
            ),
          ),
          child: DataTable2(
            headingRowHeight: 50,
            columnSpacing: 0,
            border: TableBorder.all(color: Colors.black45, width: 0.5),
            bottomMargin: 5,
            horizontalMargin: 0,
            minWidth: 1200,
            showBottomBorder: true,
            headingRowColor: WidgetStateColor.resolveWith(
              (states) => const Color(0xff005BFF),
            ),
            columns: [
              for (var column in columns)
                DataColumn(
                  label: Center(
                    child: Text(
                      column,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
            ],
            rows: List.generate(rows.length, (index) {
              final row = rows[index];

              return DataRow(
                cells: [
                  for (var column in columns)
                    DataCell(
                      Container(
                        color: getHeatmapColor(
                          row[column] is num ? row[column].toDouble() : 0.0,
                          minValue,
                          maxValue,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          row[column]?.toString() ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
        );
      },
      error: (error, stackTrace) => const Center(
        child: Text("Something Went Wrong"),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: AppColor.primaryColor,
          strokeWidth: 3,
        ),
      ),
    );
  }
}

Color getRankColor(int rank) {
  if (rank == 1) return const Color.fromRGBO(255, 8, 8, 0.6); // Red for rank 1
  if (rank == 2) {
    return const Color.fromARGB(153, 63, 60, 54); // Orange for rank 2
  }
  if (rank == 3) {
    return const Color.fromRGBO(255, 255, 102, 0.6); // Light yellow for rank 3
  }
  return const Color.fromRGBO(102, 255, 10, 0.5); // Light green for other ranks
}

Color getHeatmapColor(double value, double minValue, double maxValue) {
  if (maxValue == minValue) {
    return const Color.fromRGBO(255, 255, 255, 0.5); // Avoid division by zero
  }
  final normalizedValue =
      (value - minValue) / (maxValue - minValue); // Normalize between 0 and 1
  int r = 0;
  int g = 0;
  if (normalizedValue < 0.5) {
    r = (normalizedValue * 510).toInt(); // Red intensifies in the second half
    g = 255; // Green is full for first half
  } else {
    r = 255; // Red is full for second half
    g = (255 - (normalizedValue - 0.5) * 510)
        .toInt(); // Green decreases after mid-range
  }
  return Color.fromRGBO(r, g, 0,
      0.6); // Color gradient: green (low) to yellow (mid) to red (high)
}
