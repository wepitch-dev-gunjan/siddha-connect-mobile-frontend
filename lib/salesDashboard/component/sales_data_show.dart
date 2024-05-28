import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/sizes.dart';
import '../screen/sales_dashboard.dart';
import 'shimmer.dart';

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
                    value: data['td_sell_in'],
                  ),
                  DashboardComp(
                    title: "LYTD sell in volume",
                    value: data["ltd_sell_in"],
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
                    value: data['td_sell_out'],
                  ),
                  DashboardComp(
                    title: "YTD sell out volume",
                    value: data["ltd_sell_out"],
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
        loading: () =>const  DashboardShimmerEffect());
  }
}
