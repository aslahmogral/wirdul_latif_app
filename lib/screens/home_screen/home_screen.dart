import 'package:flutter/material.dart';
import 'package:wirdul_latif/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  static String routename = 'homescreen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: WirdColors.primaryDaycolor,
            )),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.light_mode))],
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Please include App Developer in your \n prayers 🤲',textAlign: TextAlign.center,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: WirdColors.primaryDaycolor,
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage('asset/quotes1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: WirdColors.primaryDaycolor,
                borderRadius: BorderRadius.circular(15),
              ),
            ) ,const SizedBox(
              height: 16,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
              height: 170,
              width: 170,
              decoration: BoxDecoration(
                color: WirdColors.primaryDaycolor,
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage('asset/morning.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),Container(
              height: 170,
              width: 170,
              decoration: BoxDecoration(
                color: WirdColors.primaryDaycolor,
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage('asset/night.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            )
            ],)
          ],
        ),
      ),
    );
  }
}
