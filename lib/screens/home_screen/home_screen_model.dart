import 'package:flutter/material.dart';

class HomeScreenModel with ChangeNotifier {
  bool isNightMode = false;

  swithDayOrNight() {
    isNightMode = !isNightMode;
    notifyListeners();
  }
}
