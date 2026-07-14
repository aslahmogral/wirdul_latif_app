import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:jhijri/jHijri.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/screens/auth_screen/auth_screen.dart';
import 'package:wirdul_latif/screens/blog_screen.dart/blog_screen.dart';
import 'package:wirdul_latif/screens/calender_screen.dart/calender_screen.dart';
import 'package:wirdul_latif/screens/contact_us_screen/contact_us_screen.dart';
import 'package:wirdul_latif/screens/onboarding_screens.dart/onboarding_screen.dart';
import 'package:wirdul_latif/screens/reels_screen/youtube_reels_screen.dart';
import 'package:wirdul_latif/screens/settings_screen/setting_screen_model.dart';
import 'package:wirdul_latif/screens/home_screen/home_screen_model.dart';
import 'package:wirdul_latif/screens/thasbeeh_counter/thasbeeh_counter.dart';
import 'package:wirdul_latif/utils/auth_service.dart';
import 'package:wirdul_latif/utils/colors.dart';
import 'package:wirdul_latif/utils/constants.dart';
import 'package:wirdul_latif/utils/theme_provider_model.dart';
import 'package:wirdul_latif/widgets/hijri_calender.dart';
import 'package:wirdul_latif/widgets/morning_evening_wird_card.dart';
import 'package:wirdul_latif/utils/responsive.dart';

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
                              Container(
                                  // width: 50,
                                  // color: Colors.yellow,
                                  child: Lottie.asset(
                                      'asset/onboarding/streak.json',
                                      height: 100.0)),
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
                  child: Visibility(
                    replacement: Opacity(
                      opacity: 0.5,
                      child: Icon(
                        Icons.local_fire_department,
                        size: 35,
                        color: Colors.grey[400],
                      ),
                    ),
                    visible: model.currentStreaks != 0,
                    child: Row(
                      children: [
                        Stack(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                                replacement: Container(
                                        width: 50,
                                        // color: Colors.yellow,
                                        child: Lottie.asset(
                                            'asset/onboarding/streak.json',
                                            height: 40.0))
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(reverse: true),
                                    )
                                    .fadeIn(duration: 600.ms),
                                visible: model.todayStreakAchieved,
                                child: Container(
                                    width: 50,
                                    // color: Colors.yellow,
                                    child: Lottie.asset(
                                        'asset/onboarding/streak.json',
                                        height: 40.0))),
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
                ),
              ],
            ),
            drawer: drawer(themeProviderModel, model),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: context.isTablet ? 1000 : double.infinity,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          if (context.isTablet)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
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
                                              style: const TextStyle(
                                                  decoration: TextDecoration.underline,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 28),
                                      morningAndEveningWirdSection(context),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
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
                                    ],
                                  ),
                                ),
                              ],
                            )
                          else
                            Column(
                              children: [
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
                                        style: const TextStyle(
                                            decoration: TextDecoration.underline,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 28),
                                morningAndEveningWirdSection(context),
                                const SizedBox(
                                  height: 20,
                                ),
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
                              ],
                            ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
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
          StreamBuilder<User?>(
            stream: AuthService().authStateChanges,
            builder: (context, snapshot) {
              final user = snapshot.data;
              final isGuest = user == null || user.isAnonymous;

              return Container(
                decoration: BoxDecoration(
                  gradient: WirdGradients.listTileShadeGradient,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            backgroundImage: (!isGuest && user.photoURL != null)
                                ? NetworkImage(user.photoURL!)
                                : null,
                            child: isGuest
                                ? const Icon(Icons.person, color: Colors.yellow, size: 30)
                                : (user.photoURL == null
                                    ? Text(
                                        user.displayName?.isNotEmpty == true
                                            ? user.displayName![0].toUpperCase()
                                            : 'U',
                                        style: const TextStyle(
                                            color: Colors.yellow,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      )
                                    : null),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  isGuest
                                      ? 'Guest Account'
                                      : (user.displayName ?? 'Google User'),
                                  style: const TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (!isGuest && user.email != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    user.email!,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 12,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              themeProviderModel.toggleDarkMode();
                            },
                            icon: Icon(
                              themeProviderModel.isDarkMode
                                  ? Icons.dark_mode
                                  : Icons.light_mode,
                              color: Colors.yellow,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  StreamBuilder<User?>(
                    stream: AuthService().authStateChanges,
                    builder: (context, snapshot) {
                      final user = snapshot.data;
                      if (user == null) return const SizedBox.shrink();

                      if (user.isAnonymous) {
                        return _drawerItem(
                          context: context,
                          leading: const Icon(Icons.sync, color: Colors.yellow),
                          title: 'Sync Progress with Google',
                          onTap: () async {
                            Navigator.pop(context); // Close drawer

                            // Show loading dialog
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                                ),
                              ),
                            );

                            try {
                              final authService = AuthService();
                              await authService.linkWithGoogle();
                              Navigator.pop(context); // Dismiss loading

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Account synced successfully with Google!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } on FirebaseAuthException catch (e) {
                              Navigator.pop(context); // Dismiss loading
                              
                              if (e.code == 'credential-already-in-use') {
                                final confirmSwitch = await showDialog<bool>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text('Account Already Exists'),
                                    content: const Text(
                                      'This Google account is already linked to another profile.\n\n'
                                      'Would you like to switch to that account? (Note: Unsynced local progress will be replaced by the other profile\'s data).'
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(ctx, false),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(ctx, true),
                                        child: const Text('Switch Account', style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirmSwitch == true) {
                                  try {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (_) => const Center(child: CircularProgressIndicator()),
                                    );

                                    final authService = AuthService();
                                    await authService.signOut();
                                    await authService.signInWithGoogle();

                                    Navigator.pop(context); // Dismiss loading
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Switched to Google account successfully!'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  } catch (err) {
                                    Navigator.pop(context); // Dismiss loading if failed
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Failed to switch account: $err'),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                    );
                                  }
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Linking failed: ${e.message}'),
                                    backgroundColor: Colors.redAccent,
                                  ),
                                );
                              }
                            } catch (e) {
                              Navigator.pop(context); // Dismiss loading
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('An unexpected error occurred: $e'),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            }
                          },
                        );
                      } else {
                        return _drawerItem(
                          context: context,
                          leading: const Icon(Icons.logout, color: Colors.redAccent),
                          title: 'Sign Out',
                          onTap: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Sign Out'),
                                content: const Text('Are you sure you want to sign out? You will need to sign in again to access your account.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, true),
                                    child: const Text('Sign Out', style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              final authService = AuthService();
                              await authService.signOut();

                              if (context.mounted) {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (_) => const AuthScreen()),
                                  (route) => false,
                                );
                              }
                            }
                          },
                        );
                      }
                    },
                  ),
                  _drawerItem(
                    context: context,
                    leading: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    title: 'Super Important',
                    onTap: () {
                      homescreenModel.showPrayerRequest(context);
                    },
                  ),
                  _drawerItem(
                    context: context,
                    leading: const Icon(Icons.notifications, color: Colors.teal),
                    title: 'Notifications',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Coming Soon'),
                            content: const Text('This feature will be available soon.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text(
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
                  ),
                  _drawerItem(
                    context: context,
                    leading: const Icon(Icons.star, color: Colors.amber),
                    title: 'App Features',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OnboardingScreen(
                                    isInitialPage: false,
                                  )));
                    },
                  ),
                  _drawerItem(
                    context: context,
                    leading: const Icon(Icons.sync, color: Colors.blue),
                    title: 'Update Files',
                    onTap: () {
                      settingsModel.checkForUpdates(context);
                    },
                  ),
                  Visibility(
                    visible: Constants.resetCalender,
                    child: _drawerItem(
                      context: context,
                      leading: const Icon(Icons.delete_forever, color: Colors.redAccent),
                      title: 'Reset Calender Streaks',
                      onTap: () {
                        settingsModel.clearStats(context, homescreenModel);
                      },
                    ),
                  ),
                  _drawerItem(
                    context: context,
                    leading: const Icon(Icons.rate_review, color: Colors.purple),
                    title: 'Rate this App',
                    onTap: () {
                      settingsModel.rateApp();
                    },
                  ),
                  _drawerItem(
                    context: context,
                    leading: const Icon(Icons.share, color: Colors.orange),
                    title: 'Share this App',
                    onTap: () {
                      settingsModel.shareApp();
                    },
                  ),
                  _drawerItem(
                    context: context,
                    leading: const Icon(
                      Icons.alternate_email,
                      color: Colors.green,
                    ),
                    title: 'Contact Us',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContactUsScreen()));
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Wirdul Latif Pro',
                  style: TextStyle(color: Colors.grey),
                ),
                const Text(
                  'v3.0.0',
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
          width: double.infinity,
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
                  width: double.infinity,
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

  Row morningAndEveningWirdSection(BuildContext context) {
    final isTablet = context.isTablet;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isTablet
            ? Expanded(
                child: InkWell(
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
              )
            : InkWell(
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
        if (isTablet) const SizedBox(width: 16),
        isTablet
            ? Expanded(
                child: InkWell(
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
              )
            : InkWell(
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

  Widget _drawerItem({
    required BuildContext context,
    required Widget leading,
    required String title,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: leading,
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: isDark ? Colors.white54 : Colors.black54,
          size: 20,
        ),
        onTap: onTap,
      ),
    );
  }
}
