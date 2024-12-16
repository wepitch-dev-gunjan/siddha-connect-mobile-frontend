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
