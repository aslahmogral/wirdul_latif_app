import 'package:flutter/material.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:wirdul_latif/model/wird.dart';

class WirdScreenModel with ChangeNotifier {
  List<Wird> wirdList = [];
  int currentPage = 0;
  PageController controller = PageController();
  String currentPageWirdCount = '';

  WirdScreenModel(arguments) {
    // print(arguments);
    // wirdList = WirdulLatif.morningWird;
    if (arguments['wird'] == 'morning') {
      wirdList = WirdulLatif.morningWird;
    } else if (arguments['wird'] == 'evening') {
      wirdList = WirdulLatif.eveningWird;
    }
  }
}
