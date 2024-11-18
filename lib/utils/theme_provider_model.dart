import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = true;
  bool _isEnglishTranslation = true;

  bool get isDarkMode => _isDarkMode;
  bool get isEnglishTranslation => _isEnglishTranslation;

  ThemeProvider() {
    _loadSettingsFromPrefs();
    //// Load the theme on initialization
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    _saveDarkModeToPrefs(); // Save the updated theme to local storage
    notifyListeners();
  }

  void toggleEnglishTranslation() {
    _isEnglishTranslation = !_isEnglishTranslation;
    _saveEnglishTranslationToPrefs();
    notifyListeners();
  }

  Future<void> _loadSettingsFromPrefs() async {
    final darkModePrefs = await SharedPreferences.getInstance();
    final englishTranslationPrefs = await SharedPreferences.getInstance();

    _isDarkMode =
        darkModePrefs.getBool('isDarkMode') ?? true; // Default to true

    _isEnglishTranslation =
        englishTranslationPrefs.getBool('isEnglishTranslation') ??
            true; // Default to true

    notifyListeners();
  }

  Future<void> _saveDarkModeToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  Future<void> _saveEnglishTranslationToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isEnglishTranslation', _isEnglishTranslation);
  }
}
