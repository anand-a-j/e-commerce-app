import 'package:e_commerce_app/screens/login/screen/sign_in_screen.dart';
import 'package:e_commerce_app/services/auth_service.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:e_commerce_app/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService authService = AuthService();

  bool _isLoading = false;
  bool _isPass = false;

  bool get isLoading => _isLoading;
  bool get isPass => _isPass;

  setIsPass(bool value) {
    _isPass = value;
    notifyListeners();
  }

  void signUpUser(
      {required BuildContext context,
      required String username,
      required String email,
      required String password}) async {
    _isLoading = true;
    notifyListeners();

    var isSignUp = await authService.signUpUser(
        context: context, email: email, password: password, name: username);

    if (isSignUp && context.mounted) {
      showSnackBar(context, "Account Created, Login with same credentials",
          isError: false);
      Navigator.pushReplacementNamed(context, SignInScreen.routeName);

      _isLoading = false;
      notifyListeners();
    } else {
      _isLoading = false;
      notifyListeners();
    }
  }

// sign in user
  void signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    _isLoading = true;
    notifyListeners();

    var isSignIn = await authService.signInUser(
        context: context, email: email, password: password);

    if (isSignIn && context.mounted) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const BottomNavBar()));

      _isLoading = false;
      notifyListeners();
    } else {
      _isLoading = false;
      notifyListeners();
    }
  }
}
