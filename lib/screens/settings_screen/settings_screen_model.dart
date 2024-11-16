import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wirdul_latif/utils/constants.dart';

class SettingsScreenModel with ChangeNotifier {
  // BuildContext _context;
  // SettingsScreenModel(this._context) {}

  void shareApp() {
    Share.share('Check out this amazing app: ${Constants.appLink}');
  }
}
