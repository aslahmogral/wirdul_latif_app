import 'dart:convert';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:wirdul_latif/model/progress.dart';
import 'package:wirdul_latif/model/wird.dart';
import 'package:wirdul_latif/screens/home_screen/home_screen_model.dart';
import 'package:wirdul_latif/utils/constants.dart';
import 'package:wirdul_latif/widgets/firebase_analytics.dart';

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
    WfirebaseAnalytics.screenTracker('wird screen');
    type = wirdType;
    initialize();
    progressInitialize();
    controller.addListener(_onPageChanged);
  }

  void restart(BuildContext context) async {
    Navigator.pop(context);

    bool restart = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Warning'),
              content: const Text(
                  'If you restart now, you will loose all your previous progress and will start from the first wird'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    // addAndRemoveDuplicateProgress(model);
                    // Navigator.pop(context);

                    Navigator.pop(context, false);
                  },
                  child: const Text(
                    'Continue Wird',
                    // style: TextStyle(color: Colors.teal),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red)),
                  onPressed: () {
                    Navigator.pop(context, true);
                    // addAndRemoveDuplicateProgress(model);
                  },
                  child: const Text(
                    'Restart',
                    style: TextStyle(),
                  ),
                )
              ],
            );
          },
        ) ??
        false;
    if (!restart) {
      return;
    }
    currentPage = 0;
    currentPageWirdCounted = 0;
    progressTracker = Progress(time: DateTime.now(), count: 0, type: type.name);
    wirdList = [];
    await initialize();
    // await progressInitialize();
    // resetWirdCount();
    if (controller.positions.isNotEmpty) {
      controller.animateToPage(0,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
    notifyListeners();
  }

  resetWirdCount() {
    for (var element in wirdList) {
      element.counted = 0;
    }
    currentPageWirdCounted = 0;
    progressTracker = Progress(time: DateTime.now(), count: 0, type: type.name);
    notifyListeners();
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
    final oldProgress = WirdulLatif.progressList.firstWhere(
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

  void _onPageChanged() async {
    currentPage = controller.page?.round() ?? 0;
    currentPageWirdCounted = wirdList[currentPage].counted ?? 0;
    progressTracker =
        Progress(time: DateTime.now(), type: type.name, count: currentPage);

    addAndRemoveDuplicateProgress();

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
                  addAndRemoveDuplicateProgress();
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
                  addAndRemoveDuplicateProgress();
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
    } else if (currentPage < 43) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Warning'),
            content: const Text('Do you really want to exit?'),
            actions: [
              TextButton(
                onPressed: () {
                  addAndRemoveDuplicateProgress();
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
                  addAndRemoveDuplicateProgress();
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
      addAndRemoveDuplicateProgress();
      Navigator.pop(context);
    }
  }

  void addAndRemoveDuplicateProgress() async {
    final prefs = await SharedPreferences.getInstance();
    var oldProgress = WirdulLatif.progressList.firstWhere(
        (element) =>
            element.time.day == progressTracker.time.day &&
            element.type == progressTracker.type,
        orElse: () => Progress(time: DateTime.now(), count: 0, type: ''));
    if (oldProgress.type != '') {
      WirdulLatif.progressList.remove(oldProgress);
    }

    WirdulLatif.progressList.add(progressTracker);
    final progressListJson =
        WirdulLatif.progressList.map((e) => e.toJson()).toList();
    await prefs.setString('progress', jsonEncode(progressListJson));
    WfirebaseAnalytics.logWirdProgress(type.name, currentPage.toString());
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
        if (currentPage == 43) {
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
      if (currentPage != 43) {
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
    if (type == WirdType.morning) {
      setMorningDatas();
    }

    if (type == WirdType.evening) {
      setEveningDatas();
    }
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

  setMorningDatas() {
    wirdList =
        WirdulLatif.morningWird.map((e) => Wird.fromJson(e.toJson())).toList();
    TitleText = Constants.morning;
  }

  setEveningDatas() {
    wirdList =
        WirdulLatif.eveningWird.map((e) => Wird.fromJson(e.toJson())).toList();
    TitleText = Constants.evening;
  }

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
