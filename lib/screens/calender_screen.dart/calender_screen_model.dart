import 'package:flutter/material.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:wirdul_latif/screens/home_screen/home_screen_model.dart';

class CalenderScreenModel with ChangeNotifier {
  int currentStreak = 0;
  Map<DateTime, int> morningDatesForStreaks = {};
  Map<DateTime, int> eveningDatesForStreaks = {};
  CalenderScreenModel(this.currentStreak) {
    morningDatesForStreaks = {
      for (var e in WirdulLatif.progressList)
        if (e.count! >= 10 && e.type == WirdType.morning.name)
          DateTime(e.time.year, e.time.month, e.time.day, 0, 0, 0, 0, 0):
              e.count!
    };

    eveningDatesForStreaks = {
      for (var e in WirdulLatif.progressList)
        if (e.count! >= 10 && e.type == WirdType.evening.name)
          DateTime(e.time.year, e.time.month, e.time.day, 0, 0, 0, 0, 0):
              e.count!
    };
  }

  List<DateTime> showMoreMorningDatesForStreaks = WirdulLatif.progressList
      .where((e) => e.count >= 10 && e.type == WirdType.morning.name)
      .map<DateTime>((e) => e.time as DateTime)
      .toList();

  List<DateTime> showMoreEveningDatesForStreaks = WirdulLatif.progressList
      .where((e) => e.count >= 10 && e.type == WirdType.evening.name)
      .map<DateTime>((e) => e.time as DateTime)
      .toList();
}
