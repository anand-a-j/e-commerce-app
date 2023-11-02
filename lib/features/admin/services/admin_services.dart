import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:e_commerce_app/features/admin/model/sales_model.dart';
import 'package:e_commerce_app/models/order.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/utils/api.dart';
import 'package:e_commerce_app/utils/error_handling.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  // sell products------------------------------------------------------------
  void sellProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required double quantity,
      required String category,
      required List<File> images}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      // Uploading images to Cloundinary Storage
      final cloudinary = CloudinaryPublic('dvlmszoxx', 'qrdldtox');

      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(response.secureUrl);
      }

      ProductModel product = ProductModel(
        name: name,
        description: description,
        quantity: quantity,
        price: price,
        images: imageUrls,
        category: category,
      );

      http.Response response = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },
        body: product.toJson(),
      );

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              debugPrint(
                  "response sellProduct===> ${response.statusCode}=> ${response.body}");
              showSnackBar(context, "Product Added successfully");
              Navigator.pop(context);
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'add product post err ${e.toString()}');
      }
    }
  }

  // fetch all products---------------------------------------------------------
  Future<List<ProductModel>> fetchAllProducts(BuildContext context) async {
    debugPrint("fetch product function called");
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    debugPrint("token ${userProvider.user.token}");
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "GET, OPTIONS"
        },
      );

      debugPrint("response => ${response.statusCode}");
      debugPrint("response => ${response.body}");

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
                  "response fetchAllProducts===> ${response.statusCode}=> ${response.body}");
            });
      }
    } catch (e) {
      debugPrint("get product error ==> ${e.toString()}");
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
    return productList;
  }

  // fetch all orders-----------------------------------------------------------
  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    debugPrint("fetch all orders function called");
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    // debugPrint("token ${userProvider.user.token}");
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/get-orders'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "GET, OPTIONS"
        },
      );

      debugPrint("response => ${response.statusCode}");
      debugPrint("response => ${response.body}");

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              List<dynamic> result = jsonDecode(response.body);
              for (int i = 0; i < result.length; i++) {
                orderList.add(
                  Order.fromJson(
                    jsonEncode(result[i]),
                  ),
                );
              }
              debugPrint(
                  "response fetchAllProducts===> ${response.statusCode}=> ${response.body}");
            });
      }
    } catch (e) {
      debugPrint("get order error ==> ${e.toString()}");
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
    return orderList;
  }

  // fetch all earning details-----------------------------------------------------------
  Future<Map<String, dynamic>> fetchEarnings(BuildContext context) async {
    debugPrint("fetch all analytics function called");
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarning = 0;

    // debugPrint("token ${userProvider.user.token}");
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/analytics'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "GET, OPTIONS"
        },
      );

      debugPrint("response => ${response.statusCode}");
      debugPrint("response => ${response.body}");

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              var res = jsonDecode(response.body);
              totalEarning = res['totalEarnings'];
              sales = [
                Sales('Mobiles', res['mobilesEarnings']),
                Sales('Essentials', res['essentialsEarnings']),
                Sales('Appliances', res['appliancesEarnings']),
                Sales('Books', res['booksEarnings']),
                Sales('Fashion', res['fashionEarnings']),
              ];
            });
      }
    } catch (e) {
      debugPrint("get order error ==> ${e.toString()}");
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
    return {
      'sales':sales,
      'totalEarnings':totalEarning
    };
  }

  // Delete a product-----------------------------------------------------------
  void deleteProduct(
      {required BuildContext context,
      required ProductModel product,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },
        body: jsonEncode({'id': product.id}),
      );

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              onSuccess();
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'add product post err ${e.toString()}');
      }
    }
  }

// change order status----------------------------------------------------------
  void changeOrderStatus(
      {required BuildContext context,
      required int status,
      required Order order,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },
        body: jsonEncode({'id': order.id}),
      );

      if (context.mounted) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              onSuccess();
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'add product post err ${e.toString()}');
      }
    }
  }
}
