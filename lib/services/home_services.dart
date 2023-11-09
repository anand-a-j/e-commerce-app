import 'dart:convert';

import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/utils/api.dart';
import 'package:e_commerce_app/utils/error_handling.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeServices {
  Future<List<ProductModel>> fetchCategoryProducts(
      {required BuildContext context, required String category}) async {
    debugPrint("fetch product function called");
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    debugPrint("token ${userProvider.user.token}");
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products?category=$category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "GET, OPTIONS"
        },
      );

      debugPrint("response category statuscode => ${response.statusCode}");
      debugPrint("response category body => ${response.body}");

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              List<dynamic> result = jsonDecode(response.body);
              for (int i = 0; i < result.length; i++) {
                productList.add(
                  ProductModel.fromJson(
                    jsonEncode(result[i]),
                  ),
                );
              }
              debugPrint(
                  "response catefgory===> ${response.statusCode}=> ${response.body}");
            });
      }
    } catch (e) {
      debugPrint("get product-category error ==> ${e.toString()}");
      if (context.mounted) {
        showSnackBar(context, "No Internet Connection");
      }
    }
    return productList;
  }

  Future<List<ProductModel>> fetchDealOfTheDayProduct(
      {required BuildContext context}) async {
    debugPrint("fetch deal of the day function called");
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    debugPrint("token ${userProvider.user.token}");
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/deal-of-day'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "GET, OPTIONS"
        },
      );

      debugPrint("response category statuscode => ${response.statusCode}");
      debugPrint("response category body => ${response.body}");

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              List<dynamic> result = jsonDecode(response.body);
              for (int i = 0; i < result.length; i++) {
                productList.add(
                  ProductModel.fromJson(
                    jsonEncode(result[i]),
                  ),
                );
              }
              debugPrint(
                  "response catefgory===> ${response.statusCode}=> ${response.body}");
            });
      }
    } catch (e) {
      debugPrint("get product-category error ==> ${e.toString()}");
      if (context.mounted) {
        showSnackBar(context, "No Internet Connection");
      }
    }
    return productList;
  }

  Future<List<ProductModel>> fetchnewArrivalProduct(
      {required BuildContext context}) async {
    debugPrint("fetch deal of the day function called");
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    debugPrint("token ${userProvider.user.token}");
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/new-arrivals'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "GET, OPTIONS"
        },
      );

      debugPrint("response category statuscode => ${response.statusCode}");
      debugPrint("response category body => ${response.body}");

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              List<dynamic> result = jsonDecode(response.body);
              for (int i = 0; i < result.length; i++) {
                productList.add(
                  ProductModel.fromJson(
                    jsonEncode(result[i]),
                  ),
                );
              }
              debugPrint(
                  "response catefgory===> ${response.statusCode}=> ${response.body}");
            });
      }
    } catch (e) {
      debugPrint("get new arrial error ==> ${e.toString()}");
      if (context.mounted) {
        showSnackBar(context, "No Internet Connection");
      }
    }
    return productList;
  }
}
