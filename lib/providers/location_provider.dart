import 'package:e_commerce_app/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  String? _currentAddress;
  Position? _currentPosition;
  bool? _hasPermission;
  Placemark _place = Placemark();

  String? get currentAddress => _currentAddress;
  Position? get currentPosition => _currentPosition;
  bool? get hasPermission => _hasPermission;
  Placemark get place => _place;

  // Get current position
  Future<bool> getCurrentPosition(BuildContext context) async {
    bool isGetPosition = false;
    _hasPermission = await LocationService.handleLocationPermission(context);

    if (!hasPermission!) {
      return isGetPosition;
    }

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _currentPosition = position;
      getAddressFromLatLng(position);
      isGetPosition = true;
      return isGetPosition;
    }).catchError((e) {
      isGetPosition = false;
      debugPrint(e.toString());
    });
    return isGetPosition;
  }

  // get address from lag ans long
  Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      _place = placemarks[0];

      _currentAddress =
          '${_place.name},${_place.subLocality},${_place.street},${_place.subAdministrativeArea},${_place.locality},${_place.postalCode},${_place.country}';
      notifyListeners();

      print("location => $_currentAddress");
    }).catchError((e) {
      debugPrint("get address function error ${e.toString()}");
    });
  }
}
