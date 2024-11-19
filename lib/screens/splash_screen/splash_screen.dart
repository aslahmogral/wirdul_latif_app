import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:wirdul_latif/screens/bottom_nav_bar/bottomNavbar.dart';

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
    Timer(
      const Duration(seconds: 3), // Splash screen duration
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => BottomNavBar()), // Navigate to home
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 150, height: 150, child: Icon(Icons.book)),
            const SizedBox(height: 20),
            const LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
