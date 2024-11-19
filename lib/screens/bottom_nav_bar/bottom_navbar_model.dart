import 'package:flutter/material.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:wirdul_latif/screens/counter_screen/counter_screen.dart';
import 'package:wirdul_latif/screens/reels_screen/youtube_reels.dart';
import 'package:wirdul_latif/screens/settings_screen/settings_screen.dart';
import 'package:wirdul_latif/screens/wird_section_screens/wird_home_screen/wird_home_screen.dart';

class BottomNavbarModel with ChangeNotifier {
  BottomNavbarModel() {
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
          Icons.adjust,
        ),
        label: 'Counter'),
    BottomNavigationBarItem(
        icon: Icon(Icons.smart_display), label: 'motivation'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'settings'),
  ];

  onItemTapped(int index) {
    currentindex = index;
    notifyListeners();
  }

  currentScreen() {
    switch (currentindex) {
      case 0:
        return HomeScreen();
      // case 1:
      //   return Center(child: HomeScreen(wirdType:isMorning ? WirdType.morning : WirdType.evening));
      // case 2:
      //   return Center(child:ZikrHomeScreen());
      case 1:
        return Center(child: CounterScreen());
      case 2:
        return Center(
          child: YoutubeReelsScreen(),
        );
      case 3:
        return SettingsScreen();
      default:
        return HomeScreen();
    }
  }
}
