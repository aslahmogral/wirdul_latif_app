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
    Future.delayed(const Duration(seconds: 0), () {
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
      backgroundColor: Colors.teal,
      body: Container(
        decoration: BoxDecoration(
          gradient: WirdGradients.listTileShadeGradient,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Slightly rounded corners
                ),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10), // Same value as in the Card
                  child: Image.asset(
                    'asset/logo/logo.png',
                    width: 80.0,
                    height: 80.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ).animate().shimmer(
                  duration: 1500.ms, // Duration of the shimmer animation
                  color: Colors.white, // Highlight color for shimmer
                  angle: 0.5),
              SizedBox(
                height: 8,
              ),
              Text(
                'Wirdul Latif Pro',
                style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
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
      ),
    );
  }
}
