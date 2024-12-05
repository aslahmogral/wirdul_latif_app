import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/screens/home_screen/home_screen_model.dart';
import 'package:wirdul_latif/screens/wird_screen/wird_screen_model.dart';
import 'package:wirdul_latif/utils/colors.dart';
import 'package:wirdul_latif/utils/theme_provider_model.dart';

class WirdScreen extends StatelessWidget {
  static String routename = 'wirdscreen';
  final WirdType wirdType;

  const WirdScreen({super.key, required this.wirdType});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WirdScreenModel(wirdType)),
        ChangeNotifierProvider(create: (context) => HomeScreenModel(context))
      ],
      builder: (context, child) {
        return Consumer<HomeScreenModel>(
            builder: (context, HomeScreenModel, child) {
          return Consumer<ThemeProvider>(
              builder: (context, ThemeProvider, child) {
            return Consumer<WirdScreenModel>(
              builder: (context, model, child) {
                return PopScope(
                  canPop: false,
                  onPopInvokedWithResult: (didPop, result) {
                    if (didPop) {
                      return;
                    } else {
                      model.showWarning(HomeScreenModel, context);
                    }
                  },
                  child: Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                          onPressed: () {
                            model.showWarning(HomeScreenModel, context);
                          },
                          icon: Icon(Icons.close)),
                      centerTitle: true,
                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              '${model.TitleText[0].toUpperCase()}${model.TitleText.substring(1)} Wird'),
                        ],
                      ),
                      actions: [
                        setttingsBottomSheet(context, ThemeProvider),
                      ],
                    ),
                    body: Stack(
                      children: [
                        PageView.builder(
                          itemCount: model.wirdList.length,
                          controller: model.controller,
                          onPageChanged: (value) {
                            model.currentPage = value;
                          },
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Stack(
                                children: [
                                  SingleChildScrollView(
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 18,
                                            backgroundColor:
                                                WirdColors.primaryDaycolor,
                                            child: CircleAvatar(
                                              radius: 16,
                                              backgroundColor: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              child: Text(
                                                (model.currentPage + 1)
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall
                                                        ?.color,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(16),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              gradient: WirdGradients
                                                  .listTileShadeGradient,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: WirdColors.primaryDaycolor,
                                            ),
                                            child: Text(
                                              model.wirdList[index].wird,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                                fontFamily: 'Kfgqpc',
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Visibility(
                                            visible:
                                                ThemeProvider.isTransliteration,
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: WirdGradients
                                                        .listTileShadeGradient
                                                        .colors
                                                        .last
                                                        .withOpacity(0.5),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                          model.wirdList[index]
                                                              .transliteration,
                                                          // textAlign: TextAlign.left,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headlineSmall
                                                                  ?.copyWith(
                                                                    fontSize:
                                                                        16,
                                                                  )),
                                                    ],
                                                  ),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Visibility(
                                            visible: ThemeProvider
                                                .isEnglishTranslation,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: WirdGradients
                                                        .listTileShadeGradient
                                                        .colors
                                                        .last
                                                        .withOpacity(0.5),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Column(
                                                    children: [
                                                      // Text('TRANSLATION',
                                                      //     textAlign: TextAlign.center,
                                                      //     style: Theme.of(context)
                                                      //         .textTheme
                                                      //         .headlineSmall
                                                      //         ?.copyWith(
                                                      //             fontSize: 14,
                                                      //             )),
                                                      // SizedBox(
                                                      //   height: 16,
                                                      // ),
                                                      Text(
                                                          model.wirdList[index]
                                                              .english
                                                              .replaceAll(
                                                                  RegExp(
                                                                      r'[˹˺]'),
                                                                  ''),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headlineSmall
                                                                  ?.copyWith(
                                                                    fontSize:
                                                                        16,
                                                                  )),
                                                    ],
                                                  ),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 100,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: bottomBar(
                            model: model,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          });
        });
      },
    );
  }

  IconButton setttingsBottomSheet(BuildContext context, ThemeProvider model) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
                height: 500,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      const Text('Settings'),
                      SizedBox(height: 16),
                      ListTile(
                        leading: Text(
                          'English Translation',
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: Switch(
                          activeColor: Colors.teal,
                          value: model.isEnglishTranslation,
                          onChanged: (value) {
                            model.toggleEnglishTranslation();
                          },
                        ),
                      ),

                      ListTile(
                        leading: Text(
                          'Transliteration',
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: Switch(
                          activeColor: Colors.teal,
                          value: model.isTransliteration,
                          onChanged: (value) {
                            model.toggleTransliteration();
                          },
                        ),
                      ),
                      ListTile(
                        leading: Text(
                          'Dark Mode',
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: Switch(
                          activeColor: Colors.teal,
                          value: model.isDarkMode,
                          onChanged: (value) {
                            model.toggleDarkMode();
                          },
                        ),
                      ),
                      Spacer(),
                      // ElevatedButton(
                      //   child: const Text('Save'),
                      //   onPressed: () => Navigator.pop(context),
                      // ),
                    ],
                  ),
                ));
          },
        );
      },
      icon: Icon(Icons.settings),
    );
  }
}

class bottomBar extends StatelessWidget {
  final WirdScreenModel model;
  const bottomBar({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: model.undoOrPrevPage,
                        icon: Icon(Icons.skip_previous),
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      if (model.currentPage == 0)
                        InkWell(
                          onTap: () {
                            print('object');
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '0%',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Completed',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      Visibility(
                        visible: model.currentPage != 0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${((model.currentPage + 1) / model.wirdList.length * 100).toStringAsFixed(0)} % ',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Completed',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${43 - model.currentPage} ',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Remaining',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      IconButton(
                        onPressed: model.skipOrNextPage,
                        icon: Icon(Icons.skip_next),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).primaryColor,
                ),
                height: 60,
                width: MediaQuery.of(context).size.width,
              ),

              //linear progress indicator
              Container(
                height: 60,
                child: Column(
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TweenAnimationBuilder<double>(
                          tween: Tween<double>(
                            begin: 0.0,
                            end:
                                (model.currentPage + 1) / model.wirdList.length,
                          ),
                          duration: const Duration(milliseconds: 300),
                          builder: (context, value, _) {
                            return LinearProgressIndicator(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                // color: Colors.teal,

                                // color: Theme.of(context)
                                //     .textTheme
                                //     .bodyMedium
                                //     ?.color,

                                minHeight: 6,
                                value: value);
                          }),
                    ),
                  ],
                ),
              ),

              //circular progress indicator
            ],
          ),
          
          Align(
            alignment: Alignment.centerLeft,
            child: ConfettiWidget(
                colors: [Colors.teal,Colors.white,Colors.black],
                blastDirection: 270,
                numberOfParticles: 20,
                gravity: 0.1,
                blastDirectionality:
                    BlastDirectionality.directional, // up direction
                confettiController: model.confettiController),
          ),
           Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
                colors: [Colors.teal,Colors.white,Colors.black],
                // blastDirection: 180,
                numberOfParticles: 10,
                gravity: 0.0,
                blastDirectionality:
                    BlastDirectionality.explosive, // up direction
                confettiController: model.confettiController),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ConfettiWidget(
                colors: [Colors.teal,Colors.white,Colors.black],
                blastDirection: 180,
                numberOfParticles: 20,
                gravity: 0.1,
                blastDirectionality:
                    BlastDirectionality.directional, // up direction
                confettiController: model.confettiController),
          ),
          counter(context)
        ],
      ),
    );
  }

  InkWell counter(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        model.thasbeehButtonClicked();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Theme.of(context).scaffoldBackgroundColor),
                  height: 100,
                  width: 100),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: TweenAnimationBuilder<double>(
                            tween: Tween<double>(
                                begin: 0.0, end: model.progressOfEachWird()),
                            duration: Duration(
                                milliseconds:
                                    model.progressOfEachWird() == 0 ? 0 : 300),
                            builder: (context, value, _) {
                              return CircularProgressIndicator(
                                // value: value,
                                value: value,

                                valueColor: AlwaysStoppedAnimation<Color>(
                                  WirdColors.primaryDaycolor,
                                ),
                              );
                            }),
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        child: Center(
                          child: Text(
                            "${model.wirdList[model.currentPage].counted != null ? model.currentPageWirdCounted : 0}/${model.wirdList[model.currentPage].count.toString()}",
                          ),
                        ),
                      ),
                      Visibility(
                        // visible: model.wirdList[model.currentPage ].completed ??
                        //     false,
                        visible: model.checkIfCurrentWirdCompleted(),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: WirdColors.primaryDaycolor,
                              gradient: WirdGradients.listTileShadeGradient),
                          child: Center(
                            child: Icon(
                              size: 35,
                              Icons.done_all,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: model.tapHere &&
                            (model.controller.initialPage == 0),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: WirdColors.primaryDaycolor,
                              gradient: WirdGradients.listTileShadeGradient),
                          child: Center(
                                  child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'TAPP ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                              Icon(Icons.touch_app, color: Colors.white)
                            ],
                          ))
                              .animate(
                                  onPlay: (controller) => controller.repeat())
                              .shake(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 12,
          )
        ],
      ),
    );
  }
}
