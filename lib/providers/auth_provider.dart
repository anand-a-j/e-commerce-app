import 'package:e_commerce_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AuthService authService = AuthService();

  void signInUser(BuildContext context, String email, String password) {
    _isLoading = true;
    notifyListeners();

    authService.signInUser(context: context, email: email, password: password);

    _isLoading = false;
    notifyListeners();
  }
}
