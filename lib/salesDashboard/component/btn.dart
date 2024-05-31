import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/main.dart';
import '../../utils/common_style.dart';

final selectedButtonProvider = StateProvider<bool>((ref) => true);

// class FullSizeBtn extends ConsumerWidget {
//   const FullSizeBtn({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isSelected = ref.watch(selectedButtonProvider);

//     return Padding(
//       padding: const EdgeInsets.only(top: 8),
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: GestureDetector(
//               onTap: () {
//                 ref.read(selectedButtonProvider.notifier).state = !isSelected;
//               },
//               child: Container(
//                 height: 50,
//                 color: isSelected ? AppColor.primaryColor : AppColor.whiteColor,
//                 child: Center(
//                   child: Text(
//                     'Segment\n(Price bucket)',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: GestureDetector(
//               onTap: () {
//                 ref.read(selectedButtonProvider.notifier).state = !isSelected;
//               },
//               child: Container(
//                 height: 50,
//                 color: isSelected ? AppColor.whiteColor : AppColor.primaryColor,
//                 child: Center(
//                   child: Text(
//                     'Channel\n(DL.Category)',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: isSelected ? Colors.black : Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
                    height: 50,
                    color: isSegmentSelected
                        ? AppColor.primaryColor
                        : AppColor.whiteColor,
                    child: Center(
                      child: Text(
                        'Segment\n(Price bucket)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              isSegmentSelected ? Colors.white : Colors.black,
                        ),
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
                    height: 50,
                    color: isSegmentSelected
                        ? AppColor.whiteColor
                        : AppColor.primaryColor,
                    child: Center(
                      child: Text(
                        'Channel\n(DL.Category)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              isSegmentSelected ? Colors.black : Colors.white,
                        ),
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
            padding: EdgeInsets.only(top: 100),
            child: Text("No data"),
          )
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: [
        //       DataTable(columns: const [
        //         DataColumn(
        //           label: Text(
        //             'Channel',
        //             textAlign: TextAlign.center,
        //           ),
        //         ),
        //         DataColumn(
        //           label: Text(
        //             '%\nContribution',
        //             textAlign: TextAlign.center,
        //           ),
        //         ),
        //         DataColumn(
        //           label: Text(
        //             'Last\nMonth ACH',
        //             textAlign: TextAlign.center,
        //           ),
        //         ),
        //         DataColumn(
        //           label: Text(
        //             'TGT',
        //             textAlign: TextAlign.center,
        //           ),
        //         ),
        //       ], rows: const [])
        //     ],
        //   ),
        // )
        else
          const CusTable()
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
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              ref.read(selectedIndexProvider.notifier).state = 0;
            },
            child: Container(
              width: 82,
              height: 35,
              margin: const EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                color: selectedIndex == 0
                    ? AppColor.primaryColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: AppColor.primaryColor, width: 1.0),
              ),
              child: Center(
                child: Text(
                  'All',
                  style: TextStyle(
                    color: selectedIndex == 0 ? Colors.white : Colors.black,
                  ),
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
                      width: 82,
                      height: 35,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        color: selectedIndex == index + 1
                            ? AppColor.primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            color: AppColor.primaryColor, width: 1.0),
                      ),
                      child: Center(
                        child: Text(
                          buttons[index + 1],
                          style: TextStyle(
                            color: selectedIndex == index + 1
                                ? Colors.white
                                : Colors.black,
                          ),
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
