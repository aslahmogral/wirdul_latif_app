import 'package:flutter/material.dart';
import 'package:wirdul_latif/utils/colors.dart';

class morningOrEveningCard extends StatelessWidget {
  final String imagePath;
  final double size;
  final String title;
  final String subTitle;
  const morningOrEveningCard(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subTitle,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
      
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          child: Container(
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
                        color: Colors.white),
                  ),
                  // SizedBox(
                  //   height: 22,
                  // ),
                  Text(
                    subTitle,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  )
                ],
              ),
            ),
            height: size,
          ),
          height: size,
          width: size,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 0, 0),
              borderRadius: BorderRadius.circular(15),
              gradient: WirdGradients.containerShadeGradient),
        ),
      ],
    );
  }
}
