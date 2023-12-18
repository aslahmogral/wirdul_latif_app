import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/components/curve.dart';
import 'package:wirdul_latif/model/wird_model.dart';
import 'package:wirdul_latif/provider/wird_provider.dart';
import 'package:wirdul_latif/screens/intro_outro_msg.dart';
import 'package:wirdul_latif/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  final List<WirdModel>? wirdList;
  const HomeScreen({super.key, required this.wirdList});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                WirdProvider(context, widget.wirdList as List<WirdModel>)),
      ],
      child: Consumer<WirdProvider>(builder: (context, model, child) {
        return Scaffold(
          body: PageView(
            controller: model.controller,
            onPageChanged: (_) {
              model.count = 0;
              model.rebuildPage();
            },
            children: [
              IntroWidget(
                controller: model.controller,
                appbar: appBarArea(context),
              ),
              ...bodyWidget(widget.wirdList, model),
              OutroWidget(
                  controller: model.controller, appbar: appBarArea(context))
            ],
          ),
          bottomNavigationBar: bottomCounterButton(context, model),
        );
      }),
    );
  }

  List<Widget> bodyWidget(List<WirdModel>? wirdlist, WirdProvider model) {
    List<Widget> finalList = [];

    wirdlist?.forEach((element) {
      finalList.add(Stack(
        children: [
          Column(
            children: [
              appBarArea(context),
              const SizedBox(
                height: 20,
              ),
              textShowArea(context, element)
            ],
          ),
          sideNavigateButtons(model)
        ],
      ));
    });

    return finalList;
  }

  Stack appBarArea(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          child: Image.asset(
            'asset/masjid_arc.png',
          ),
        ),
        Positioned(
          bottom: 0,
          child: SizedBox(
            // width: MediaQuery.of(context).size.width / 2.3,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              // color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Image.asset('asset/bismillah.png')),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Expanded textShowArea(BuildContext context, WirdModel element) {
    return Expanded(
      flex: 3,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 40,
                ),
                Expanded(child: arabicTextWidget(context, element)),
                const SizedBox(
                  width: 40,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container arabicTextWidget(BuildContext context, WirdModel element) {
    return Container(
      color: Colors.transparent,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text("${element.arabic} ",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'AmiriQuran'))),
              const SizedBox(
                height: 30,
              ),
              Text(
                '(${element.rep} times)',
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column sideNavigateButtons(WirdProvider model) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(flex: 2, child: SizedBox()),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  model.onLeftNavigateButtonClicked();
                },
                child: const Icon(
                  Icons.arrow_left,
                  size: 40,
                  color: WirdColors.seconderyColor,
                ),
              ),
              const Expanded(child: SizedBox()),
              InkWell(
                onTap: () {
                  model.onRightNavigateButtonClicked();
                },
                child: const Icon(
                  Icons.arrow_right,
                  size: 50,
                  color: WirdColors.seconderyColor,
                ),
              ),
            ],
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }

  Widget bottomCounterButton(BuildContext context, WirdProvider model) {
    return SizedBox(
      height: 180,
      child: Stack(
        // clipBehavior: Clip.none,
        children: [
          RotatedBox(
              quarterTurns: 2,
              child: ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromARGB(56, 94, 142, 1),
                    Color.fromARGB(25, 56, 94, 1),
                    Color.fromARGB(31, 10, 77, 1),
                  ])),
                  height: 180,
                ),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 150,
              child: GestureDetector(
                onTap: () async {
                  // countButtonMethod(wirdData);
                  model.onFingerPrintButtonClicked(context);
                },
                child: RotatedBox(
                  quarterTurns: 2,
                  child: ClipPath(
                    clipper: CurveClipper(),
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                WirdColors.primaryColor,
                                WirdColors.primaryColor,
                                WirdColors.primaryColor,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),

                          // ),
                        ),
                        // width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Expanded(
                                child: SizedBox(
                              height: 20,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 30.0,
                                ),
                                child: model.currentPage == 0 &&
                                            model.currentPage != 1 ||
                                        model.currentPage == 45
                                    ? Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          model.currentPage == 0
                                              ? const Text(
                                                  'START',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          172, 255, 255, 255),
                                                      fontFamily: 'BlackOpsOne',
                                                      // fontWeight:
                                                      // FontWeight.w800,
                                                      fontSize: 50),
                                                )
                                              : const Text(
                                                  'END',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          162, 255, 255, 255),
                                                      fontFamily: 'BlackOpsOne',
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 50),
                                                )
                                        ],
                                      )
                                    : Stack(children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            'asset/white_fingerprint.png',
                                            color:
                                                Colors.white.withOpacity(0.4),
                                            colorBlendMode: BlendMode.modulate,
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.center,
                                            child: model.count == 0
                                                ? const SizedBox()
                                                : Text(
                                                    '${model.count}',
                                                    // count.toString(),
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'BlackOpsOne',
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                        fontSize: 50,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))
                                      ]),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          model.currentPage == 0 || model.currentPage == 45
              ? const SizedBox()
              : Positioned(
                  top: 5,
                  left: 0,
                  right: 0,
                  child: Builder(builder: (context) {
                    var verseLeft = widget.wirdList!.length - model.currentPage;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$verseLeft wird left",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    );
                  }),
                )
        ],
      ),
    );
  }
}

class IntroWidget extends StatelessWidget {
  const IntroWidget({
    super.key,
    required this.controller,
    required this.appbar,
  });

  final PageController controller;
  final Widget appbar;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          appbar,
          const Padding(
            padding: EdgeInsets.all(30.0),
            child: HamzaYusfMsg(),
          ),
          const Text(
            'Sheikh Hamza Yusuf',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}

class OutroWidget extends StatelessWidget {
  const OutroWidget({
    super.key,
    required this.controller,
    required this.appbar,
  });

  final PageController controller;
  final Widget appbar;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          appbar,
          const Padding(
            padding: EdgeInsets.all(30.0),
            child: BioOfHaddad(),
          ),
        ],
      ),
    );
  }
}
