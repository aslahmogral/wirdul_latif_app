import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:jhijri/jHijri.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/screens/blog_screen.dart/blog_screen.dart';
import 'package:wirdul_latif/screens/calender_screen.dart/calender_screen.dart';
import 'package:wirdul_latif/screens/contact_us_screen/contact_us_screen.dart';
import 'package:wirdul_latif/screens/onboarding_screens.dart/onboarding_screen.dart';
import 'package:wirdul_latif/screens/reels_screen/youtube_reels_screen.dart';
import 'package:wirdul_latif/screens/settings_screen/setting_screen_model.dart';
import 'package:wirdul_latif/screens/home_screen/home_screen_model.dart';
import 'package:wirdul_latif/screens/thasbeeh_counter/thasbeeh_counter.dart';
import 'package:wirdul_latif/utils/colors.dart';
import 'package:wirdul_latif/utils/constants.dart';
import 'package:wirdul_latif/utils/theme_provider_model.dart';
import 'package:wirdul_latif/widgets/hijri_calender.dart';
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
        builder: (context, model, child) => Consumer<ThemeProvider>(
            builder: (context, themeProviderModel, child) {
          return Scaffold(
            appBar: AppBar(
              // centerTitle: true,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Wirdul Latif Pro'),
                ],
              ),
              actions: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                size: 50,
                                Icons.local_fire_department,
                                color: Colors.orange[700],
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                model.currentStreaks.toString(),
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          content: Text(
                              '“To maintain your streak, make sure to read at least 10 wirds of Morning or Evening every day.\n\nKeep it simple, stay consistent, and keep your streak alive!”.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                'OK',
                                style: TextStyle(color: Colors.teal),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Stack(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 50,
                            // color: Colors.yellow,
                            child: Lottie.asset('asset/onboarding/streak.json',
                                height: 40.0),
                          ),
                          Positioned(
                            right: 0,
                            bottom: -8,
                            child: Container(
                              height: 50,
                              // color: Colors.green,
                              child: Center(
                                child: Text(
                                  model.currentStreaks.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 16,
                      )
                    ],
                  ),
                ),
              ],
            ),
            drawer: drawer(themeProviderModel, model),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CalenderScreen(
                                          currentStreak: model.currentStreaks,
                                        )));
                          },
                          child: calender(model)),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TasbeehCounterScreen()),
                            );
                          },
                          child: zikrCounter(model)),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                )),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => CounterScreen()),
            //     );
            //   },
            //   child: Container(
            //     child: Padding(
            //       padding: const EdgeInsets.all(12.0),
            //       child: Image.asset('asset/tasbih.png'),
            //     ),
            //   ),
            // ),
          );
        }),
      ),
    );
  }

  Drawer drawer(
      ThemeProvider themeProviderModel, HomeScreenModel homescreenModel) {
    return Drawer(
        child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingsScreenModel()),
      ],
      child: Consumer<SettingsScreenModel>(
        builder: (context, settingsModel, child) => Column(children: [
          Container(
            // height: 160,
            decoration: BoxDecoration(
              gradient: WirdGradients.listTileShadeGradient,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  // mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              color: Colors.black,
                              child: Image.asset(
                                // 'asset/logo/wird_logo_bg.png',
                                'asset/logo/wird_logo_bg.png',
                                width: 80.0,
                                height: 80.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                              .animate(
                                onPlay: (controller) => controller.repeat(),
                              )
                              .shimmer(
                                duration: 3000
                                    .ms, // Duration of the shimmer animation
                                color:
                                    Colors.white, // Highlight color for shimmer
                                angle: 0.5,
                              ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Wirdul Latif Pro',
                            style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        themeProviderModel.toggleDarkMode();
                      },
                      icon: Icon(
                        themeProviderModel.isDarkMode
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        color: Colors.yellow,
                        size: 35,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 16,
              ),
              ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                title: Text('Super Important'),
                onTap: () {
                  homescreenModel.showPrayerRequest(context);
                },
                trailing: Icon(Icons.chevron_right),
              ),

              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notifications'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Coming Soon'),
                        content: Text('This feature will be available soon.'),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              'OK',
                              style: TextStyle(color: Colors.teal),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                trailing: Icon(Icons.chevron_right),
              ),

              ListTile(
                leading: Icon(Icons.star),
                title: Text('App Features'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OnboardingScreen(
                                isInitialPage: false,
                              )));
                },
                trailing: Icon(Icons.chevron_right),
              ),

              // Divider(),
              ListTile(
                leading: Icon(Icons.sync),
                title: Text('Update Files'),
                onTap: () {
                  settingsModel.checkForUpdates(context);
                },
                trailing: Icon(Icons.chevron_right),
              ),
              Visibility(
                visible: Constants.resetCalender,
                child: ListTile(
                  leading: Icon(Icons.delete_forever),
                  title: Text('Reset Calender Streaks'),
                  onTap: () {
                    settingsModel.clearStats(context, homescreenModel);
                  },
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
              // Divider(),
              ListTile(
                leading: Icon(Icons.rate_review),
                title: Text('Rate this App'),
                onTap: () {
                  settingsModel.rateApp();
                },
                trailing: Icon(Icons.chevron_right),
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share this App'),
                onTap: () {
                  settingsModel.shareApp();
                },
                trailing: Icon(Icons.chevron_right),
              ),
              // ListTile(
              //   leading: Icon(Icons.apps),
              //   title: Text('More Apps'),
              //   onTap: () {
              //     settingsModel.moreApps();
              //   },
              //   trailing: Icon(Icons.chevron_right),
              // ),
              ListTile(
                leading: Text(
                  '@',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                title: Text('Contact Us'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContactUsScreen()));
                },
                trailing: Icon(Icons.chevron_right),
              ),

              // Spacer(),
            ],
          )
          // ListView(
          //   children: [

          // ])
          ,
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Wirdul Latif Pro',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  'v2.2.0',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        ]),
      ),
    ));
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
                // Container(
                //   height: 30,
                // ),
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
                Text(
                  "${JHijri.now().hijri.day.toString()} ${HijriCalendar().getMonthName(JHijri.now().month)} | ${JHijri.now().year.toString()}",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.white70,
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

                // Row(
                //     children: [
                //       Text(
                //         '(${JHijri.now().hijri.day.toString()} ',
                //         style: TextStyle(fontSize: 12),
                //       ),
                //       // Text(
                //       //   '${JHijri.now().hijri.monthName}  ',
                //       //   style: TextStyle(fontSize: 14),
                //       // ),
                //       Text(
                //         HijriCalendar().getMonthName(JHijri.now().month),
                //         style: TextStyle(fontSize: 14),
                //       ),
                //       Text(
                //         ' ${JHijri.now().year.toString()} )',
                //         style: TextStyle(fontSize: 12),
                //       ),
                //     ],
                //   )

                SizedBox(
                  height: 22,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: model.currentProgressColor(),
                    borderRadius: BorderRadius.circular(15),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black54,
                    //     offset: Offset(4, 4),
                    //     blurRadius: 4,
                    //   ),
                    //   BoxShadow(
                    //     color: Colors.white,
                    //     offset: Offset(-4, -4),
                    //     blurRadius: 4,
                    //   ),
                    // ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          model.currentProgressText(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: model.progress == progressType.continuee
                                ? Colors.black
                                : Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
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

  Container zikrCounter(HomeScreenModel model) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: ListTile(
          leading: Container(
            height: 30,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                '🤲',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          title: Text(
            'Zikr Counter',
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

  Container calender(HomeScreenModel model) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Text(
            '🗓️',
            style: TextStyle(fontSize: 20),
          ),
          title: Text(
            'Calender',
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
              emojiString: '🍿',
              size: 170,
              color: WirdColors.primaryDaycolor,
              title: 'Watch',
              subTitle: 'Naseeha'),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BlogScreen()));
          },
          child: MorningOrEveningCard(
              emojiString: '📚',
              size: 170,
              color: WirdColors.primaryDaycolor,
              title: 'Read',
              subTitle: 'Naseeha'),
        ),
      ],
    );
  }
}
