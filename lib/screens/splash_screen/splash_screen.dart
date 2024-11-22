import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:wirdul_latif/screens/home_screen/home_screen.dart';
import 'package:wirdul_latif/screens/onboarding_screens.dart/onboarding_screen.dart';
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
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  void navigateToOnboarding() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => OnboardingScreen(isInitialPage: true,)),
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
            const CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(WirdColors.primaryDaycolor),
            ),
            SizedBox(
              height: 36,
            ),
            InkWell(
              onTap: () => initWirdData(),
              child: Text(
                'Reload wirdul latif',
                style: TextStyle(
                    color: WirdColors.primaryDaycolor,
                    decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
      ),
    );
  }
}
