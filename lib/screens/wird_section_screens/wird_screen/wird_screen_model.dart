import 'package:flutter/material.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:wirdul_latif/model/wird.dart';
import 'package:wirdul_latif/screens/wird_section_screens/wird_home_screen/wird_home_screen_model.dart';
import 'package:wirdul_latif/utils/constants.dart';

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
  WirdScreenModel(WirdType wirdType) {
    type = wirdType;
    initialize();
    controller.addListener(_onPageChanged);
  }
  showTranslationClicked(val) {
    showTranslation = val;
    notifyListeners();
  }

  void _onPageChanged() {
    currentPage = controller.page?.round() ?? 0;
    currentPageWirdCounted = wirdList[currentPage].counted ?? 0;
    notifyListeners();
  }

  void closeButton(context) {
    tapHere = true;
    notifyListeners();
    Navigator.pop(context);
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
        controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
        wirdList[currentPage].completed = true;
      }
    } else {
      currentPageWirdCounted = 0;
      controller.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }

    notifyListeners();
  }

  initialize() {
    if (type == WirdType.morning) {
      setMorningDatas();
    }

    if (type == WirdType.evening) {
      setEveningDatas();
    }

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
    wirdList = WirdulLatif.morningWird;
    TitleText = Constants.morning;
  }

  setEveningDatas() {
    wirdList = WirdulLatif.eveningWird;
    TitleText = Constants.evening;
  }

  skipOrNextPage() {
    controller.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  undoOrPrevPage() {
    controller.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}