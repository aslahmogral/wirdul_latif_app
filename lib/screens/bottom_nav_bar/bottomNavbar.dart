import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/screens/bottom_nav_bar/bottom_navbar_model.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavbarModel()),
      ],
      child: Consumer<BottomNavbarModel>(
        builder: (context, model, child) {
          return Scaffold(
            body: model.currentScreen(),
            bottomNavigationBar: BottomNavigationBar(
              items: model.bottonNavigationBarItems,
              currentIndex: model.currentindex,
              onTap: model.onItemTapped,
            ),
          );
        },
      ),
    );
  }
}
