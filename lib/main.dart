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
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
          home: SplashScreen()
          // home: const ConnectivityNotifier(
          //   child: SplashScreen(),
          // ),
          ),
      // home:const  SplashScreen(),
    );
  }
}

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart'; // Import the geocoding package

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Location Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LocationScreen(),
//     );
//   }
// }

// class LocationScreen extends StatefulWidget {
//   @override
//   _LocationScreenState createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   String _locationMessage = "Press the button to get location";
//   String _address = "Address will appear here";

//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     // Check for permissions
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied.');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     // If permissions are granted, get the position
//     return await Geolocator.getCurrentPosition();
//   }

//   Future<void> _getAddressFromLatLng(double latitude, double longitude) async {
//     try {
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(latitude, longitude);
//       log("PlaceMark${placemarks[0]}");
//       Placemark place = placemarks[0];

//       setState(() {
//         _address =
//             "${place.street},${place.thoroughfare}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
//       });
//     } catch (e) {
//       setState(() {
//         _address = "Failed to get address: $e";
//       });
//     }
//   }

//   void _getLocation() async {
//     Position position = await _determinePosition();
//     await _getAddressFromLatLng(position.latitude, position.longitude);

//     setState(() {
//       _locationMessage =
//           "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Location Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               _locationMessage,
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             Text(
//               _address,
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _getLocation,
//               child: const Text('Get Location'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:location/location.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Altitude Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: AltitudeScreen(),
//     );
//   }
// }

// class AltitudeScreen extends StatefulWidget {
//   @override
//   _AltitudeScreenState createState() => _AltitudeScreenState();
// }

// class _AltitudeScreenState extends State<AltitudeScreen> {
//   double? _altitude;
//   String _statusMessage = 'Fetching altitude data...';

//   @override
//   void initState() {
//     super.initState();
//     _getAltitude();
//   }

//   // Function to get altitude using location
//   Future<void> _getAltitude() async {
//     Location location = new Location();

//     // Check if location services are enabled
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;

//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         setState(() {
//           _statusMessage = 'Location services are disabled.';
//         });
//         return;
//       }
//     }

//     // Check for permissions
//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         setState(() {
//           _statusMessage = 'Location permissions are denied';
//         });
//         return;
//       }
//     }

//     // Fetch location and altitude
//     try {
//       LocationData locationData = await location.getLocation();
//       log("locationData$locationData");
//       setState(() {
//         _altitude = locationData.speed;
//         _statusMessage = 'Altitude: ${_altitude!.toStringAsFixed(2)} meters';
//       });
//     } catch (e) {
//       setState(() {
//         _statusMessage = 'Failed to get altitude: $e';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Altitude Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               _statusMessage,
//               style: TextStyle(fontSize: 20),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20),
//             if (_altitude != null)
//               Text('GPS Altitude: ${_altitude!.toStringAsFixed(2)} meters'),
//           ],
//         ),
//       ),
//     );
//   }
// }
