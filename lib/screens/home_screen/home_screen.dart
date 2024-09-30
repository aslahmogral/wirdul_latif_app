import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/screens/home_screen/home_screen_model.dart';
import 'package:wirdul_latif/screens/wird_screen/wird_screen.dart';
import 'package:wirdul_latif/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  static String routename = 'homescreen';
  final WirdType wirdType;
  const HomeScreen({super.key, required this.wirdType});
  @override
  Widget build(BuildContext context) {
    print(wirdType);
    // Map<String, dynamic> arg = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>÷
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => HomeScreenModel(context, wirdType: wirdType)),
      ],
      child: Consumer<HomeScreenModel>(
        builder: (context, model, child) => Scaffold(
          body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      onTap: () {
                        model.navigateToWird();
                      },
                      child: MorningOrEveningContainer(context, model)),
                  const SizedBox(
                    height: 20,
                  ),
                  quranMessageSection(),
                  const SizedBox(
                    height: 20,
                  ),
                  dummyStreakContainer(),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      onTap: () {
                        model.navigateToWird();
                      },
                      child: StartButton(model)),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              )),
        ),
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

  Stack MorningOrEveningContainer(context, HomeScreenModel model) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(model.mainImagePath),
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
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 0, 0, 0),
            borderRadius: BorderRadius.circular(15),
            gradient: WirdGradients.containerShadeGradient,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  "${model.titleText.toUpperCase()} WIRD",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 22,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '05:00:22',
                          style: TextStyle(color: Colors.green),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            // width: MediaQuery.of(context).size.width,
                            width: 200,
                            child: LinearProgressIndicator(
                              value: 0.1,
                              color: Colors.green,
                            )),
                      ],
                    ),
                  ),
                )
              ]),
            ),
          ),
          height: 200,
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

  Container StartButton(HomeScreenModel model) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(model.wirdIcon, color: Colors.yellow, size: 30),
          title: Text(
            'Read ${model.titleText[0].toUpperCase()}${model.titleText.substring(1)} Wird',
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

  // Row morningAndEveningWirdSection(context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       InkWell(
  //         onTap: () {
  //           Navigator.of(context).pushNamed(WirdScreen.routename,
  //               arguments: {'wird': 'morning'});
  //         },
  //         child: MorningOrEveningCard(
  //             size: 170,
  //             imagePath: 'asset/morning.jpg',
  //             title: 'Morning',
  //             subTitle: 'Wird'),
  //       ),
  //       InkWell(
  //         onTap: () {
  //           Navigator.of(context).pushNamed(WirdScreen.routename,
  //               arguments: {'wird': 'evening'});
  //         },
  //         child: MorningOrEveningCard(
  //             size: 170,
  //             imagePath: 'asset/night.jpg',
  //             title: 'Evening',
  //             subTitle: 'Wird'),
  //       ),
  //     ],
  //   );
  // }

  Container dummyStreakContainer() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          // leading: Icon(Icons.bolt, color: Colors.yellow, size: 30),
          title: Text(
            'Streak/progress Tracker coming soon',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          // trailing: Icon(
          //   Icons.arrow_forward_ios,
          //   color: Colors.white,
          // ),
        ),
      ),
      // height: 70,
      decoration: BoxDecoration(
        // color: const Color.fromARGB(255, 238, 238, 238),
        color: Colors.black26,
        // gradient: WirdGradients.listTileShadeGradient,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
