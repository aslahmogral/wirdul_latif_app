import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/deprecated/wird_model.dart';
import 'package:wirdul_latif/deprecated/provider/wird_provider.dart';
import 'package:wirdul_latif/deprecated/deprecated/home_screen.dart';

class SplashScreendeprecated extends StatefulWidget {
  const SplashScreendeprecated({super.key});

  @override
  State<SplashScreendeprecated> createState() => _SplashScreendeprecatedState();
}

class _SplashScreendeprecatedState extends State<SplashScreendeprecated> {
  List<WirdModel>? wirdList = [];

  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreendeprecated(
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
