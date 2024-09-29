import 'package:flutter/material.dart';

class HomeScreenModel with ChangeNotifier {
  bool isNightMode = false;
  int currentindex = 0;

  swithDayOrNight() {
    isNightMode = !isNightMode;
    notifyListeners();
  }

  List<BottomNavigationBarItem> bottonNavigationBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.sunny,color: Colors.black,),label: 'Morning'),
    BottomNavigationBarItem(icon: Icon(Icons.nightlight,),label: 'Evening'),
    BottomNavigationBarItem(icon: Icon(Icons.bolt),label: 'motivation'),
    BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'settings'),
  ];

  onItemTapped(int index) {
    currentindex = index;
    notifyListeners();
  }
}
