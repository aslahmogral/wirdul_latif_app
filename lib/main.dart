import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/firebase_options.dart';
import 'package:wirdul_latif/routes.dart';
import 'package:wirdul_latif/screens/splash_screen/splash_screen.dart';
import 'package:wirdul_latif/utils/initialize.dart';
import 'package:wirdul_latif/utils/theme.dart';
import 'package:wirdul_latif/utils/theme_provider_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wird Al Latif',
      routes: AppRoutes.routes,
      theme: themeProvider.isDarkMode
          ? customTheme.darkTheme
          : customTheme.lightTheme,
      home: SplashScreen(),
    );
  }
}
