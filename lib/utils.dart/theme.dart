import 'package:flutter/material.dart';

class customTheme {
  static final ThemeData darkTheme =
      ThemeData.dark(useMaterial3: true).copyWith(
    primaryColor: Colors.grey[800],
    hintColor: Colors.blueGrey[700],
    scaffoldBackgroundColor: Colors.grey[900],
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white38,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.grey[400], fontFamily: 'Poppins'),
      bodyMedium: TextStyle(color: Colors.grey[400], fontFamily: 'Poppins'),
      displayLarge: TextStyle(color: Colors.grey[400], fontFamily: 'Poppins'),
      displayMedium: TextStyle(color: Colors.grey[400], fontFamily: 'Poppins'),
      displaySmall: TextStyle(color: Colors.grey[400], fontFamily: 'Poppins'),
      headlineMedium: TextStyle(color: Colors.grey[400], fontFamily: 'Poppins'),
      headlineSmall: TextStyle(color: Colors.grey[400], fontFamily: 'Poppins'),
      titleLarge: TextStyle(color: Colors.grey[400], fontFamily: 'Poppins'),
      titleMedium: TextStyle(color: Colors.grey[400], fontFamily: 'Poppins'),
      titleSmall: TextStyle(color: Colors.grey[400], fontFamily: 'Poppins'),
      labelLarge: TextStyle(color: Colors.grey[400], fontFamily: 'Poppins'),
      bodySmall: TextStyle(color: Colors.grey[400], fontFamily: 'Poppins'),
      labelSmall: TextStyle(color: Colors.grey[400], fontFamily: 'Poppins'),
    ),
  );

  static final ThemeData lightTheme =
      ThemeData.light(useMaterial3: true).copyWith(
    primaryColor:Colors.teal,
    hintColor: Colors.teal,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
      bodyMedium: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
      displayLarge: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
      displayMedium: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
      displaySmall: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
      headlineMedium: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
      headlineSmall: TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
      titleLarge: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
      titleMedium: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
      titleSmall: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
      labelLarge: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
      bodySmall: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
      labelSmall: TextStyle(color: Colors.black45, fontFamily: 'Poppins'),
    ),
    
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      // backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black38,
    ),
  );
}
