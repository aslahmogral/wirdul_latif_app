import 'package:flutter/material.dart';
import 'package:wirdul_latif/utils/colors.dart';

@deprecated
class MorningOrEveningCard extends StatelessWidget {
  final Color color;
  final double size;
  final String title;
  final String subTitle;
  final String emojiString;

  const MorningOrEveningCard({
    Key? key,
    required this.color,
    required this.title,
    required this.subTitle,
    required this.size,
    required this.emojiString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.width/2.5,
          width: MediaQuery.of(context).size.width/2.5,
          decoration: BoxDecoration(
            // color: WirdColors.primaryDaycolor,
            borderRadius: BorderRadius.circular(15),
            color: WirdColors.primaryDaycolor.withOpacity(0.8),
            gradient: WirdGradients.listTileShadeGradient,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Spacer(),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            top: 20,
            left: 10,
            child: Text(
              emojiString,
              style: TextStyle(fontSize: 50),
            ))
      ],
    );
  }
}
