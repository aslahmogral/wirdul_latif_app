import 'package:flutter/material.dart';
import 'package:wirdul_latif/screens/wird_section_screens/wird_screen/wird_screen.dart';
import 'package:wirdul_latif/utils/constants.dart';

enum WirdType { morning, evening }

class HomeScreenModel with ChangeNotifier {
  bool isNightMode = false;
  int currentindex = 0;
  late BuildContext _context;
  late WirdType wirdType;
  String titleText = '';
  IconData wirdIcon = Icons.sunny;
  String mainImagePath = '';
  bool isMorning = false;

  HomeScreenModel(BuildContext context) {
    _context = context;
    checkIsItMorningOrEvening();
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

  navigateToZikr() {
    // Navigator.push(
    //     _context,
    //     MaterialPageRoute(
    //       builder: (context) => ZikrScreen(),
    //     ));
  }

  checkIsItMorningOrEvening() {
    var now = DateTime.now();
    isMorning = now.hour >= 0 && now.hour < 12;
    isMorning ? wirdType = WirdType.morning : wirdType = WirdType.evening;
    changeTab(wirdType);
    notifyListeners();
  }

  changeWirdType(){
    isMorning = !isMorning;
    isMorning ? wirdType = WirdType.morning : wirdType = WirdType.evening;
    changeTab(wirdType);
    notifyListeners();
  }

  changeTab(WirdType wirdType) {
    this.wirdType = wirdType;
    initialize();
    notifyListeners();
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
