import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siddha_connect/auth/screens/splash_screen.dart';
import 'package:siddha_connect/utils/message.dart';
import 'package:siddha_connect/utils/navigation.dart';
import 'connectivity/connectivity_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: ScreenUtil.defaultSize,
      child: MaterialApp(
          navigatorKey: navigatorKey,
          scaffoldMessengerKey: snackbarKey,
          debugShowCheckedModeBanner: false,
          title: 'Siddha Connect',
          // home: const SplashScreen()
          home: const ConnectivityNotifier(
            child: SplashScreen(),
          ),
          ),
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:pagination_view/pagination_view.dart';
// import 'package:intl/intl.dart';

// class ExtractionOverview extends StatefulWidget {
//   @override
//   _ExtractionOverviewState createState() => _ExtractionOverviewState();
// }

// class _ExtractionOverviewState extends State<ExtractionOverview> {
//   List<Map<String, dynamic>> data = [];
//   bool loading = false;
//   String? error;
//   int page = 1;
//   int rowsPerPage = 100;
//   int totalRecords = 0;

//   // Filters
//   DateTime? startDate;
//   DateTime? endDate;
//   List<String> segment = [];
//   List<String> dealerCode = [];
//   List<String> tse = [];
//   List<String> type = [];
//   List<String> area = [];
//   List<String> tlName = [];
//   List<String> abm = [];
//   List<String> ase = [];
//   List<String> asm = [];
//   List<String> rso = [];
//   List<String> zsm = [];

//   bool valueToggle = true;
//   bool showShare = false;

//   // Dropdown options
//   List<String> segmentOptions = [];
//   List<String> dealerOptions = [];
//   List<String> tseOptions = [];
//   List<String> typeOptions = [];
//   List<String> areaOptions = [];
//   List<String> tlNameOptions = [];
//   List<String> abmOptions = [];
//   List<String> aseOptions = [];
//   List<String> asmOptions = [];
//   List<String> rsoOptions = [];
//   List<String> zsmOptions = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchDropdownData();
//   }

//   Future<void> fetchDropdownData() async {
//     setState(() {
//       loading = true;
//     });

//     try {
//       final responses = await Future.wait([
//         fetchUniqueValues('productId.Segment'),
//         fetchUniqueValues('dealerCode'),
//         fetchUniqueValues('uploadedBy'),
//         fetchUniqueValues('TYPE'),
//         fetchUniqueValues('Area'),
//         fetchUniqueValues('TL NAME'),
//         fetchUniqueValues('ABM'),
//         fetchUniqueValues('ASE'),
//         fetchUniqueValues('ASM'),
//         fetchUniqueValues('RSO'),
//         fetchUniqueValues('ZSM'),
//       ]);

//       setState(() {
//         segmentOptions = responses[0];
//         dealerOptions = responses[1];
//         tseOptions = responses[2];
//         typeOptions = responses[3];
//         areaOptions = responses[4];
//         tlNameOptions = responses[5];
//         abmOptions = responses[6];
//         aseOptions = responses[7];
//         asmOptions = responses[8];
//         rsoOptions = responses[9];
//         zsmOptions = responses[10];
//         loading = false;
//       });
//     } catch (err) {
//       setState(() {
//         error = 'Error fetching dropdown data';
//         loading = false;
//       });
//     }
//   }

//   Future<List<String>> fetchUniqueValues(String column) async {
//     final url = 'https://backend_url/extraction/unique-column-values?column=$column';
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final body = json.decode(response.body);
//       return List<String>.from(body['uniqueValues']);
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   Future<void> fetchData() async {
//     setState(() {
//       loading = true;
//       error = null;
//     });

//     try {
//       final valueVolume = valueToggle ? 'value' : 'volume';
//       final url = Uri.parse('https://backend_url/extraction/overview-for-admins');

//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final body = json.decode(response.body);
//         setState(() {
//           data = List<Map<String, dynamic>>.from(body['data']);
//           totalRecords = body['totalRecords'] ?? 0;
//           loading = false;
//         });
//       } else {
//         setState(() {
//           error = 'Failed to fetch data';
//           loading = false;
//         });
//       }
//     } catch (err) {
//       setState(() {
//         error = err.toString();
//         loading = false;
//       });
//     }
//   }

//   // Clear filters
//   void handleClearFilters() {
//     setState(() {
//       startDate = null;
//       endDate = null;
//       segment.clear();
//       dealerCode.clear();
//       tse.clear();
//       type.clear();
//       area.clear();
//       tlName.clear();
//       abm.clear();
//       ase.clear();
//       asm.clear();
//       rso.clear();
//       zsm.clear();
//     });
//     fetchData();
//   }

//   // Format number for Indian system
//   String formatNumberIndian(int number) {
//     final format = NumberFormat("#,##,###");
//     return format.format(number);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Extraction Overview'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Filters UI
//             // Use FormBuilder for Date Picker and Multi-select fields

//             // Data Table
//             Expanded(
//               child: loading
//                   ? CircularProgressIndicator()
//                   : data.isEmpty
//                       ? Text('No data available for the selected filters.')
//                       : SingleChildScrollView(
//                           child: DataTable(
//                             columns: ['Price Class', 'Samsung', 'Vivo', 'Oppo', 'Xiaomi', 'Apple', 'One Plus', 'Real Me', 'Motorola', 'Others', 'Rank of Samsung']
//                                 .map((col) => DataColumn(label: Text(col)))
//                                 .toList(),
//                             rows: data.map((row) {
//                               return DataRow(cells: [
//                                 DataCell(Text(row['Price Class'])),
//                                 // Repeat for each column
//                               ]);
//                             }).toList(),
//                           ),
//                         ),
//             ),
//             // Pagination
//             if (totalRecords > 0)
//               PaginationView(
//                 itemBuilder: (context, index) {
//                   // Pagination UI
//                 },
//                 pageFetch: (int offset) async {
//                   // Fetch data for pagination
//                 },
//                 onEmpty: () => Text('No more data available'),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

