import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';

class NetworkService {
  void isDeviceOffline(BuildContext context) async {
    debugPrint("Network function called");
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none &&  context.mounted) {
      showSnackBar(context, "No Internet Connection");
    }
  }
}
