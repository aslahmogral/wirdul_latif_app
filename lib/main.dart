import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:wirdul_latif/deprecated/provider/wird_provider.dart';
import 'package:wirdul_latif/routes.dart';
import 'package:wirdul_latif/screens/bottom_nav_bar/bottomNavbar.dart';
import 'package:wirdul_latif/utils/constants.dart';
import 'package:wirdul_latif/utils/initialize.dart';
import 'package:wirdul_latif/utils/theme.dart';
import 'package:wirdul_latif/utils/theme_provider.dart';

void main() {
  WirdulLatif.initWird();
  Initialize();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );

  Animate.restartOnHotReload = true;
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final themeProvider = Provider.of<ThemeProvider>(context);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<WirdProvider>(
            create: (context) => WirdProvider.main(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Wird Al Latif',
          routes: AppRoutes.routes,
          theme: themeProvider.isDarkMode
              ? customTheme.darkTheme
              : customTheme.lightTheme,
          home: const BottomNavBar(),
        ));
  }
}
