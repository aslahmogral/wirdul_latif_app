import 'package:flutter/material.dart';
import 'package:wirdul_latif/screens/counter_screen/sub_screens/counter_screen_start.dart';

class CounterScreenModel with ChangeNotifier {
  TextEditingController countController = TextEditingController(text: '100');
  BuildContext _context;

  CounterScreenModel(this._context);
  setCount(
    String count,
  ) {
    countController.clear();
    countController.text = count;
    Navigator.push(
        _context,
        MaterialPageRoute(
            builder: (context) => CounterScreenStart(
                  counterNumber: int.parse(countController.text),
                )));

    notifyListeners();
  }

  startCounter(context) {
    print(countController.text);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CounterScreenStart(
                  counterNumber: int.parse(countController.text),
                )));
  }
}
