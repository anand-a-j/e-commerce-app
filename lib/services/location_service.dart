import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  // handle location permissions
 static Future<bool> handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled && context.mounted) {
      showSnackBar(context,
          'Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied && context.mounted) {
        showSnackBar(context, 'Location permission denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever && context.mounted) {
      showSnackBar(context,
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  // Get user’s latitude and longitude
 static Future<Position> getUserLongAndLati() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}
