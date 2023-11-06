import 'dart:convert';
import 'package:e_commerce_app/screens/home/screens/home_screen.dart';
import 'package:e_commerce_app/models/user.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/utils/api.dart';
import 'package:e_commerce_app/utils/error_handling.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // sign up user
  void signUpUser(
      {required BuildContext context,
      required String email,
      required String password,
      required String name}) async {
    try {
      UserModel user = UserModel(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          token: '',
          cart: []
          );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },
      );

      print("Response body:${res.body}");
      print("Status Code :${res.statusCode}");

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, "Account Created, Login with same credentials");
          });
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            final prefs = await SharedPreferences.getInstance();
            String token = jsonDecode(res.body)['token'];
            // ignore: use_build_context_synchronously
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString('x-auth-token', token);
            // ignore: use_build_context_synchronously
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
          });
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }

  // get user data
  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(Uri.parse("$uri/tokenIsValid"),
          headers: <String, String>{
            'Content-Type': 'application/json; charSet=UTF-8',
            'x-auth-token': token!
          });
      print(tokenRes.statusCode);
      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        // get user data
        http.Response userRes = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charSet=UTF-8',
              'x-auth-token': token
            });

        // ignore: use_build_context_synchronously
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }
}
