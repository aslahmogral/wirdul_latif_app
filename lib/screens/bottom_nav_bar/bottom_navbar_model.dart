import 'package:flutter/material.dart';
import 'package:wirdul_latif/screens/counter_screen/counter_screen.dart';
import 'package:wirdul_latif/screens/wird_section/home_screen/home_screen.dart';
import 'package:wirdul_latif/screens/wird_section/home_screen/home_screen_model.dart';
import 'package:wirdul_latif/deprecated/zikr_section/zikr_home_screen.dart/zikr_home_screen.dart';

class BottomNavbarModel with ChangeNotifier {
  BottomNavbarModel() {
    checkIsItMorningOrEvening();
  }
  int currentindex = 0;
  bool isMorning = false;

  List<BottomNavigationBarItem> bottonNavigationBarItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: 'Wird'),
    // BottomNavigationBarItem(
    //     icon: Icon(
    //       Icons.nightlight,
    //     ),
    //     label: 'Evening'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.fingerprint,
        ),
        label: 'Counter'),
    BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'motivation'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'settings'),
  ];

  onItemTapped(int index) {
    currentindex = index;
    notifyListeners();
  }

  checkIsItMorningOrEvening() {
    var now = DateTime.now();
    isMorning = now.hour >= 0 && now.hour < 12;
    isMorning ? currentindex = 0 : currentindex = 1;
    notifyListeners();
  }

  currentScreen() {
    switch (currentindex) {
      case 0:
        return HomeScreen(wirdType: isMorning ? WirdType.morning : WirdType.morning);
      // case 1:
      //   return Center(child: HomeScreen(wirdType:isMorning ? WirdType.morning : WirdType.evening));
      // case 2:
      //   return Center(child:ZikrHomeScreen());
       case 1:
        return Center(child:CounterScreen());
      case 2:
        return Center(
          child: Text('shorts'),
        );
      case 3:
        return Center(
          child: Text('setttings'),
        );
      default:
        return HomeScreen(wirdType: WirdType.morning);
    }
  }
}
