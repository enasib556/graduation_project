import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentPosition;
  String? _currentCountryName;

  Position? get currentPosition => _currentPosition;
  String? get currentCountryName => _currentCountryName;

  Future<void> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Optionally show a dialog to the user to enable location services
        // ignore: avoid_print
        print('Location services are disabled.');
        return;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          // Optionally show a dialog to the user to grant location permissions
          // ignore: avoid_print
          print('Location permission denied.');
          return;
        }
      }

      // Get current position
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Print latitude and longitude for debugging
      // ignore: avoid_print
      print('Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}');

      // Get country name from position
      _currentCountryName =
          await _getCountryNameFromPosition(_currentPosition!);

      // Notify listeners to update UI
      notifyListeners();
    } catch (e) {
      // Handle exceptions
      // ignore: avoid_print
      print('Error getting location: $e');
    }
  }

  Future<String?> _getCountryNameFromPosition(Position position) async {
    try {
      // Get placemarks from coordinates
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      // Print placemarks for debugging
      // ignore: avoid_print
      print('Placemarks: $placemarks');

      // Return the country name if available
      if (placemarks.isNotEmpty) {
        return placemarks[0].country;
      } else {
        return 'Unknown';
      }
    } catch (e) {
      // Handle exceptions
      // ignore: avoid_print
      print('Error getting country name: $e');
      return 'Unknown';
    }
  }
}
