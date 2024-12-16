// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// // Providers for state management
// final locationMessageProvider =
//     StateProvider<String>((ref) => "Press the button to get location");
// final addressProvider =
//     StateProvider<String>((ref) => "Address will appear here");

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ProviderScope(
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Location Example',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: const LocationScreen(),
//       ),
//     );
//   }
// }

// class LocationScreen extends ConsumerWidget {
//   const LocationScreen({Key? key}) : super(key: key);

//   Future<Position> _determinePosition(
//       BuildContext context, WidgetRef ref) async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     // if (!serviceEnabled) {
//     //   ref.read(locationMessageProvider.notifier).state =
//     //       "Location services are disabled.";

//     //   throw Exception('Location services are disabled.');
//     // }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ref.read(locationMessageProvider.notifier).state =
//             "Location permissions are denied.";
//         return Future.error('Location permissions are denied.');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       ref.read(locationMessageProvider.notifier).state =
//           "Location permissions are permanently denied.";
//       throw Exception('Location permissions are permanently denied.');
//     }

//     return await Geolocator.getCurrentPosition(
//       locationSettings: const LocationSettings(
//         accuracy: LocationAccuracy.bestForNavigation,
//         distanceFilter: 10,
//       ),
//     );
//   }

//   Future<void> _getAddressFromLatLng(
//       double latitude, double longitude, WidgetRef ref) async {
//     try {
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(latitude, longitude);
//       log("Placemark: ${placemarks[1]}");
//       Placemark place = placemarks[1];

//       ref.read(addressProvider.notifier).state =
//           "${place.street}, ${place.subThoroughfare}, ${place.thoroughfare}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
//     } catch (e) {
//       ref.read(addressProvider.notifier).state = "Failed to get address: $e";
//     }
//   }

//   Future<void> _getLocation(BuildContext context, WidgetRef ref) async {
//     try {
//       Position position = await _determinePosition(context, ref);

//       // Check if the location is mocked
//       if (position.isMocked) {
//         ref.read(locationMessageProvider.notifier).state =
//             "Fake location detected!";
//         ref.read(addressProvider.notifier).state =
//             "Please disable mock location to get the real location.";
//         return;
//       }

//       await _getAddressFromLatLng(position.latitude, position.longitude, ref);

//       ref.read(locationMessageProvider.notifier).state =
//           "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
//     } catch (e) {
//       ref.read(locationMessageProvider.notifier).state = "Error: $e";
//       ref.read(addressProvider.notifier).state = "Failed to get location.";
//     }
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final locationMessage = ref.watch(locationMessageProvider);
//     final address = ref.watch(addressProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Location Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               locationMessage,
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             Text(
//               address,
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _getLocation(context, ref),
//               child: const Text('Get Location'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MyApp());
// }

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Location Example',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: LocationScreen(),
// //     );
// //   }
// // }

// // class LocationScreen extends StatefulWidget {
// //   @override
// //   _LocationScreenState createState() => _LocationScreenState();
// // }

// // class _LocationScreenState extends State<LocationScreen> {
// //   String _locationMessage = "Press the button to get location";
// //   String _address = "Address will appear here";

// //   Future<Position> _determinePosition() async {
// //     bool serviceEnabled;
// //     LocationPermission permission;

// //     // Check if location services are enabled
// //     // serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     // if (!serviceEnabled) {
// //     //   return Future.error('Location services are disabled.');
// //     // }

// //     // Check for permissions
// //     // permission = await Geolocator.checkPermission();
// //     // if (permission == LocationPermission.denied) {
// //     //   log("PErmisison$permission");
// //     //   permission = await Geolocator.requestPermission();
// //     //   if (permission == LocationPermission.denied) {
// //     //     log("Permission Denied");
// //     //     return Future.error('Location permissions are denied.');
// //     //   }
// //     // }

// //     // if (permission == LocationPermission.deniedForever) {
// //     //   return Future.error(
// //     //       'Location permissions are permanently denied, we cannot request permissions.');
// //     // }

// //     // If permissions are granted, get the position
// //     return await Geolocator.getCurrentPosition(
// //         locationSettings: AndroidSettings(
// //             accuracy: LocationAccuracy.best, distanceFilter: 10));
// //   }

// //   Future<void> _getAddressFromLatLng(double latitude, double longitude) async {
// //     try {
// //       List<Placemark> placemarks =
// //           await placemarkFromCoordinates(latitude, longitude);
// //       log("PlaceMark${placemarks[0]}");
// //       Placemark place = placemarks[0];

// //       setState(() {
// //         _address =
// //             "${place.street},${place.subThoroughfare}, ${place.thoroughfare}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
// //       });
// //     } catch (e) {
// //       setState(() {
// //         _address = "Failed to get address: $e";
// //       });
// //     }
// //   }

// //   void _getLocation() async {
// //     Position position = await _determinePosition();
// //     await _getAddressFromLatLng(position.latitude, position.longitude);

// //     setState(() {
// //       _locationMessage =
// //           "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Location Example'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             Text(
// //               _locationMessage,
// //               textAlign: TextAlign.center,
// //             ),
// //             const SizedBox(height: 20),
// //             Text(
// //               _address,
// //               textAlign: TextAlign.center,
// //             ),
// //             const SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: _getLocation,
// //               child: const Text('Get Location'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // import 'dart:developer';

// // import 'package:flutter/material.dart';
// // import 'package:location/location.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Altitude Demo',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: AltitudeScreen(),
// //     );
// //   }
// // }

// // class AltitudeScreen extends StatefulWidget {
// //   @override
// //   _AltitudeScreenState createState() => _AltitudeScreenState();
// // }

// // class _AltitudeScreenState extends State<AltitudeScreen> {
// //   double? _altitude;
// //   String _statusMessage = 'Fetching altitude data...';

// //   @override
// //   void initState() {
// //     super.initState();
// //     _getAltitude();
// //   }

// //   // Function to get altitude using location
// //   Future<void> _getAltitude() async {
// //     Location location = new Location();

// //     // Check if location services are enabled
// //     bool _serviceEnabled;
// //     PermissionStatus _permissionGranted;

// //     _serviceEnabled = await location.serviceEnabled();
// //     if (!_serviceEnabled) {
// //       _serviceEnabled = await location.requestService();
// //       if (!_serviceEnabled) {
// //         setState(() {
// //           _statusMessage = 'Location services are disabled.';
// //         });
// //         return;
// //       }
// //     }

// //     // Check for permissions
// //     _permissionGranted = await location.hasPermission();
// //     if (_permissionGranted == PermissionStatus.denied) {
// //       _permissionGranted = await location.requestPermission();
// //       if (_permissionGranted != PermissionStatus.granted) {
// //         setState(() {
// //           _statusMessage = 'Location permissions are denied';
// //         });
// //         return;
// //       }
// //     }

// //     // Fetch location and altitude
// //     try {
// //       LocationData locationData = await location.getLocation();
// //       log("locationData$locationData");
// //       setState(() {
// //         _altitude = locationData.speed;
// //         _statusMessage = 'Altitude: ${_altitude!.toStringAsFixed(2)} meters';
// //       });
// //     } catch (e) {
// //       setState(() {
// //         _statusMessage = 'Failed to get altitude: $e';
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Altitude Demo'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Text(
// //               _statusMessage,
// //               style: TextStyle(fontSize: 20),
// //               textAlign: TextAlign.center,
// //             ),
// //             SizedBox(height: 20),
// //             if (_altitude != null)
// //               Text('GPS Altitude: ${_altitude!.toStringAsFixed(2)} meters'),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// location_provider.dart
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

final locationMessageProvider =
    StateProvider<String>((ref) => "Press the button to get location");
final addressProvider =
    StateProvider<String>((ref) => "Address will appear here");
final isLoadingProvider = StateProvider<bool>((ref) => false);

class LocationService {
  final WidgetRef ref;

  LocationService(this.ref);

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ref.read(locationMessageProvider.notifier).state =
            "Location permissions are denied.";
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ref.read(locationMessageProvider.notifier).state =
          "Location permissions are permanently denied.";
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 10,
      ),
    );
  }

  Future<void> _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      log("Placemark: ${placemarks[1]}");
      Placemark place = placemarks[1];

      ref.read(addressProvider.notifier).state =
          "${place.street}, ${place.subThoroughfare}, ${place.thoroughfare}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
    } catch (e) {
      ref.read(addressProvider.notifier).state = "Failed to get address: $e";
    }
  }

  Future<void> getLocation() async {
    ref.read(isLoadingProvider.notifier).state = true;
    try {
      Position position = await _determinePosition();

      // Check if the location is mocked
      if (position.isMocked) {
        ref.read(locationMessageProvider.notifier).state =
            "Fake location detected!";
        ref.read(addressProvider.notifier).state =
            "Please disable mock location to get the real location.";
        return;
      }

      await _getAddressFromLatLng(position.latitude, position.longitude);

      ref.read(locationMessageProvider.notifier).state =
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
    } catch (e) {
      ref.read(locationMessageProvider.notifier).state = "Error: $e";
      ref.read(addressProvider.notifier).state = "Failed to get location.";
    } finally {
      ref.read(isLoadingProvider.notifier).state = false;
    }
  }
}
