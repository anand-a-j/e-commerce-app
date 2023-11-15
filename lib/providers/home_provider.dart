import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/services/home_services.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<ProductModel> _dealOfTheDay = [];
  List<ProductModel> _newArrival = [];

  bool get isLoading => _isLoading;
  List<ProductModel> get dealOfTheDay => _dealOfTheDay;
  List<ProductModel> get newArrival => _newArrival;

  final HomeServices homeServices = HomeServices();

  void setDealOfTheDay(List<ProductModel> dealOfTheDay) {
    _dealOfTheDay = dealOfTheDay;
  }

  void getDealOfTheDayProducts(BuildContext context) async {
    _isLoading = true;

    _dealOfTheDay =
        await homeServices.fetchDealOfTheDayProduct(context: context);

    _isLoading = false;
    notifyListeners();
  }

  void getNewArrivalProducts(BuildContext context) async {
    _isLoading = true;

    _newArrival = await homeServices.fetchnewArrivalProduct(context: context);

    _isLoading = false;
    notifyListeners();
  }
}
