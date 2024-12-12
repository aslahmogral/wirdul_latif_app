import 'dart:convert';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wirdul_latif/api/wirdul_latif_api.dart';
import 'package:wirdul_latif/model/progress.dart';
import 'package:wirdul_latif/model/wird.dart';
import 'package:wirdul_latif/screens/home_screen/home_screen_model.dart';
import 'package:wirdul_latif/utils/constants.dart';
import 'package:wirdul_latif/api/firebase_analytics.dart';

class WirdScreenModel with ChangeNotifier {
  List<Wird> wirdList = [];
  int currentPage = 0;
  PageController controller = PageController();
  int currentPageWirdCounted = 0;
  // here the wird.counted assigned because of ui not reflecting issue
  late WirdType type;
  String TitleText = '';
  bool tapHere = true;
  bool showTranslation = true;
  late Progress progressTracker =
      Progress(time: DateTime.now(), count: 0, type: type.name);
  ConfettiController confettiController = ConfettiController(
    duration: Duration(seconds: 1),
  );
  double arabicFontSize = 24.0;
  WirdScreenModel(WirdType wirdType) {
    FirbaseApi.screenTracker('wird screen');
    type = wirdType;
    initialize();
    progressInitialize();
    controller.addListener(_onPageChanged);
  }

  incrementFontSize(double fontsize) {
    arabicFontSize = fontsize;
    setFontSizeToSharedPref(arabicFontSize);
    notifyListeners();
  }

  setFontSizeToSharedPref(double fontsize) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontsize', fontsize);
  }

  Future<double> getFontSizeFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('fontsize') ?? 24.0;
  }

  void progressInitialize() {
    final oldProgress = WirdulLatifApi.progressList.firstWhere(
        (element) =>
            element.time.day == DateTime.now().day && element.type == type.name,
        orElse: () => Progress(time: DateTime.now(), count: 0, type: ''));

    if (oldProgress.type != '') {
      progressTracker = oldProgress;
      currentPage = progressTracker.count;
      controller = PageController(initialPage: currentPage);
    }
  }

  showTranslationClicked(val) {
    showTranslation = val;
    notifyListeners();
  }

  void _onPageChanged() {
    currentPage = controller.page?.round() ?? 0;
    currentPageWirdCounted = wirdList[currentPage].counted ?? 0;
    progressTracker =
        Progress(time: DateTime.now(), type: type.name, count: currentPage);
    notifyListeners();
  }

  bool checkIfCurrentWirdCompleted() {
    return wirdList[currentPage].count == wirdList[currentPage].counted;
  }

  showWarning(HomeScreenModel model, BuildContext context) async {
    if (currentPage < 10) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Warning'),
            content: const Text(
                'You haven\'t completed even 10 wird. Please complete at least 10 wird to maintain the streak'),
            actions: [
              TextButton(
                onPressed: () {
                  addAndRemoveDuplicateProgress(model);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text(
                  'No',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  addAndRemoveDuplicateProgress(model);
                },
                child: const Text(
                  'OK , I will Finish...',
                  style: TextStyle(),
                ),
              )
            ],
          );
        },
      );
    } else if (currentPage < (wirdList.length - 1)) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Warning'),
            content: const Text('Do you really want to exit?'),
            actions: [
              TextButton(
                onPressed: () {
                  addAndRemoveDuplicateProgress(model);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  addAndRemoveDuplicateProgress(model);
                  // canPop = true;
                },
                child: const Text(
                  'No , I will Finish...',
                  style: TextStyle(),
                ),
              )
            ],
          );
        },
      );
    } else {
      addAndRemoveDuplicateProgress(model);
      Navigator.pop(context);
    }
  }

  void addAndRemoveDuplicateProgress(HomeScreenModel model) async {
    final prefs = await SharedPreferences.getInstance();
    var oldProgress = WirdulLatifApi.progressList.firstWhere(
        (element) =>
            element.time.day == progressTracker.time.day &&
            element.type == progressTracker.type,
        orElse: () => Progress(time: DateTime.now(), count: 0, type: ''));
    if (oldProgress.type != '') {
      WirdulLatifApi.progressList.remove(oldProgress);
    }

    WirdulLatifApi.progressList.add(progressTracker);
    final progressListJson =
        WirdulLatifApi.progressList.map((e) => e.toJson()).toList();
    await prefs.setString('progress', jsonEncode(progressListJson));
    FirbaseApi.logWirdProgress(type.name, currentPage.toString());
  }

  thasbeehButtonClicked() {
    tapHere = false;
    if (wirdList[currentPage].counted == null) {
      wirdList[currentPage].counted = 0;
      wirdList[currentPage].completed = false;
    }

    if (wirdList[currentPage].completed == false) {
      wirdList[currentPage].counted = wirdList[currentPage].counted! + 1;
      currentPageWirdCounted = wirdList[currentPage].counted!;

      if (wirdList[currentPage].count == wirdList[currentPage].counted) {
        currentPageWirdCounted = 0;
        if (currentPage == (wirdList.length - 1)) {
          celebrateCompletion();
          notifyListeners();
        } else {
          controller.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        }

        wirdList[currentPage].completed = true;
      }
    } else {
      currentPageWirdCounted = 0;
      if (currentPage != (wirdList.length - 1)) {
        controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      } else {
        celebrateCompletion();
      }
    }

    notifyListeners();
  }

  initialize() async {
    // if (type == WirdType.morning) {
    //   setMorningDatas();
    // }

    // if (type == WirdType.evening) {
    //   setEveningDatas();
    // }
    wirdList = WirdulLatifApi.haddad;
    arabicFontSize = await getFontSizeFromSharedPref();
    notifyListeners();
  }

  double progressOfEachWird() {
    if (wirdList[currentPage].count == 1) {
      return 0;
    }

    return wirdList[currentPage].counted != null &&
            wirdList[currentPage].counted != 0
        ? (currentPageWirdCounted / wirdList[currentPage].count).toDouble()
        : 0;
  }

  // setMorningDatas() {
  //   wirdList = WirdulLatifApi.morningWird;
  //   TitleText = Constants.morning;
  // }

  // setEveningDatas() {
  //   wirdList = WirdulLatifApi.eveningWird;
  //   TitleText = Constants.evening;
  // }

  skipOrNextPage() {
    controller.nextPage(
        duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
  }

  undoOrPrevPage() {
    controller.previousPage(
        duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
  }

  celebrateCompletion() {
    confettiController.play();
    notifyListeners();
  }
}
