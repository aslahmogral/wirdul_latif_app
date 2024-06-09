import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:wirdul_latif/deprecated/provider/wird_provider.dart';
import 'package:wirdul_latif/routes.dart';
import 'package:wirdul_latif/screens/home_screen/home_screen.dart';

void main() {
  WirdulLatif.initWird();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
          theme: ThemeData(
              // is not restarted.
              primarySwatch: Colors.blue,
              fontFamily: 'Poppins'),   
          home: const HomeScreen(),
        ));
  }
}
