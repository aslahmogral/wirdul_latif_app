import 'package:flutter/material.dart';
import 'package:wirdul_latif/api/wirdul_latif_api.dart';
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
  String progressPercentage = '';

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

  Future<void> showPrayerRequest(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("A Humble Request 🙏"),
          content: Text(
            "Dear user,\n\nThis app was developed with love and dedication to make Wirdullateef accessible for everyone. We kindly request you to include me and my family in your prayers, asking Allah for blessings, health, and guidance.\n\nMay Allah accept your prayers and efforts. JazakAllah Khair!",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Okay",
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ],
        );
      },
    );
  }

  currentProgressColor() {
    switch (progress) {
      case progressType.start:
        return Colors.red;
      case progressType.continuee:
        return Colors.yellow;
      case progressType.complete:
        return Colors.green;
    }
  }

  currentProgressText() {
    switch (progress) {
      case progressType.start:
        return "Start ✨";
      case progressType.continuee:
        return 'Continue 🙏🏾 $progressPercentage ';
      case progressType.complete:
        return 'Completed 🤩';
    }
  }

  calculateStreak() {
    var dates = WirdulLatifApi.progressList
        .where(
            (element) => element.type == wirdType.name && element.count >= 10)
        .map((e) => DateTime(e.time.year, e.time.month, e.time.day))
        .toSet()
        .toList();

    dates.sort((a, b) => b.compareTo(a)); // Sort dates in descending order
    var currentDate = DateTime.now();
    var currentStreak = 0;

    if (dates.isEmpty) {
      currentStreaks = 0;
      notifyListeners();
      return;
    }

    if (dates.any((date) =>
        date.day == DateTime.now().day &&
        date.month == DateTime.now().month &&
        date.year == DateTime.now().year)) {
      for (var date in dates) {
        bool checkBreakDate = date.day == currentDate.day &&
            date.month == currentDate.month &&
            date.year == currentDate.year;
        if (checkBreakDate) {
          currentStreak++;
          currentDate = currentDate.subtract(Duration(days: 1));
        } else {
          break;
        }
      }
    } else {
      for (var date in dates) {
        var currentDate = DateTime.now().subtract(Duration(days: 1));
        bool checkBreakDate = date.day == currentDate.day &&
            date.month == currentDate.month &&
            date.year == currentDate.year;
        if (checkBreakDate) {
          currentStreak++;
          currentDate = currentDate.subtract(Duration(days: 1));
        } else {
          break;
        }
      }
    }

    // for (var date in dates) {
    //   bool isToday = date.day == currentDate.day &&
    //       date.month == currentDate.month &&
    //       date.year == currentDate.year;
    //   bool checkBreakDate = date.day == currentDate.day &&
    //       date.month == currentDate.month &&
    //       date.year == currentDate.year;
    //   if (checkBreakDate || isToday) {
    //     currentStreak++;
    //     currentDate = currentDate.subtract(Duration(days: 1));
    //   } else {
    //     break;
    //   }
    // }

    currentStreaks = currentStreak;
    notifyListeners();
  }

  checkProgress() async {
    var today = DateTime.now();
    var todayProgress = WirdulLatifApi.progressList.firstWhere(
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
    } else if (todayProgress.count < WirdulLatifApi.eveningWird.length - 1) {
      progress = progressType.continuee;
      progressPercentage =
          '${((todayProgress.count) / WirdulLatifApi.morningWird.length * 100).toStringAsFixed(0)} % ';
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
