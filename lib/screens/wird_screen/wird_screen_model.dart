import 'package:flutter/material.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:wirdul_latif/model/wird.dart';

class WirdScreenModel with ChangeNotifier {
  List<Wird> wirdList = [];
  int currentPage = 0;
  PageController controller = PageController();
  int currentPageWirdCounted =
      0; // here the wird.counted assigned because of ui not reflecting issue

  WirdScreenModel(arguments) {
    if (arguments['wird'] == 'morning') {
      wirdList = WirdulLatif.morningWird;
    } else if (arguments['wird'] == 'evening') {
      wirdList = WirdulLatif.eveningWird;
    }
    controller.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    currentPage = controller.page?.round() ?? 0;
    currentPageWirdCounted = wirdList[currentPage].counted ?? 0;
    notifyListeners();
  }

  thasbeehButtonClicked() {
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
}
