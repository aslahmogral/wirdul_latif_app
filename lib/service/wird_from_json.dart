import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:wirdul_latif/model/wird_model.dart';

class WirdService {
  Future<List<WirdModel>> loadLocalJsonData() async {
    String jsonString = await rootBundle.loadString('asset/wirddata.json');

    List<dynamic> jsonData = json.decode(jsonString);

    List<WirdModel> wirddata =
        jsonData.map((json) => WirdModel.fromJson(json)).toList();

    return wirddata;
  }
}
