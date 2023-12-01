import 'package:flutter/material.dart';
import 'package:wirdul_latif/model/wird_model.dart';
import 'package:wirdul_latif/wird_files/wird_method.dart';

class SplashScreenModel with ChangeNotifier {
  late final List<WirdModel>? wirdList;

  List<WirdModel>? _wirddata;

  List<WirdModel>? get wirddata => _wirddata;

  Future<void> loadLocalJsonData() async {
    // _wirddata = await WirdService().loadLocalJsonData();
    for (int index = 1; index <= 44; index++) {
      _wirddata?.add(WirdModel(
          id: index,
          arabic: getWirdArabic(index: index),
          wirdRep: getWirdRepititionCount(index: index),
          rep: 0));
    }
    print(_wirddata);
    notifyListeners();
  }
}
