import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/model/zikr.dart';
import 'package:wirdul_latif/deprecated/zikr_section/zikr_home_screen.dart/zikr_home_screen_model.dart';
import 'package:wirdul_latif/deprecated/zikr_section/zikr_list/zikr_list.dart';

class ZikrHomeScreen extends StatelessWidget {
  const ZikrHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ZikrHomeScreenModel>(
          create: (context) => ZikrHomeScreenModel(),
        ),
      ],
      child: Consumer<ZikrHomeScreenModel>(
        builder: (context, model, child) {
          return Scaffold(
            body: Center(
              child: Center(
                child: ListView.builder(
                    itemCount: model.favouriteList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading:
                            Icon(Icons.bolt, color: Colors.yellow, size: 30),
                        title: Text(model.favouriteList[index].zikr),
                        trailing:
                            Text(model.favouriteList[index].count.toString()),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Enter new count'),
                                content: TextField(
                                  controller: TextEditingController()
                                    ..text = model.favouriteList[index].count
                                        .toString(),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    // model.ZikrList[index].count = int.parse(value);
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    }),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  model.goToZikrListScreen(context);
                }),
          );
        },
      ),
    );
  }
}
