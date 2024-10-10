import 'package:flutter/material.dart';
import 'package:wirdul_latif/screens/counter_screen/counter_screen.dart';
import 'package:wirdul_latif/screens/wird_section/home_screen/home_screen.dart';

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



  currentScreen() {
    switch (currentindex) {
      case 0:
        return HomeScreen();
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
        return HomeScreen();
    }
  }
}
