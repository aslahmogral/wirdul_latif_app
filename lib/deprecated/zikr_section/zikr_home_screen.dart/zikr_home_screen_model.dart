import 'package:flutter/material.dart';
import 'package:wirdul_latif/model/zikr.dart';
import 'package:wirdul_latif/deprecated/zikr_section/zikr_list/zikr_list.dart';

class ZikrHomeScreenModel extends ChangeNotifier {
  List<Zikr> favouriteList = [];

  ZikrHomeScreenModel() {
    print(favouriteList);
  }

  goToZikrListScreen(context) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ZikrListScreen(
                  favouriteList: favouriteList,
                )));
    if (result != null) {
      favouriteList = result;
    }

    notifyListeners();
  }
}
