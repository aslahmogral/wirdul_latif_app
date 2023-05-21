import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/model/wird_model.dart';
import 'package:wirdul_latif/provider/wird_provider.dart';
import 'package:wirdul_latif/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<WirdModel>? wirdList = [];

  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      wirdList: wirdList,
                    )
                // HomeScreen()
                )));
    super.initState();
  }

  getWirdData() async {
    final wirdProvider = Provider.of<WirdProvider>(context, listen: false);
    await wirdProvider.loadLocalJsonData();
    wirdList = wirdProvider.wirddata;
  }

  @override
  Widget build(BuildContext context) {
    getWirdData();

    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(child: Container()),
            Image.asset('asset/bismillah.png'),
            Lottie.asset(
              'asset/wird.json',
            ),
            Expanded(child: Container()),
          ],
        ));
  }
}
