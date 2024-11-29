import 'package:flutter/widgets.dart';

class WirdColors {
  static const primaryColor = Color(0xff061930);
  // #061930
  static const seconderyColor = Color.fromARGB(255, 231, 185, 58);
  static const seconderyColorDark = Color(0xffcfa531);
  static const primaryDaycolor = Color(0xff057468);
}

class WirdGradients {
  static LinearGradient containerShadeGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
      Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
      Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),
    ],
  );

  static LinearGradient listTileShadeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      WirdColors.primaryDaycolor,
      Color.fromARGB(255, 7, 106, 96),
      Color.fromARGB(255, 25, 140, 128),
      Color.fromARGB(255, 53, 184, 171),
    ],
  );



}



