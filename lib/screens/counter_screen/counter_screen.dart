import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/screens/counter_screen/counter_screen_model.dart';
import 'package:wirdul_latif/utils/colors.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => CounterScreenModel(context)),
      ],
      child: Consumer<CounterScreenModel>(builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Zikr Counter'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  quranMessageSection(),
                  SizedBox(
                    height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        child: TextField(
                          controller: model.countController,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                              // labelText: 'Enter a Zikr Number',

                              ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            // model.setCount(value);
                          },
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () => model.startCounter(context),
                          child: Text('GO..'))
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () => model.setCount('33'),
                          child: Text('33')),
                      ElevatedButton(
                          onPressed: () => model.setCount('100'),
                          child: Text('100')),
                      ElevatedButton(
                          onPressed: () => model.setCount('313'),
                          child: Text('313')),
                      ElevatedButton(
                          onPressed: () => model.setCount('1000'),
                          child: Text('1000')),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        model.setCount('1000000000');
                      },
                      label: Text('Infinite'),
                      icon: Icon(Icons.all_inclusive))
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Stack quranMessageSection() {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        // Container(
        //   height: 200,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(15),
        //     image: const DecorationImage(
        //       image: AssetImage(Initialize.quranQuotes),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
        Container(
          height: 200,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 0, 0),
              borderRadius: BorderRadius.circular(15),
              gradient: WirdGradients.listTileShadeGradient),
        ),
        Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '“And glorify the praises of your Lord before sunrise before sunset”',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Text(
                    'Quran 50:39',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow),
                  )
                ],
              ),
            ),
          ),
          height: 200,
        ),
      ],
    );
  }
}
