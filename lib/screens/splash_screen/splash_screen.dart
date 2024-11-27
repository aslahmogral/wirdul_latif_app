import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:wirdul_latif/screens/home_screen/home_screen.dart';
import 'package:wirdul_latif/screens/onboarding_screens.dart/onboarding_screen.dart';
import 'package:wirdul_latif/screens/wird_screen/wird_screen.dart';
import 'package:wirdul_latif/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initWirdData();
  }

  bool showReload = false;

  initWirdData() async {
    await WirdulLatif().initWirdData();
    checkFirstRun();
  }

  Future<void> checkFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

    if (hasSeenOnboarding) {
      navigateToHome();
    } else {
      prefs.setBool('hasSeenOnboarding', true);
      navigateToOnboarding();
    }
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    });
    //  setState(() {
    //     showReload = true;
    //   });
  }

  void navigateToOnboarding() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (_) => OnboardingScreen(
                isInitialPage: true,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              // 'asset/logo/wird_logo_bg.png',
              'asset/wirdul_latif.png',
              height: 100,
              width: 100,
            ).animate().scale(duration: Duration(seconds: 2)).shimmer(
                duration: 1500.ms, // Duration of the shimmer animation
                color: Colors.white, // Highlight color for shimmer
                angle: 0.5),
            SizedBox(
              height: 36,
            ),
            Visibility(
              visible: showReload,
              child: InkWell(
                onTap: () => initWirdData(),
                child: Text(
                  'Reload wirdul latif',
                  style: TextStyle(
                      color: WirdColors.primaryDaycolor,
                      decoration: TextDecoration.underline),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
