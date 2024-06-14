import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/common_style.dart';
import 'tabels.dart';

final selectedButtonProvider = StateProvider<bool>((ref) => true);

class FullSizeBtn extends ConsumerWidget {
  const FullSizeBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSegmentSelected = ref.watch(selectedButtonProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    ref.read(selectedButtonProvider.notifier).state = true;
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: isSegmentSelected
                            ? AppColor.primaryColor
                            : AppColor.whiteColor,
                        border: Border.all(width: 0.05)),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Segment\n',
                              style: GoogleFonts.lato(
                                color: isSegmentSelected
                                    ? Colors.white
                                    : Colors.black,
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: '(Price bucket)',
                              style: GoogleFonts.lato(
                                color: isSegmentSelected
                                    ? Colors.white
                                    : Colors.black, // Specify your colors here
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
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    ref.read(selectedButtonProvider.notifier).state = false;
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: isSegmentSelected
                            ? AppColor.whiteColor
                            : AppColor.primaryColor,
                        border: Border.all(width: 0.05)),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Channel\n',
                              style: GoogleFonts.lato(
                                color: isSegmentSelected
                                    ? Colors.black
                                    : Colors.white,
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: '(DL.Category)',
                              style: GoogleFonts.lato(
                                color: isSegmentSelected
                                    ? Colors.black
                                    : Colors.white, // Specify your colors here
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
              ),
            ],
          ),
        ),
        if (isSegmentSelected)
          const Padding(
            padding: EdgeInsets.only(top: 100, left: 10, right: 10),
            child: Center(
              child: Text("Under Development.........."),
            ),
          )
        // const SegmentTable()
        else
          const ChannelTable()
      ],
    );
  }
}

class SmallCusBtn extends ConsumerWidget {
  const SmallCusBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              ref.read(selectedIndexProvider.notifier).state = 0;
            },
            child: Container(
              width: 70,
              height: 30,
              margin: const EdgeInsets.only(right: 15.0),
              decoration: BoxDecoration(
                color: selectedIndex == 0
                    ? AppColor.primaryColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: AppColor.primaryColor, width: 1.0),
              ),
              child: Center(
                child: Text(
                  'All',
                  style: GoogleFonts.lato(
                      color: selectedIndex == 0 ? Colors.white : Colors.black,
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 12)),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(buttons.length - 1, (index) {
                  return GestureDetector(
                    onTap: () {
                      ref.read(selectedIndexProvider.notifier).state =
                          index + 1;
                    },
                    child: Container(
                      width: 70,
                      height: 30,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: selectedIndex == index + 1
                            ? AppColor.primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            color: AppColor.primaryColor, width: 1.0),
                      ),
                      child: Center(
                        child: Text(
                          buttons[index + 1],
                          style: GoogleFonts.lato(
                              color: selectedIndex == index + 1
                                  ? Colors.white
                                  : const Color(0xff999292),
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12)),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final buttons = ['All', 'TSE', 'Area', 'ABM', 'ASM', 'TL', 'RSO'];

final selectedIndexProvider = StateProvider<int>((ref) => 0);
