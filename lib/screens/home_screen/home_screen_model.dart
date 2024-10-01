import 'package:flutter/material.dart';
import 'package:wirdul_latif/screens/wird_screen/wird_screen.dart';
import 'package:wirdul_latif/utils.dart/constants.dart';

enum WirdType { morning, evening }

class HomeScreenModel with ChangeNotifier {
  bool isNightMode = false;
  int currentindex = 0;
  late BuildContext _context;
  late WirdType wirdType;
  String titleText = '';
  IconData wirdIcon = Icons.sunny;
  String mainImagePath = '';

  HomeScreenModel(BuildContext context, {required WirdType wirdType}) {
    _context = context;
    this.wirdType = wirdType;
    initialize();
  }

  onItemTapped(int index) {
    currentindex = index;
    notifyListeners();
  }

  navigateToWird() {
    Navigator.push(
        _context,
        MaterialPageRoute(
          builder: (context) => WirdScreen(
            wirdType: wirdType,
          ),
        ));
  }

  initialize() {
    if (wirdType == WirdType.morning) {
      setMorningDatas();
    } else {
      setEveningDatas();
    }
    notifyListeners();
  }

  setMorningDatas() {
    titleText = Constants.morning;
    wirdIcon = Icons.sunny;
    mainImagePath = 'asset/morning.jpg';
  }

  setEveningDatas() {
    titleText = Constants.evening;
    wirdIcon = Icons.nightlight;
    mainImagePath = 'asset/night.jpg';

  }
}
