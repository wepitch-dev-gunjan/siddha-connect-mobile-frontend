// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:siddha_connect/salesDashboard/component/tabels.dart';
// import '../../utils/fields.dart';
// import '../../utils/providers.dart';
// import '../repo/sales_dashboard_repo.dart';

// final tseProvider = StateProvider<String?>((ref) => null);

// final segmentDataProvider = FutureProvider.autoDispose((ref) async {
//   final options = ref.watch(selectedOptionsProvider);
//   final getTseData = await ref.watch(salesRepoProvider).segmentWiseData(
//       tdFormat: options.tdFormat,
//       dataFormat: options.dataFormat,
//       firstDate: options.firstDate,
//       lastDate: options.lastDate,
//       name: options.name,
//       position: options.position
//       );
//   return getTseData;
// });



// class OpenDropDawn extends ConsumerStatefulWidget {
//   const OpenDropDawn({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _TSETabelState();
// }

// class _TSETabelState extends ConsumerState<OpenDropDawn> {
//   @override
//   Widget build(BuildContext context) {
//     final getSubordinates = ref.watch(subordinateProvider);
//     final segment = ref.watch(segmentDataProvider);

//     return Padding(
//       padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
//       child: Column(
//         children: [
//           getSubordinates.when(
//             data: (data) {
//               List<String> tseList = List<String>.from(data['TSE']);
//               return DropdownButtonFormField<String>(
//                 style: const TextStyle(
//                     fontSize: 16.0, height: 1.5, color: Colors.black87),
//                 decoration: InputDecoration(
//                     fillColor: const Color(0XFFfafafa),
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 8.0, horizontal: 12.0),
//                     errorStyle: const TextStyle(color: Colors.red),
//                     labelStyle: const TextStyle(
//                         fontSize: 15.0,
//                         color: Colors.black54,
//                         fontWeight: FontWeight.w500),
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: const BorderSide(
//                           color: Colors.black12,
//                         )),
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: const BorderSide(
//                         color: Colors.red, // Error border color
//                         width: 1,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: const BorderSide(
//                             color: Color(0xff1F0A68), width: 1)),
//                     labelText: "TSE",
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide:
//                             const BorderSide(color: Colors.amber, width: 0.5))),
//                 value: selectedPosition,
//                 onChanged: (newValue) {
//                   ref.read(selectedPositionProvider.notifier).state = newValue;
//                 },
//                 items: tseList.map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 validator: validatePosition,
//               );
//             },
//             error: (error, stackTrace) => const Text("Error loading TSE data"),
//             loading: () => const CircularProgressIndicator(),
//           ),
//         ],
//       ),
//     );
//   }
// }
