import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/salesDashboard/tables/channel_table.dart';
import 'package:siddha_connect/salesDashboard/tables/model_table.dart';
import 'package:siddha_connect/salesDashboard/tables/segment_position_wise.dart';
import '../../utils/common_style.dart';
import '../tables/segment_table.dart';
import 'dashboard_small_btn.dart';

final selectedButtonProvider = StateProvider<int>((ref) => 0);

class FullSizeBtn extends ConsumerWidget {
  const FullSizeBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedButtonIndex = ref.watch(selectedButtonProvider);
    final selectedBtn = ref.watch(selectedIndexProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              DashboardTableButton(
                title: 'Segment',
                subtitle: '(Price bucket)',
                isSelected: selectedButtonIndex == 0,
                onTap: () =>
                    ref.read(selectedButtonProvider.notifier).state = 0,
              ),
              DashboardTableButton(
                title: 'Channel',
                subtitle: '(DL.Category)',
                isSelected: selectedButtonIndex == 1,
                onTap: () =>
                    ref.read(selectedButtonProvider.notifier).state = 1,
              ),
              DashboardTableButton(
                title: 'Model',
                subtitle: '(Some Info)',
                isSelected: selectedButtonIndex == 2,
                onTap: () =>
                    ref.read(selectedButtonProvider.notifier).state = 2,
              ),
            ],
          ),
        ),
        if (selectedButtonIndex == 0)
          selectedBtn == 0
              ? const SegmentTable()
              : const SegmentTablePositionWise()
        else if (selectedButtonIndex == 1)
          selectedBtn == 0
              ? const ChannelTable()
              : const ChannelTablePositionWise()
        else if (selectedButtonIndex == 2)
          selectedBtn == 0 ? const ModelTable() : const ModelTablePositionWise()
      ],
    );
  }
}

class DashboardTableButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const DashboardTableButton({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: isSelected ? AppColor.primaryColor : AppColor.whiteColor,
            border: Border.all(width: 0.05),
          ),
          child: Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$title\n',
                    style: GoogleFonts.lato(
                      color: isSelected ? Colors.white : Colors.black,
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: subtitle,
                    style: GoogleFonts.lato(
                      color: isSelected ? Colors.white : Colors.black,
                      textStyle: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
