import 'package:flutter/material.dart';
import 'package:wirdul_latif/api/wirdul_latif_api.dart';
import 'package:wirdul_latif/screens/home_screen/home_screen_model.dart';
import 'package:wirdul_latif/api/firebase_analytics.dart';

class CalenderScreenModel with ChangeNotifier {
  int currentStreak = 0;
  Map<DateTime, int> morningDatesForStreaks = {};
  Map<DateTime, int> eveningDatesForStreaks = {};
  CalenderScreenModel(this.currentStreak) {
    FirbaseApi.screenTracker('calender screen');

    morningDatesForStreaks = {
      for (var e in WirdulLatifApi.progressList)
        if (e.count! >= 10 && e.type == WirdType.morning.name)
          DateTime(e.time.year, e.time.month, e.time.day, 0, 0, 0, 0, 0):
              e.count!
    };

    eveningDatesForStreaks = {
      for (var e in WirdulLatifApi.progressList)
        if (e.count! >= 10 && e.type == WirdType.evening.name)
          DateTime(e.time.year, e.time.month, e.time.day, 0, 0, 0, 0, 0):
              e.count!
    };
  }

  List<DateTime> showMoreMorningDatesForStreaks = WirdulLatifApi.progressList
      .where((e) => e.count >= 10 && e.type == WirdType.morning.name)
      .map<DateTime>((e) => e.time as DateTime)
      .toList();

  List<DateTime> showMoreEveningDatesForStreaks = WirdulLatifApi.progressList
      .where((e) => e.count >= 10 && e.type == WirdType.evening.name)
      .map<DateTime>((e) => e.time as DateTime)
      .toList();
}
