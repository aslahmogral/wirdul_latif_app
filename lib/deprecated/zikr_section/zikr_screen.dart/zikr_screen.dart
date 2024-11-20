import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/deprecated/zikr_section/zikr_screen.dart/zikr_screen_model.dart';
import 'package:wirdul_latif/utils/colors.dart';

class ZikrScreen extends StatelessWidget {
  static String routename = 'zikr_screen';

  const ZikrScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ZikrScreenModel())
      ],
      builder: (context, child) {
        return Consumer<ZikrScreenModel>(
          builder: (context, model, child) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Zikr O Salath'),
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
                          child: Column(
                            children: [
                              SizedBox(
                                height: 26,
                              ),
                              Center(child: arabicCard(model, index)),
                              SizedBox(
                                height: 16,
                              ),
                              translationCard(context, model, index),
                              SizedBox(
                                height: 100,
                              )
                            ],
                          ),
                        ),
                        thasbeehCounter(
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

  Container arabicCard(ZikrScreenModel model, int index) {
    return Container(
      // padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: WirdGradients.listTileShadeGradient,
        borderRadius: BorderRadius.circular(15),
        color: WirdColors.primaryDaycolor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 16.0, left: 16.0, right: 16.0, bottom: 8),
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
    );
  }

  Container translationCard(
      BuildContext context, ZikrScreenModel model, int index) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: WirdGradients.listTileShadeGradient.colors.last
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
                      ?.copyWith(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 16,
              ),
              Text(
                  model.wirdList[index].english.replaceAll(RegExp(r'[˹˺]'), ''),
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ));
  }
}

class thasbeehCounter extends StatelessWidget {
  final ZikrScreenModel model;
  const thasbeehCounter({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () {
          model.thasbeehButtonClicked();
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Visibility(
                      // visible: model.,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${model.percentageTrackerMethod()} %'),
                          Text(
                            'Completed',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${model.wirdList[model.currentPage].count - model.currentPageWirdCounted} ',
                        ),
                        Text(
                          'Remaining',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
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
            Container(
              height: 60,
              child: Column(
                children: [
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: LinearProgressIndicator(
                      color: Colors.teal,
                      minHeight: 0.5,
                      value: model.currentPage / model.wirdList.length,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Theme.of(context).scaffoldBackgroundColor),
                height: 100,
                width: 100),
            SizedBox(
              height: 70,
              width: 70,
              child: CircularProgressIndicator(
                value: model.wirdList[model.currentPage].counted != null &&
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
              child: Text(
                "${model.wirdList[model.currentPage].counted != null ? model.currentPageWirdCounted : 0}/${model.wirdList[model.currentPage].count.toString()}",
              ),
            ),
            Visibility(
              visible: (model.wirdList[model.currentPage].completed) ?? false,
              child: Container(
                height: 75,
                width: 75,
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
            )
          ],
        ),
      ),
    );
  }
}