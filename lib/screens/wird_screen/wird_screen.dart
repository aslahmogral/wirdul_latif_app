import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/screens/wird_screen/wird_screen_model.dart';
import 'package:wirdul_latif/utils/colors.dart';

class WirdScreen extends StatelessWidget {
  static String routename = 'wirdscreen';

  const WirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WirdScreenModel(arguments))
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
                    model.type == WirdType.morning
                        ? Text('Morning Wird')
                        : Text('Evening Wird'),
                    Text(
                      '${model.currentPage + 1} / 44',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                actions: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        backgroundColor: Colors.black45.withOpacity(0.2),
                        value: (model.currentPage + 1) / model.wirdList.length ,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            WirdColors.primaryColor),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if(model.currentPage ==0)
                      Text(
                        '0%',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      
                      Visibility(
                        visible: model.currentPage != 0,
                        child: Text(
                          '${((model.currentPage + 1) / model.wirdList.length * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                              Container(
                                // padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  gradient: WirdGradients.listTileShadeGradient,
                                  borderRadius: BorderRadius.circular(15),
                                  color: WirdColors.primaryDaycolor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    model.wirdList[index].wird,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24
                                        // fontFamily: 'AmiriQuran',
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
                                        Text(
                                          'TRANSLATION',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 22
                                              // fontFamily: 'AmiriQuran',
                                              ),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          model.wirdList[index].english
                                              .replaceAll(RegExp(r'[˹˺]'), ''),
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                              // fontFamily: 'AmiriQuran',
                                              ),
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 100,
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () {
                              model.thasbeehButtonClicked();
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height: 70,
                                  width: 70,
                                  child: CircularProgressIndicator(
                                    value: model.wirdList[model.currentPage]
                                                    .counted !=
                                                null &&
                                            model.wirdList[model.currentPage]
                                                    .counted !=
                                                0
                                        ? (model.currentPageWirdCounted /
                                                model
                                                    .wirdList[model.currentPage]
                                                    .count)
                                            .toDouble()
                                        : 0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      WirdColors.primaryDaycolor,
                                    ),
                                    backgroundColor:
                                        Colors.black45.withOpacity(0.2),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "${model.wirdList[model.currentPage].counted != null ? model.currentPageWirdCounted : 0}/${model.wirdList[model.currentPage].count.toString()}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Visibility(
                                  visible: model.wirdList[model.currentPage]
                                          .completed ??
                                      false,
                                  child: Container(
                                    height: 75,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: WirdColors.primaryDaycolor,
                                        gradient: WirdGradients
                                            .listTileShadeGradient),
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
