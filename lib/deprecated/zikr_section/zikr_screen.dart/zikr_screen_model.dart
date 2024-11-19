import 'package:flutter/material.dart';
import 'package:wirdul_latif/model/wird.dart';

class ZikrScreenModel with ChangeNotifier {
  List<Wird> wirdList = [
    Wird(
        wird: 'لا إله إلا الله',
        english: 'There is no god but Allah',
        count: 3, transliteration: ''),
    Wird(wird: 'لا ', english: 'There ', count: 3, transliteration: '')
  ];
  int currentPage = 0;
  PageController controller = PageController();
  int currentPageWirdCounted = 0;
  // here the wird.counted assigned because of ui not reflecting issue
  String TitleText = '';
  String percentageTracker = '';
  bool isCurrentZikrCompletedOrNot = false;

  ZikrScreenModel() {
    // wirdList = WirdulLatif.morningWird;
    controller.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    currentPage = controller.page?.round() ?? 0;
    currentPageWirdCounted = wirdList[currentPage].counted ?? 0;
    // isCurrentZikrCompletedOrNot = isCurrentZikrCompletedOrNotMethod();
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

    // percentageTracker = percentageTrackerMethod();

    notifyListeners();
  }

  String percentageTrackerMethod() {
    double calculated =
        (currentPageWirdCounted) / wirdList[currentPage].count * 100;
    return calculated.toStringAsFixed(0);
  }

  bool isCurrentZikrCompleted() {
    bool finalBool = wirdList[currentPage].completed ?? false;
    print(finalBool);
    print(wirdList[0].counted);
    print('lllll');
    print(wirdList[1].counted);

    return finalBool;
  }

  isCurrentZikrCompletedOrNotMethod() {
    return wirdList[currentPage].completed ?? false;
  }
}
