import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/screens/wird_screen/wird_screen_model.dart';
import 'package:wirdul_latif/screens/wird_screen/wird_screen_model.dart';
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
                title: Text('wird'),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: SizedBox(
                height: 100,
                width: 100,
                child: FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: const CircleBorder(),
                  onPressed: () {},
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: CircularProgressIndicator(
                          value: 25/100,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            WirdColors.primaryDaycolor,
                          ),
                          backgroundColor: Colors.black45
                              .withOpacity(0.2),
                        ),
                      ),
                      Container(
                        child: Text(
                          '3',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  
                ),
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
                    child: SingleChildScrollView(
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
                              SizedBox(height: 100,)
                        ],
                      ),
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
