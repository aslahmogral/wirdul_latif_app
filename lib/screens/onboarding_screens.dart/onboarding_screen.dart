import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:wirdul_latif/screens/auth_screen/auth_screen.dart';
import 'package:wirdul_latif/utils/responsive.dart';

class OnboardingScreen extends StatelessWidget {
  final bool isInitialPage;
  const OnboardingScreen({Key? key, required this.isInitialPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;
    final double lottieHeight = isTablet ? 320.0 : 200.0;

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isTablet ? 750.0 : double.infinity,
          ),
          child: IntroductionScreen(
            pages: [
              PageViewModel(
                title: "Strengthen Your Connection with Allah",
                body:
                    "Experience the peace and blessings of Wirdullateef with morning and evening dhikr.",
                image: Center(
                  child: Lottie.asset('asset/onboarding/onboarding1.json',
                      height: lottieHeight),
                ),
                decoration: PageDecoration(
                  titleTextStyle:
                      TextStyle(fontSize: isTablet ? 28.0 : 22.0, fontWeight: FontWeight.bold),
                  bodyTextStyle: TextStyle(fontSize: isTablet ? 20.0 : 16.0),
                  imagePadding: const EdgeInsets.only(top: 40.0),
                ),
              ),
              PageViewModel(
                title: "Easy-to-Follow Litanies",
                body:
                    "Follow step-by-step guidance for your daily Wirdullateef litanies.",
                image: Center(
                  child: Lottie.asset('asset/onboarding/onboarding2.json',
                      height: lottieHeight),
                ),
                decoration: PageDecoration(
                  titleTextStyle:
                      TextStyle(fontSize: isTablet ? 28.0 : 22.0, fontWeight: FontWeight.bold),
                  bodyTextStyle: TextStyle(fontSize: isTablet ? 20.0 : 16.0),
                  imagePadding: const EdgeInsets.only(top: 40.0),
                ),
              ),
              PageViewModel(
                title: "Track Your Progress",
                body:
                    "Maintain streaks and build a daily habit to stay consistent and focused.",
                image: Center(
                  child:
                      Lottie.asset('asset/onboarding/streak.json', height: lottieHeight),
                ),
                decoration: PageDecoration(
                  titleTextStyle:
                      TextStyle(fontSize: isTablet ? 28.0 : 22.0, fontWeight: FontWeight.bold),
                  bodyTextStyle: TextStyle(fontSize: isTablet ? 20.0 : 16.0),
                  imagePadding: const EdgeInsets.only(top: 40.0),
                ),
              ),
            ],
            onDone: () {
              if (!isInitialPage) {
                Navigator.pop(context);
              } else {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const AuthScreen()),
                );
              }
            },
            onSkip: () {
              if (!isInitialPage) {
                Navigator.pop(context);
              } else {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const AuthScreen()),
                );
              }
            },
            showSkipButton: true,
            skip: const Text("Skip", style: TextStyle(color: Colors.teal)),
            next: const Icon(Icons.arrow_forward, color: Colors.teal),
            done: const Text("Get Started",
                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.teal)),
            dotsDecorator: const DotsDecorator(
              size: Size(10.0, 10.0),
              color: Colors.grey,
              activeSize: Size(22.0, 10.0),
              activeColor: Colors.teal,
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
