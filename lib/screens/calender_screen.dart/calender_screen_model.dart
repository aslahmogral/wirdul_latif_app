import 'package:flutter/material.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:wirdul_latif/screens/home_screen/home_screen_model.dart';

class CalenderScreenModel with ChangeNotifier {
  int currentStreak = 0;
  CalenderScreenModel(this.currentStreak){

  }
  List<DateTime> morningDatesForStreaks = WirdulLatif.progressList
      .where((e) => e.count >= 10 && e.type == WirdType.morning.name)
      .map<DateTime>((e) => e.time as DateTime)
      .toList();

  List<DateTime> eveningDatesForStreaks = WirdulLatif.progressList
      .where((e) => e.count >= 10 && e.type == WirdType.evening.name)
      .map<DateTime>((e) => e.time as DateTime)
      .toList();
}
