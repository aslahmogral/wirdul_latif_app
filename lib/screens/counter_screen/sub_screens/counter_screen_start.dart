import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/screens/counter_screen/sub_screens/counter_screen_start_model.dart';

class CounterScreenStart extends StatelessWidget {
  final int counterNumber;
  const CounterScreenStart({super.key, required this.counterNumber});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => CounterScreenStartModel(counterNumber)),
      ],
      child: Consumer<CounterScreenStartModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Row(
                children: [
                  Text('${model.counterNumber.toString()}'),
                  IconButton(
                      onPressed: () async {
                        int? val = await editCounterNumber(context, model);
                        if(val != null)
                        model.changeCounterNumber(val);
                      },
                      icon: Icon(Icons.edit))
                ],
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      model.reset();
                    },
                    icon: Icon(Icons.refresh))
              ],
            ),
            body: InkWell(
              onTap: () {
                model.increment();
              },
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          model.count.toString(),
                          style: const TextStyle(
                            fontSize: 100,
                          ),
                        ),
                        Visibility(
                            visible: !model.infinite,
                            child: Text('/ ${model.counterNumber}')),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Visibility(
                        visible: model.extraAmountVisible,
                        child: Text(
                          '+${model.extraCount.toString()}',
                          style: TextStyle(color: Colors.green),
                        ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<int?> editCounterNumber(context, CounterScreenStartModel model) {
    final controller = TextEditingController();
    return showDialog<int>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Change Counter Number'),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Enter a new counter number',
              ),
              keyboardType: TextInputType.number,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(null);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(int.parse(controller.text));
                },
                child: Text('Change'),
              ),
            ],
          );
        });
  }
}

