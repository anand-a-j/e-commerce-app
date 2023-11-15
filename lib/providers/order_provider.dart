import 'package:e_commerce_app/models/order.dart';
import 'package:e_commerce_app/services/account_service.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  AccountService accountService = AccountService();

  bool _isLoading = false;
  List<Order> _orders = [];

  bool get isLoading => _isLoading;
  List<Order> get orders => _orders;

  void fetchOrder(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    _orders = await accountService.fetchOrderDetails(context: context);

    _isLoading = false;
    notifyListeners();
  }
}
