import 'dart:developer';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:siddha_connect/salesDashboard/component/date_picker.dart';
import 'package:siddha_connect/utils/common_style.dart';
import '../../utils/cus_appbar.dart';
import '../components/filters.dart';
import '../repo/product_repo.dart';
import 'package:intl/intl.dart';

final getExtractionReportForAdmin = FutureProvider.autoDispose((ref) async {
  final productRepo = ref.watch(productRepoProvider);
  final filters = ref.watch(newSelectedItemsProvider);
  final valueToggle = ref.watch(valueToggleProvider);
  final showShare = ref.watch(showShareToggleProvider);
  final startDate = ref.watch(firstDateProvider);
  final endDate = ref.watch(lastDateProvider);

  // Formatting the dates
  final dateFormat = DateFormat('yyyy-MM-dd');
  final formattedStartDate = dateFormat.format(startDate);
  final formattedEndDate = dateFormat.format(endDate);

  // Updating filters with startDate and endDate
  final updatedFilters = {
    ...filters,
    "valueVolume": valueToggle.toString().toLowerCase(),
    "showShare": showShare.toString().toLowerCase(),
    "startDate": formattedStartDate.toString(),
    "endDate": formattedEndDate.toString(),
  };

  final data =
      await productRepo.getExtractionReportForAdmin(filters: updatedFilters);
  ref.keepAlive();
  return data;
});

final valueToggleProvider = StateProvider<String>((ref) => "Value");
final showShareToggleProvider = StateProvider<String>((ref) => "false");

class ExtractionReport extends ConsumerWidget {
  const ExtractionReport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final valueToggleState = ref.watch(valueToggleProvider);
    final showShareToggleState = ref.watch(showShareToggleProvider);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toggle Buttons Row
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // First Toggle Button
                  Row(
                    children: [
                      Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          activeColor: Colors.white,
                          activeTrackColor: AppColor.primaryColor,
                          value: valueToggleState == "Value",
                          onChanged: (value) {
                            ref.read(valueToggleProvider.notifier).state =
                                value ? "Value" : "Volume";
                          },
                        ),
                      ),
                      Text(
                          valueToggleState), // Will display "Value" or "Volume"
                    ],
                  ),

                  // Second Toggle Button
                  Row(
                    children: [
                      Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          activeColor: Colors.white,
                          activeTrackColor: AppColor.primaryColor,
                          value: showShareToggleState == "true",
                          onChanged: (value) {
                            ref.read(showShareToggleProvider.notifier).state =
                                value ? "true" : "false";
                          },
                        ),
                      ),
                      Text(showShareToggleState == "true"
                          ? "Show Actual Values"
                          : "Show Share %"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10.0),
            const DatePickerContainer(),
            const SizedBox(height: 10.0),
            const Filters(),
            const SizedBox(height: 10.0),
            const Expanded(
              child: ExtractionReportTable(),
            ),
          ],
        ));
  }
}

// class ExtractionReport extends ConsumerWidget {
//   const ExtractionReport({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final data = ref.watch(getExtractionReportForAdmin);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: const CustomAppBar(),
//       body: data.when(
//         data: (data) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [

//               heightSizedBox(10.0),
//               const DatePickerContainer(),
//               heightSizedBox(10.0),
//               const Filters(),
//               heightSizedBox(10.0),
//               const Expanded(
//                 child: ExtractionReportTable(),
//               )
//             ],
//           );
//         },
//         error: (error, stackTrace) => const Center(
//           child: Text("Something Went Wrong"),
//         ),
//         loading: () => const Center(
//             child: SpinKitCircle(
//           color: AppColor.primaryColor,
//           size: 50.0,
//         )),
//       ),
//     );
//   }
// }

// class ExtractionReport extends ConsumerWidget {
//   const ExtractionReport({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final data = ref.watch(getExtractionReportForAdmin);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: const CustomAppBar(),
//       body: data.when(
//         data: (data) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [

//               heightSizedBox(10.0),
//               const DatePickerContainer(),
//               heightSizedBox(10.0),
//               const Filters(),
//               heightSizedBox(10.0),
//               const Expanded(
//                 child: ExtractionReportTable(),
//               )
//             ],
//           );
//         },
//         error: (error, stackTrace) => const Center(
//           child: Text("Something Went Wrong"),
//         ),
//         loading: () =>const  Center(
//             child: SpinKitCircle(
//           color: AppColor.primaryColor,
//           size: 50.0,
//         )),
//       ),
//     );
//   }
// }

class ExtractionReportTable extends ConsumerWidget {
  const ExtractionReportTable({super.key});

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
                child: SpinKitCircle(
              color: AppColor.primaryColor,
              size: 50.0,
            )));
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
