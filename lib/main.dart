import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/provider/wird_provider.dart';
import 'package:wirdul_latif/splash_screen.dart';

void main() {
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
            create: (context) => WirdProvider(),
          ),
          
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Wird Al Latif',
          theme: ThemeData(
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
        ));

   
  }
}
