import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  setCurrentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }
}
