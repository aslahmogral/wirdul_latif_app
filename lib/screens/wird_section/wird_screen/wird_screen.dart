import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/screens/wird_section/home_screen/home_screen_model.dart';
import 'package:wirdul_latif/screens/wird_section/wird_screen/wird_screen_model.dart';
import 'package:wirdul_latif/utils/colors.dart';

class WirdScreen extends StatelessWidget {
  static String routename = 'wirdscreen';
  final WirdType wirdType;

  const WirdScreen({super.key, required this.wirdType});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WirdScreenModel(wirdType))
      ],
      builder: (context, child) {
        return Consumer<WirdScreenModel>(
          builder: (context, model, child) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        '${model.TitleText[0].toUpperCase()}${model.TitleText.substring(1)} Wird'),
                  ],
                ),
                actions: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
                ],
              ),
              body: PageView.builder(
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 26,
                                ),
                                Container(
                                  // padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    gradient:
                                        WirdGradients.listTileShadeGradient,
                                    borderRadius: BorderRadius.circular(15),
                                    color: WirdColors.primaryDaycolor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0,
                                        left: 16.0,
                                        right: 16.0,
                                        bottom: 8),
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
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: WirdGradients
                                            .listTileShadeGradient.colors.last
                                            .withOpacity(0.5),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        children: [
                                          Text('TRANSLATION',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall
                                                  ?.copyWith(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                              model.wirdList[index].english
                                                  .replaceAll(
                                                      RegExp(r'[˹˺]'), ''),
                                              textAlign: TextAlign.left,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall
                                                  ?.copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                  height: 100,
                                )
                              ],
                            ),
                          ),
                        ),
                        bottomBar(
                          model: model,
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
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
                          icon: Icon(Icons.skip_previous)),
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
                              ),
                             
                              Text(
                                'Completed',
                                style: TextStyle(fontSize: 10),
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
                            ),
                             
                            Text(
                              'Completed',
                              style: TextStyle(fontSize: 10),
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
                            ),
                             
                            Text(
                              'Remaining',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      IconButton(
                          onPressed: model.skipOrNextPage,
                          icon: Icon(Icons.skip_next)),
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
                      child: LinearProgressIndicator(
                        color: Colors.teal,
                        minHeight: 5,
                        value: (model.currentPage + 1) / model.wirdList.length,
                      ),
                    ),
                  ],
                ),
              ),

              //circular progress indicator
            ],
          ),
          counter(context)
        ],
      ),
    );
  }

  InkWell counter(BuildContext context) {
    return InkWell(
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
                        child: CircularProgressIndicator(
                          value: model.wirdList[model.currentPage].counted !=
                                      null &&
                                  model.wirdList[model.currentPage].counted != 0
                              ? (model.currentPageWirdCounted /
                                      model.wirdList[model.currentPage].count)
                                  .toDouble()
                              : 0,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            WirdColors.primaryDaycolor,
                          ),
                          backgroundColor: Colors.black45.withOpacity(0.2),
                        ),
                      ),
                      Container(
                        // color: Colors.green,
                        height: 80,
                        width: 80,
                        child: Center(
                          child: Text(
                            "${model.wirdList[model.currentPage].counted != null ? model.currentPageWirdCounted : 0}/${model.wirdList[model.currentPage].count.toString()}",
                          ),
                        ),
                      ),
                      Visibility(
                        visible: model.wirdList[model.currentPage].completed ??
                            false,
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
                        visible: model.tabhere,
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: WirdColors.primaryDaycolor,
                              gradient: WirdGradients.listTileShadeGradient),
                          child: Center(
                              child: Text(
                            '\t\tTAP \n Here...',
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 18),
                          )),
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
