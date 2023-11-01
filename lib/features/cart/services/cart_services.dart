import 'dart:convert';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/models/user.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/utils/api.dart';
import 'package:e_commerce_app/utils/error_handling.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CartServices {
  void removeFromCart({
    required BuildContext context,
    required ProductModel product,
    // required double quantity
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      debugPrint("product id ==> ${product.id}");

      http.Response response = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${product.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },
      );

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              UserModel user = userProvider.user
                  .copyWith(cart: jsonDecode(response.body)['cart']);
              userProvider.setUserFromModel(user);
              debugPrint(
                  "response addToProduct===> ${response.statusCode}=> ${response.body}");
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'rate product post err ${e.toString()}');
      }
    }
  }

  void rateProducts(
      {required BuildContext context,
      required ProductModel product,
      required double rating}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      debugPrint("product id ==> ${product.id}");

      http.Response response = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },
        body: jsonEncode({'id': product.id!, 'rating': rating}),
      );

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              debugPrint(
                  "response rateProduct===> ${response.statusCode}=> ${response.body}");
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'rate product post err ${e.toString()}');
      }
    }
  }
}
