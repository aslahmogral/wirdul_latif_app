import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:wirdul_latif/utils/constants.dart';

class SettingsScreenModel with ChangeNotifier {
  // BuildContext _context;
  // SettingsScreenModel(this._context) {}
  bool loading = false;

  void shareApp() {
    Share.share('Check out this amazing app: ${Constants.appLink}');
  }

  checkForUpdates(context) async {
    loading = true;
    notifyListeners();
    final bool updated = await WirdulLatif().hasVersionChanged();
    if(updated) {
      await WirdulLatif().initWirdData(sync: true);
    }
    loading = false;
    notifyListeners();
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
