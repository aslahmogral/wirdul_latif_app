import 'package:flutter/material.dart';
import 'package:wirdul_latif/model/wird_model.dart';
import 'package:wirdul_latif/service/wird_from_json.dart';

class WirdProvider with ChangeNotifier {
  List<WirdModel>? _wirddata;

  List<WirdModel>? get wirddata => _wirddata;

  Future<void> loadLocalJsonData() async {
    _wirddata = await WirdService().loadLocalJsonData();

    notifyListeners();
  }
}
