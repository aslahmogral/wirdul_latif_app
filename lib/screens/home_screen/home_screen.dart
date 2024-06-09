import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/screens/home_screen/home_screen_model.dart';
import 'package:wirdul_latif/screens/wird_screen/wird_screen.dart';
import 'package:wirdul_latif/utils/colors.dart';
import 'package:wirdul_latif/widgets/container_shader.dart';

class HomeScreen extends StatelessWidget {
  static String routename = 'homescreen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeScreenModel()),
      ],
      child: Consumer<HomeScreenModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu,
                  // color: WirdColors.primaryDaycolor,
                )),
            actions: [
              IconButton(
                  onPressed: () {
                    model.swithDayOrNight();
                  },
                  icon: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      // return FadeTransition(opacity: animation, child: child);
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: model.isNightMode
                        ? Icon(
                            Icons.dark_mode,
                            key: ValueKey('dark'),
                          )
                        : Icon(
                            Icons.light_mode,
                            key: ValueKey('light'),
                          ),
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                quranMessageSection()
                    .animate()
                    .shimmer(duration: Duration(milliseconds:500 ))
                  .scale(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOutCirc,
                    //  To the original position
                  ),
                const SizedBox(
                  height: 30,
                ),
                motivationShortsTileSection()
                    .animate()
                    .shimmer(duration: Duration(milliseconds: 500))
                                        .scale(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOutCirc,
                  ),
                const SizedBox(
                  height: 30,
                ),
                morningAndEveningWirdSection(context)
                    .animate()
                    .shimmer(duration: Duration(milliseconds: 500))
                    .scale(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOutCirc,
                  ),
              ],
            ),
          ),
          bottomNavigationBar: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Please include App Developer in your \n prayers 🤲',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Row morningAndEveningWirdSection(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(WirdScreen.routename,
                arguments: {'wird': 'morning'});
          },
          child: morningOrEveningCard(
              size: 170,
              imagePath: 'asset/morning.jpg',
              title: 'Morning',
              subTitle: 'Wird'),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(WirdScreen.routename,
                arguments: {'wird': 'evening'});
          },
          child: morningOrEveningCard(
              size: 170,
              imagePath: 'asset/night.jpg',
              title: 'Evening',
              subTitle: 'Wird'),
        ),
      ],
    );
  }

  Container motivationShortsTileSection() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(Icons.bolt, color: Colors.yellow, size: 30),
          title: Text(
            'Motivational Shorts',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ),
      ),
      // height: 70,
      decoration: BoxDecoration(
        color: WirdColors.primaryDaycolor,
        gradient: WirdGradients.listTileShadeGradient,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  Stack quranMessageSection() {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: const DecorationImage(
              image: AssetImage('asset/quotes1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 0, 0),
              borderRadius: BorderRadius.circular(15),
              gradient: WirdGradients.containerShadeGradient),
        ),
        Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '“And glorify the praises of your Lord beore sunrise before sunset”',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Text(
                    'Quran 50:39',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow),
                  )
                ],
              ),
            ),
          ),
          height: 200,
        ),
      ],
    );
  }
}
