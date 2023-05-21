import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/components/curve.dart';
import 'package:wirdul_latif/model/wird_model.dart';
import 'package:wirdul_latif/provider/wird_provider.dart';
import 'package:wirdul_latif/screens/hamza_yusuf_msg.dart';
import 'package:wirdul_latif/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  final List<WirdModel>? wirdList;
  const HomeScreen({super.key, required this.wirdList});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = PageController(initialPage: 0);
  int count = 0;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   getWirdData();
    // });
    _currentPage = 0;
    controller.addListener(() {
      setState(() {
        _currentPage = controller.page!.toInt();
      });
    });
  }

  List<Widget> bodyWidget(List<WirdModel>? wirdlist) {
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
          sideNavigateButtons()
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
                    )))),
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
                    style: GoogleFonts.amiri(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    )),
              ),
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

  Column sideNavigateButtons() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(flex: 2, child: SizedBox()),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              InkWell(
                onTap: () => {
                  controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear)
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
                  controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WirdProvider>(
          builder: (BuildContext context, wirdData, Widget? child) {
        return PageView(
          controller: controller,
          children: [
            IntroWidget(
              controller: controller,
              appbar: appBarArea(context),
            ),
            ...bodyWidget(widget.wirdList),
            OutroWidget(controller: controller, appbar: appBarArea(context))
          ],
        );
      }),
      bottomNavigationBar: bottomCounterButton(context),
    );
  }

  Widget bottomCounterButton(
    BuildContext context,
  ) {
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
                  if (_currentPage == 0) {
                    controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear);
                  } else if (_currentPage == 44) {
                    controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear);
                  } else if (_currentPage == 45) {
                    showDialog(
                      context: context,
                      builder: (context) =>  AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:  [
                            const Text('Are you Sure You \n Want Close The App',textAlign: TextAlign.center,),
                            const SizedBox(height: 16,),
                            ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
                              onPressed: (){
                            
                              SystemNavigator.pop();
                            }, child:const  Text('EXIT'))
                          ],
                        ),
                      ),
                    );
                  } else {
                    var rep = widget.wirdList![controller.page!.toInt()].rep;
                    setState(() {
                      count++;
                    });
                    if (rep == count || rep < count) {
                      count = 0;
                      controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear);
                    }
                  }
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
                                Color.fromARGB(255, 239, 211, 133),
                                Color.fromARGB(255, 236, 205, 117),
                                Color(0xffF3C137),
                                Color(0xffF3C137),
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
                                child: _currentPage == 0 || _currentPage == 45
                                    ? Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          _currentPage == 0
                                              ? const Text(
                                                  'START',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 50),
                                                )
                                              : const Text(
                                                  'END',
                                                  style: TextStyle(
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
                                            child: Text(
                                              '$count',
                                              // count.toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 50,
                                                  fontWeight: FontWeight.bold),
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
          _currentPage == 0 || _currentPage == 45
              ? const SizedBox()
              : Positioned(
                  top: 5,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("$_currentPage /${widget.wirdList!.length}")
                    ],
                  ),
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
    return Column(
      // mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        appbar,
        const Padding(
          padding: EdgeInsets.all(30.0),
          child: HamzaYusfMsg(),
        ),
        const Text(
          '-Sheikh Hamza Yusuf',
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
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
