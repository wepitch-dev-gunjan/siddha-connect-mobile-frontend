import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siddha_connect/auth/screens/splash_screen.dart';

void main() {
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
    return const ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: ScreenUtil.defaultSize,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Siddha Connect',
        home: SplashScreen(),
      ),
    );
  }
}

// import 'dart:developer';

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Custom Radio Button'),
//         ),
//         body: CustomRadioButtonDemo(),
//       ),
//     );
//   }
// }

// class CustomRadioButtonDemo extends StatefulWidget {
//   @override
//   _CustomRadioButtonDemoState createState() => _CustomRadioButtonDemoState();
// }

// class _CustomRadioButtonDemoState extends State<CustomRadioButtonDemo> {
//   String _selectedValue = 'Option 1';

//   @override
//   Widget build(BuildContext context) {
//     log("Selected Value=>>>>>>$_selectedValue");
//     return Column(
//       children: <Widget>[
//         CustomRadioButton(
//           value: 'Option 1',
//           groupValue: _selectedValue,
//           onChanged: (value) {
//             setState(() {
//               _selectedValue = value!;
//             });
//           },
//         ),
//         CustomRadioButton(
//           value: 'Option 2',
//           groupValue: _selectedValue,
//           onChanged: (value) {
//             setState(() {
//               _selectedValue = value!;
//             });
//           },
//         ),
//         CustomRadioButton(
//           value: 'Option 3',
//           groupValue: _selectedValue,
//           onChanged: (value) {
//             setState(() {
//               _selectedValue = value!;
//             });
//           },
//         ),
//       ],
//     );
//   }
// }

