import 'package:flutter/material.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:wirdul_latif/screens/wird_section_screens/wird_home_screen/wird_home_screen.dart';
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()), // Navigate to home
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
            SizedBox(height: 36,),
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
