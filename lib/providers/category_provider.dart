import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/models/rating.dart';
import 'package:e_commerce_app/services/home_services.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  HomeServices homeServices = HomeServices();

  bool _isLoading = false;
  List<ProductModel> _productList = [];

  bool get isLoading => _isLoading;
  List<ProductModel> get productList => _productList;

  void fetchCategoryProducts(BuildContext context, String category) async {
    _isLoading = true;
    notifyListeners();

    _productList = await homeServices.fetchCategoryProducts(
        context: context, category: category);

    _isLoading = false;
    notifyListeners();
  }

  double calculateAvgRating(List<Rating>? rating) {
    double totalRating = 0;
    double avgRating = 0;

    if (rating != null) {
      for (int i = 0; i < rating.length; i++) {
        totalRating += rating[i].rating;
      }
      if (totalRating != 0) {
        avgRating = totalRating / rating.length;
        return avgRating;
      }
    } 
      avgRating = 0.0;
      return avgRating;
  }
}
