import 'package:e_commerce_app/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  String? _currentAddress;
  Position? _currentPosition;
  bool? _hasPermission;

  String? get currentAddress => _currentAddress;
  Position? get currentPosition => _currentPosition;
  bool? get hasPermission => _hasPermission;

  // Get current position
  Future<void> getCurrentPosition(BuildContext context) async {
    _hasPermission = await LocationService.handleLocationPermission(context);

    if (!hasPermission!) {
      return;
    }

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _currentPosition = position;
      getAddressFromLatLng(position);
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  // get address from lag ans long
  Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      _currentAddress =
          '${place.name},${place.subLocality},${place.street},${place.subAdministrativeArea},${place.locality},${place.postalCode},${place.country}';
      notifyListeners();
      print("location => $_currentAddress");
    }).catchError((e) {
      debugPrint("get address function error ${e.toString()}");
    });
  }
}
