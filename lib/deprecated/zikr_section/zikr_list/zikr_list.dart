import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/model/zikr.dart';
import 'package:wirdul_latif/deprecated/zikr_section/zikr_home_screen.dart/zikr_home_screen_model.dart';
import 'package:wirdul_latif/deprecated/zikr_section/zikr_list/zikr_list_model.dart';

class ZikrListScreen extends StatefulWidget {
  final List<Zikr> favouriteList;
  const ZikrListScreen({super.key, required this.favouriteList});

  @override
  State<ZikrListScreen> createState() => _ZikrListScreenState();
}

class _ZikrListScreenState extends State<ZikrListScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.favouriteList);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ZikrListModel(widget.favouriteList)),
      ],
      child: Consumer<ZikrListModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: model.ZikrList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Checkbox(
                        value:
                            model.favouriteList.contains(model.ZikrList[index]),
                        onChanged: (isFavorite) {
                          model.addToFavourite(
                              isFavorite: isFavorite ?? false,
                              zikr: model.ZikrList[index]);
                        },
                      ),
                      title: Text(model.ZikrList[index].zikr),
                      trailing: Text(model.ZikrList[index].count.toString()),
                    );
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, model.favouriteList);
                    },
                    child: Text('Add to Favourite'))
              ],
            ),
          );
        },
      ),
    );
  }
}
