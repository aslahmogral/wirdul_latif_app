import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wirdul_latif/model/wird_model.dart';
import 'package:wirdul_latif/service/wird_from_json.dart';

class WirdProvider with ChangeNotifier {
  final controller = PageController(initialPage: 0);
  int count = 0;
  int currentPage = 0;

  late final List<WirdModel>? wirdList;

  List<WirdModel>? _wirddata;

  List<WirdModel>? get wirddata => _wirddata;

  Future<void> loadLocalJsonData() async {
    _wirddata = await WirdService().loadLocalJsonData();

    notifyListeners();
  }

  WirdProvider.main() {
    // print('wird laif');
  }

  vibrateOnButtonClick() {
    HapticFeedback.lightImpact();
  }

  WirdProvider(
    context,
    List<WirdModel>? wirdlists,
  ) {
    wirdList = wirdlists;
    currentPage = 0;
    controller.addListener(() {
      currentPage = controller.page!.toInt();
    });
    notifyListeners();
  }

  void rebuildPage() {
    notifyListeners();
  }

  void onFingerPrintButtonClicked(BuildContext context) {
    notifyListeners();
    if (currentPage == 0) {
      vibrateOnButtonClick();
      nextPage();
    } else if (currentPage == 44) {
      vibrateOnButtonClick();

      nextPage();
    } else if (currentPage == 45) {
      vibrateOnButtonClick();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0))),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Are you Sure You \n Want Close The App',
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text('EXIT'))
            ],
          ),
        ),
      );
    } else {
      var rep = wirdList![controller.page!.toInt() - 1].rep;
      // vibrateOnButtonClick();
      count++;
      notifyListeners();
      if (rep == count || rep < count) {
        vibrateOnButtonClick();

        count = 0;
        nextPage();
      }
    }
  }

  void onRightNavigateButtonClicked() {
    count = 0;
    nextPage();
  }

  void nextPage() {
    controller.nextPage(
        duration: const Duration(milliseconds: 1), curve: Curves.linear);
  }

  void onLeftNavigateButtonClicked() {
    count = 0;
    controller.previousPage(
        duration: const Duration(milliseconds: 1), curve: Curves.linear);
  }
}
