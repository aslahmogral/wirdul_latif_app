import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/deprecated/zikr_section/zikr_home_screen.dart/zikr_home_screen.dart';
import 'package:wirdul_latif/screens/blog_screen.dart/blog_screen.dart';
import 'package:wirdul_latif/screens/blog_screen.dart/webview.dart';
import 'package:wirdul_latif/screens/counter_screen/counter_screen.dart';
import 'package:wirdul_latif/screens/reels_screen/youtube_reels.dart';
import 'package:wirdul_latif/screens/settings_screen/settings_screen.dart';
import 'package:wirdul_latif/screens/wird_section_screens/wird_home_screen/wird_home_screen_model.dart';
import 'package:wirdul_latif/utils/colors.dart';
import 'package:wirdul_latif/widgets/morning_evening_wird_card.dart';

class HomeScreen extends StatelessWidget {
  static String routename = 'homescreen';
  // final WirdType wirdType;
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => HomeScreenModel(
                  context,
                )),
      ],
      child: Consumer<HomeScreenModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Wird al latif'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsScreen()));
                },
                icon: Icon(Icons.settings),
              ),
            ],
          ),
          body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [

                    //     ElevatedButton(
                    //         onPressed: () {
                    //           model.changeTab(WirdType.morning);
                    //         },
                    //         child: Text('Morning')),
                    //     ElevatedButton(
                    //         onPressed: () {
                    //           model.changeTab(WirdType.evening);
                    //         },
                    //         child: Text('evening'))
                    //   ],
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        onTap: () {
                          model.navigateToWird();
                        },
                        child: MorningOrEveningContainer(context, model)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            model.changeWirdType();
                          },
                          child: Text(
                            'switch to ${model.wirdType == WirdType.morning ? 'evening' : 'morning'} wird',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    morningAndEveningWirdSection(context),
                    // InkWell(
                    //     onTap: () {
                    //       model.navigateToZikr();
                    //     },
                    //     child: quranMessageSection()),
                    const SizedBox(
                      height: 20,
                    ),
                    // dummyStreakContainer(),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    InkWell(
                        onTap: () {
                          model.navigateToWird();
                        },
                        child: StartButton(model)),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CounterScreen()),
              );
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset('asset/tasbih.png'),
              ),
            ),
          ),
        ),
      ),
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
          ),
          child: model.wirdType == WirdType.morning
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: FadeInImage(
                    placeholder: AssetImage(
                        'asset/night.jpg'), // Add your placeholder image here
                    image: AssetImage('asset/morning.jpg'),
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(milliseconds: 300),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: FadeInImage(
                    filterQuality: FilterQuality.high,
                    placeholder: AssetImage(
                        'asset/morning.jpg'), // Add your placeholder image here
                    image: AssetImage('asset/night.jpg'),
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(milliseconds: 300),
                  ),
                ),
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
                Container(
                  height: 30,
                ),
                Text(
                  "${model.titleText.toUpperCase()} WIRD",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    wordSpacing: 2,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black54,
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                  ),
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
                          'READ NOW',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                            letterSpacing: 1.2,
                            shadows: [
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 2.0,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        )
                        // Text(
                        //   '05:00:22',
                        //   style: TextStyle(color: Colors.green),
                        // ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        // Container(
                        //     // width: MediaQuery.of(context).size.width,
                        //     width: 200,
                        //     child: LinearProgressIndicator(
                        //       value: 0.1,
                        //       color: Colors.green,
                        //     )),
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

  // Container motivationShortsTileSection() {
  //   return Container(
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: ListTile(
  //         leading: Icon(Icons.bolt, color: Colors.yellow, size: 30),
  //         title: Text(
  //           'Motivational Shorts',
  //           style: TextStyle(
  //               fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
  //         ),
  //         trailing: Icon(
  //           Icons.arrow_forward_ios,
  //           color: Colors.white,
  //         ),
  //       ),
  //     ),
  //     // height: 70,
  //     decoration: BoxDecoration(
  //       color: WirdColors.primaryDaycolor,
  //       gradient: WirdGradients.listTileShadeGradient,
  //       borderRadius: BorderRadius.circular(15),
  //     ),
  //   );
  // }

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
        color: WirdColors.primaryDaycolor.withOpacity(0.8),
        gradient: WirdGradients.listTileShadeGradient,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  Row morningAndEveningWirdSection(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => YoutubeReelsScreen()));
          },
          child: MorningOrEveningCard(
              icon: Icons.movie,
              size: 170,
              color: WirdColors.primaryDaycolor,
              title: 'Watch',
              subTitle: 'Naseeha'),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BlogScreen()));
          },
          child: MorningOrEveningCard(
              icon: Icons.book,
              size: 170,
              color: WirdColors.primaryDaycolor,
              title: 'Read',
              subTitle: 'Naseeha'),
        ),
      ],
    );
  }

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
