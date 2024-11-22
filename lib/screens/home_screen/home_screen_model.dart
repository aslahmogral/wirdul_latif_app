import 'package:flutter/material.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:wirdul_latif/model/progress.dart';
import 'package:wirdul_latif/screens/wird_screen/wird_screen.dart';
import 'package:wirdul_latif/utils/constants.dart';

enum WirdType { morning, evening }

enum progressType { start, continuee, complete }

class HomeScreenModel with ChangeNotifier {
  bool isNightMode = false;
  int currentindex = 0;
  late BuildContext _context;
  late WirdType wirdType;
  String titleText = '';
  IconData wirdIcon = Icons.sunny;
  String mainImagePath = '';
  bool isMorning = false;
  progressType progress = progressType.start;
  int currentStreaks = 0;

  HomeScreenModel(BuildContext context) {
    _context = context;
    checkIsItMorningOrEvening();
    initialize();
    checkProgress();
  }

  onItemTapped(int index) {
    currentindex = index;
    notifyListeners();
  }

  calculateStreak() {
    var dates = WirdulLatif.progressList
        .where((element) => element.type == wirdType.name && element.count >= 10)
        .map((e) => DateTime(e.time.year, e.time.month, e.time.day))
        .toSet()
        .toList();
    dates.sort((a, b) => b.compareTo(a)); // Sort dates in descending order
    var currentDate = DateTime.now();
    var currentStreak = 0;

    for (var date in dates) {
      if (date.isBefore(currentDate) || date.isAtSameMomentAs(currentDate)) {
        currentStreak++;
        currentDate = currentDate.subtract(Duration(days: 1));
      } else {
        break;
      }
    }

    currentStreaks = currentStreak;
    notifyListeners();
  }

  checkProgress() async {
    var today = DateTime.now();
    var todayProgress = WirdulLatif.progressList.firstWhere(
        (element) =>
            element.time.day == today.day &&
            element.time.month == today.month &&
            element.time.year == today.year &&
            element.type == wirdType.name,
        orElse: () => Progress(time: today, count: 0, type: ''));
    if (todayProgress.type == '') {
      progress = progressType.start;
    } else if (todayProgress.count == 0) {
      progress = progressType.start;
    } else if (todayProgress.count < WirdulLatif.eveningWird.length - 1) {
      progress = progressType.continuee;
    } else {
      progress = progressType.complete;
    }

    calculateStreak();
    notifyListeners();
  }

  navigateToWird() {
    Navigator.push(
        _context,
        MaterialPageRoute(
          builder: (context) => WirdScreen(
            wirdType: wirdType,
          ),
        )).then((value) {
      checkProgress();
    });
  }

  navigateToZikr() {
    // Navigator.push(
    //     _context,
    //     MaterialPageRoute(
    //       builder: (context) => ZikrScreen(),
    //     ));
  }

  checkIsItMorningOrEvening() {
    var now = DateTime.now();
    isMorning = now.hour >= 0 && now.hour < 12;
    isMorning ? wirdType = WirdType.morning : wirdType = WirdType.evening;
    changeTab(wirdType);
    notifyListeners();
  }

  changeWirdType() {
    isMorning = !isMorning;
    isMorning ? wirdType = WirdType.morning : wirdType = WirdType.evening;
    changeTab(wirdType);
    checkProgress();
    notifyListeners();
  }

  changeTab(WirdType wirdType) {
    this.wirdType = wirdType;
    initialize();
    notifyListeners();
  }

  initialize() {
    if (wirdType == WirdType.morning) {
      setMorningDatas();
    } else {
      setEveningDatas();
    }
    notifyListeners();
  }

  setMorningDatas() {
    titleText = Constants.morning;
    wirdIcon = Icons.sunny;
    mainImagePath = 'asset/morning.jpg';
  }

  setEveningDatas() {
    titleText = Constants.evening;
    wirdIcon = Icons.nightlight;
    mainImagePath = 'asset/night.jpg';
  }
}
