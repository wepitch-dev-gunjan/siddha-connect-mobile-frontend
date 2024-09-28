
//===================================! Dealer KRO NPO Buttons !==================

// final selectedDealerProvider = StateProvider<String>((ref) => "");
// final selectedOptionProvider = StateProvider<String>((ref) => "ALL");

// class DealerSelectionDropdown extends ConsumerWidget {
//   const DealerSelectionDropdown({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedOption = ref.watch(selectedOptionProvider);
//     final selectedDealer = ref.watch(selectedDealerProvider);
//     List<String> dealers = ["Dealer 1", "Dealer 2", "Dealer 3"];

//     String dropdownLabel = selectedDealer.isEmpty
//         ? selectedOption
//         : "$selectedOption/$selectedDealer";

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         DropdownButtonFormField<String>(
//           value: selectedOption,
//           style: const TextStyle(
//               fontSize: 16.0, height: 1.5, color: Colors.black87),
//           decoration: InputDecoration(
//               fillColor: const Color(0XFFfafafa),
//               contentPadding:
//                   const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//               errorStyle: const TextStyle(color: Colors.red),
//               labelStyle: const TextStyle(
//                   fontSize: 15.0,
//                   color: Colors.black54,
//                   fontWeight: FontWeight.w500),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: const BorderSide(
//                     color: Colors.black12,
//                   )),
//               errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: const BorderSide(
//                   color: Colors.red,
//                   width: 1,
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide:
//                       const BorderSide(color: Color(0xff1F0A68), width: 1)),
//               labelText: dropdownLabel,
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide:
//                       const BorderSide(color: Colors.amber, width: 0.5))),
//           onChanged: (String? newValue) {
//             _showPopup(context, ref, newValue!, dealers);
//             // if (newValue != "ALL") {

//             // }
//             ref.read(selectedOptionProvider.notifier).state =
//                 newValue!; // Update selectedOption
//             ref.read(selectedDealerProvider.notifier).state =
//                 ""; // Reset selected dealer when a new option is selected
//           },
//           items: const [
//             DropdownMenuItem(value: "ALL", child: Text("ALL")),
//             DropdownMenuItem(value: "KRO", child: Text("KRO")),
//             DropdownMenuItem(value: "NPO", child: Text("NPO")),
//           ],
//         ),
//         // if (selectedDealer.isNotEmpty)
//         //   Padding(
//         //     padding: const EdgeInsets.all(8.0),
//         //     child: Text("Selected Dealer: $selectedDealer"),
//         //   ),
//       ],
//     );
//   }

//   void _showPopup(
//       BuildContext context, WidgetRef ref, String name, List<String> dealers) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("$name Options"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Consumer(
//                 builder: (context, ref, child) {
//                   return ListTile(
//                     title: const Text("View List"),
//                     onTap: () {
//                       Navigator.pop(context);
//                       _showDealers(context, ref, name, dealers, "List");
//                     },
//                   );
//                 },
//               ),
//               ListTile(
//                 title: const Text("View Report"),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _showDealers(context, ref, name, dealers, "Report");
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _showDealers(BuildContext context, WidgetRef ref, String name,
//       List<String> dealers, String type) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("$name - $type"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: dealers
//                 .map((dealer) => ListTile(
//                       title: Text(dealer),
//                       onTap: () {
//                         ref.read(selectedDealerProvider.notifier).state =
//                             dealer; // Update selected dealer

//                         Navigator.pop(context); // Close the popup automatically
//                       },
//                     ))
//                 .toList(),
//           ),
//         );
//       },
//     );
//   }
// }














// final selectedDealerProvider = StateProvider<String>((ref) => "");
// final selectedOptionProvider = StateProvider<String>((ref) => "ALL");

// class DealerSelectionDropdown extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedOption = ref.watch(selectedOptionProvider); // Watch the provider for selected option
//     final selectedDealer = ref.watch(selectedDealerProvider); // Watch the provider for selected dealer
//     List<String> dealers = ["Dealer 1", "Dealer 2", "Dealer 3"];

//     // Create a label to show in the DropdownButton: "Option/Dealer"
//     String dropdownLabel = selectedDealer.isEmpty
//       ? selectedOption // Show only option if no dealer selected
//       : "$selectedOption/$selectedDealer"; // Show option/dealer if dealer is selected

//     return

//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             DropdownButton<String>(
//               value: selectedOption, // Use selectedOption for dropdown value
//               items: [
//                 DropdownMenuItem(child: Text("ALL"), value: "ALL"),
//                 DropdownMenuItem(child: Text("KRO"), value: "KRO"),
//                 DropdownMenuItem(child: Text("NPO"), value: "NPO"),
//               ],
//               onChanged: (String? newValue) {
//                 if (newValue != "ALL") {
//                   _showPopup(context, ref, newValue!, dealers);
//                 }
//                 ref.read(selectedOptionProvider.notifier).state = newValue!; // Update selectedOption
//                 ref.read(selectedDealerProvider.notifier).state = ""; // Reset selected dealer when a new option is selected
//               },
//               // Display combined label (Option/Dealer) in the button
//               hint: Text(dropdownLabel),
//             ),
//             if (selectedDealer.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text("Selected Dealer: $selectedDealer"),
//               ),
//           ],
//         );

//   }

//   void _showPopup(BuildContext context, WidgetRef ref, String name, List<String> dealers) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("$name Options"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 title: Text("View List"),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _showDealers(context, ref, name, dealers, "List");
//                 },
//               ),
//               ListTile(
//                 title: Text("View Report"),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _showDealers(context, ref, name, dealers, "Report");
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _showDealers(BuildContext context, WidgetRef ref, String name, List<String> dealers, String type) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("$name - $type"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: dealers
//                 .map((dealer) => ListTile(
//                       title: Text(dealer),
//                       onTap: () {
//                         ref.read(selectedDealerProvider.notifier).state = dealer; // Update selected dealer
//                         print("Selected Dealer: ${ref.read(selectedDealerProvider)}"); // Log the selected dealer
//                         Navigator.pop(context); // Close the popup automatically
//                       },
//                     ))
//                 .toList(),
//           ),
//         );
//       },
//     );
//   }
// }

