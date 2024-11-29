import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:wirdul_latif/screens/home_screen/home_screen_model.dart';
import 'package:wirdul_latif/utils/constants.dart';

class SettingsScreenModel with ChangeNotifier {
  // BuildContext _context;
  // SettingsScreenModel(this._context) {}
  bool loading = false;

  void shareApp() {
    Share.share('Check out this amazing app: ${Constants.appLink}');
  }

  void rateApp() {
    launchUrl(
      Uri.parse(
        Constants.appLink,
      ),
    );
  }

  // void moreApps() {
  //   launchUrl(
  //     Uri.parse(
  //       Constants.moreAppLink,
  //     ),
  //   );
  // }

  clearStats(context, HomeScreenModel model) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Clear Progress'),
          content: Text('Are you sure you want to clear your progress?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Clear',style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
    if (confirm ?? false) {
      {
        WirdulLatif().initWirdData(sync: false);
        final prefs = await SharedPreferences.getInstance();
        WirdulLatif.progressList = [];
        await prefs.setString('progress', jsonEncode([]));
        model.calculateStreak();
        model.checkProgress();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Progress has been cleared.',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
          ),
        );
      }
    }
  }

  checkForUpdates(context) async {
    loading = true;
    notifyListeners();
    final bool updated = await WirdulLatif().hasVersionChanged();
    if (updated) {
      await WirdulLatif().initWirdData(sync: true);
    }
    loading = false;
    notifyListeners();
    Navigator.of(context).pop(); // close navbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          updated
              ? 'New wird corrections have been updated.'
              : 'No new updates available.',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: updated ? Colors.green : Colors.orange,
      ),
    );
  }
}
