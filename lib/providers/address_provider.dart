import 'dart:async';

import 'package:e_commerce_app/providers/location_provider.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/router.dart';
import 'package:e_commerce_app/screens/checkout/screen/checkout_screen.dart';
import 'package:e_commerce_app/services/address_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressProvider extends ChangeNotifier {
  final AddressServices addressServices = AddressServices();
  LocationProvider locationProvider = LocationProvider();

  final _addressFormKey = GlobalKey<FormState>();

  TextEditingController _homeController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;
  String _addressToBeUsed = '';

  get addressFormKey => _addressFormKey;
  TextEditingController get homeController => _homeController;
  TextEditingController get streetController => _streetController;
  TextEditingController get pincodeController => _pincodeController;
  TextEditingController get cityController => _cityController;
  TextEditingController get stateController => _stateController;
  TextEditingController get phoneController => _phoneController;
  bool get isLoading => _isLoading;
  String get addressToBeUsed => _addressToBeUsed;

  updateCurrentLocation(BuildContext context) async {
    bool isGetPosition = false;
    _isLoading = true;
    notifyListeners();

    isGetPosition = await locationProvider.getCurrentPosition(context);

    if (isGetPosition) {
      Timer(const Duration(seconds: 2), () {
        _homeController.text = locationProvider.place.name ?? '';
        _streetController.text = '${locationProvider.place.street ?? ''}';
        _cityController.text = locationProvider.place.locality ?? '';
        _stateController.text = locationProvider.place.administrativeArea ?? '';
        _pincodeController.text = locationProvider.place.postalCode ?? '';
      });

      _isLoading = false;
      notifyListeners();
    }
  }

  checkoutAddress(BuildContext context, double totalAmount) {
    var user = Provider.of<UserProvider>(context, listen: false).user;
    if (_addressFormKey.currentState!.validate()) {
      _addressToBeUsed =
          '''${user.name}\n${homeController.text}\n${streetController.text}\n${cityController.text},${stateController.text}\n${pincodeController.text}\nPh: ${phoneController.text}''';

      if (context.mounted) {
        addressServices.saveUserAddress(
            context: context, address: user.address);

        Navigator.pushNamed(context, CheckoutScreen.routeName,
            arguments: AddressArguments(totalAmount, addressToBeUsed));
      }
    }
  }
}
