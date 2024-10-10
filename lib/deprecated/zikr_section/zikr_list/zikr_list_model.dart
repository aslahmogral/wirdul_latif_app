import 'package:flutter/material.dart';
import 'package:wirdul_latif/model/zikr.dart';

class ZikrListModel with ChangeNotifier {
  List<Zikr> favouriteList = [];
  List<Zikr> ZikrList = [
    Zikr(
        zikr: 'الل هُ أَكْبَرُ',
        english: 'Allahu Akbar (Allah is the greatest)',
        count: 3,
        isFavorite: false),
    Zikr(
        zikr: 'سُبْحَنَ الل هِ',
        english: 'Subhan Allah (Glory to Allah)',
        count: 33,
        isFavorite: false),
    Zikr(
      zikr: 'الْحَمْدُ لِل هِ',
      english: 'Alhamdu lillah (Praise be to Allah)',
      count: 33,
      isFavorite: false,
    ),
  ];
  ZikrListModel(List<Zikr> favList) {
    favouriteList.addAll(favList);
    notifyListeners();
  }

  addToFavourite({required bool isFavorite, required Zikr zikr}) {
    bool isFav = favouriteList.contains(zikr);
    checkBoxValue(zikr);
    if (!isFav) {
      favouriteList.add(zikr);
    } else {
      favouriteList.remove(zikr);
    }
    notifyListeners();
  }

  bool checkBoxValue(Zikr e) {
    bool value = favouriteList.contains(e);
    ZikrList.where((element) => element.isFavorite == value).toList();
    notifyListeners();
    return value;
  }
}
