import 'package:flutter/material.dart';

class CounterScreenStartModel with ChangeNotifier {
  int count = 0;
  int extraCount = 0;
  int counterNumber;
  bool extraAmountVisible = false;
  bool infinite = false;
  final FocusNode focusNode = FocusNode();

  CounterScreenStartModel(this.counterNumber) {
    if (counterNumber == 1000000000) {
      infinite = true;
      notifyListeners();
    }
  }
  void increment() {
    if (count < counterNumber) {
      count++;
      extraAmountVisible = false;
      notifyListeners();
    }
    if (count >= counterNumber) {
      extraCount++;
      extraAmountVisible = true;
      notifyListeners();
    }
  }

  reset() {
    count = 0;
    extraCount = 0;
    extraAmountVisible = false;
    notifyListeners();
  }

  changeCounterNumber(int counterNumber) {
    this.counterNumber = counterNumber;
    notifyListeners();
  }

  reload() {
    notifyListeners();
  }
}
