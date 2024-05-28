import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/common_style.dart';
import '../../utils/sizes.dart';
import '../screen/sales_dashboard.dart';

class SalesDashboardCard extends ConsumerWidget {
  const SalesDashboardCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardData = ref.watch(getSalesDashboardProvider);

    return dashboardData.when(
      data: (data) {
        return Column(
          children: [
            heightSizedBox(10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DashboardComp(
                  title: "YTD sell in volume",
                  value: data['mtd_sell_in_value'],
                ),
                DashboardComp(
                  title: "LYTD sell in volume",
                  value: data["lmtd_sell_in_value"],
                ),
                DashboardComp(
                  title: "Growth % \n",
                  value: data["sell_in_growth"],
                  valueColor: data["sell_out_growth"][0] == '-'
                      ? Colors.red
                      : Colors.green,
                ),
              ],
            ),
            heightSizedBox(10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DashboardComp(
                  title: "YTD sell out volume",
                  value: data['mtd_sell_out_value'],
                ),
                DashboardComp(
                  title: "YTD sell out volume",
                  value: data["lmtd_sell_out_value"],
                ),
                DashboardComp(
                  title: "Growth % \n",
                  value: data["sell_out_growth"],
                  valueColor: data["sell_out_growth"][0] == '-'
                      ? Colors.red
                      : Colors.green,
                ),
              ],
            ),
          ],
        );
      },
      error: (error, stackTrace) =>
          const Center(child: Text("Something went wrong")),
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class DashboardComp extends StatelessWidget {
  final String title, value;
  final Color? valueColor;
  final double? titleSize;
  const DashboardComp(
      {super.key,
      required this.title,
      required this.value,
      this.valueColor,
      this.titleSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
          width: width(context) * 0.3,
          decoration: BoxDecoration(
              color: const Color(0xffF8F5F5),
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: titleSize ?? 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffA8A8A8),
                  ),
                ),
              ),
              Text(
                value,
                style: GoogleFonts.leagueSpartan(
                  textStyle: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w300,
                    color: valueColor ?? AppColor.primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
