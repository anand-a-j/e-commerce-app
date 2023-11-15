import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/services/search_services.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  SearchServices searchServices = SearchServices();

  bool _isLoading = false;
  List<ProductModel>? _productList = [];

  bool get isLoading => _isLoading;
  List<ProductModel>? get productList => _productList;

  void fetchSearchedProducts(BuildContext context, String search) async {
    _isLoading = true;
    notifyListeners();

    _productList = await searchServices.fetchSearchProducts(
        context: context, searchQuery: search);

    _isLoading = false;
    notifyListeners();
  }
}
