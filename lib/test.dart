// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';

// class MyWidget extends StatelessWidget {
//   final MyModel model;

//   MyWidget({required this.model});

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         model.switchDayOrNight();
//       },
//       icon: AnimatedSwitcher(
//         duration: Duration(seconds: 1),
//         transitionBuilder: (Widget child, Animation<double> animation) {
//           return FadeTransition(opacity: animation, child: child);
//         },
//         child: model.isNightMode
//             ? Icon(
//                 Icons.dark_mode,
//                 key: ValueKey('dark'),
//               )
//             : Icon(
//                 Icons.light_mode,
//                 key: ValueKey('light'),
//               ),
//       ),
//     );
//   }
// }

// class MyModel {
//   bool isNightMode;

//   MyModel({this.isNightMode = false});

//   void switchDayOrNight() {
//     isNightMode = !isNightMode;
//   }
// }
