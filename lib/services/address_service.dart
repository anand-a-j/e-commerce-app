import 'dart:convert';
import 'package:e_commerce_app/models/user.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/utils/api.dart';
import 'package:e_commerce_app/utils/error_handling.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddressServices {
  void saveUserAddress(
      {required BuildContext context, required String address}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },
        body: jsonEncode({'address': address}),
      );

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              debugPrint("Success address added ${response.body}");
              UserModel user = userProvider.user.copyWith(
                address: jsonDecode(response.body)['address'],
              );
              userProvider.setUserFromModel(user);
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'add product post err ${e.toString()}');
      }
    }
  }

  // place order---------------------------------------------------------
  void placeOrder(
      {required BuildContext context,
      required String address,
      required double totalAmount,
      required String paymentId}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    print(userProvider.user.cart);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/order'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "GET, OPTIONS"
        },
        body: jsonEncode({
          'cart': userProvider.user.cart,
          'address': address,
          'totalPrice': totalAmount,
          'paymentId':paymentId
        }),
      );

      debugPrint("response => ${response.statusCode}");
      debugPrint("response => ${response.body}");

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              showSnackBar(context, "Your order has been placed successfully",isError: false);
              UserModel user = userProvider.user.copyWith(
                cart: [],
              );
              userProvider.setUserFromModel(user);

              debugPrint(
                  "response orders===> ${response.statusCode}=> ${response.body}");
            });
      }
    } catch (e) {
      debugPrint("post order error ==> ${e.toString()}");
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }
}
