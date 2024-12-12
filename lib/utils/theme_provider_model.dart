import 'package:flutter/material.dart';
import 'package:wirdul_latif/api/local_storage_api.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = true;
  bool _isEnglishTranslation = true;
  bool _isTransliteration = true;

  bool get isDarkMode => _isDarkMode;
  bool get isEnglishTranslation => _isEnglishTranslation;
  bool get isTransliteration => _isTransliteration;

  ThemeProvider() {
    _loadSettingsFromPrefs();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    localStorage().saveDarkMode(_isDarkMode);
    notifyListeners();
  }

  void toggleEnglishTranslation() {
    _isEnglishTranslation = !_isEnglishTranslation;
    localStorage().saveShowEnglishTranslation(_isEnglishTranslation);
    notifyListeners();
  }

  void toggleTransliteration() {
    _isTransliteration = !_isTransliteration;
    localStorage().saveShowTransliteration(isTransliteration);
    notifyListeners();
  }

  Future<void> _loadSettingsFromPrefs() async {
    _isDarkMode = await localStorage().getDarkMode();
    _isEnglishTranslation = await localStorage().getShowEnglishTranslation();
    _isTransliteration = await localStorage().getShowTransliteration();
    notifyListeners();
  }
}
