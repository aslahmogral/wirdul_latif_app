import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wirdul_latif/api/wirdul_latif_api.dart';
import 'package:wirdul_latif/model/progress.dart';

class localStorage {
  /// The instance of SharedPreferences
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  /// The key to store data in SharedPreferences
  static const String _wird_data_key = 'wird_data';
  static const String _reels_key = 'reels';
  static const String _blogs_key = 'blogs';
  static const String _progress_key = 'progress';
  static const String _version_key = 'version';
  static const String _fontsize_key = 'fontsize';
  static const String _onboarding_key = 'hasSeenOnboarding';
  static const String _darkMode_key = 'isDarkMode';
  static const String _showEnglishTranslation_key = 'isEnglishTranslation';
  static const String _isTransliteration_key = 'isTransliterationPrefs';

  /// Save the wird data to SharedPreferences
  Future<void> saveWirdData(Map<String, Map<String, dynamic>> data) async {
    final prefs = await _prefs;
    await prefs.setString(_wird_data_key, jsonEncode(data));
  }

  /// Get the wird data from SharedPreferences
  Future<Map<String, dynamic>?> getWirdData() async {
    final prefs = await _prefs;
    final data = prefs.getString(_wird_data_key);
    if (data == null) return null;
    return jsonDecode(data);
  }

  /// Save the reels data to SharedPreferences
  Future<void> saveReels(List<dynamic> reels) async {
    final prefs = await _prefs;
    await prefs.setString(_reels_key, jsonEncode(reels));
  }

  /// Get the reels data from SharedPreferences
  Future<List<dynamic>?> getReels() async {
    final prefs = await _prefs;
    final data = prefs.getString(_reels_key);
    if (data == null) return null;
    return jsonDecode(data);
  }

  /// Save the blogs data to SharedPreferences
  Future<void> saveBlogs(List<dynamic> blogs) async {
    final prefs = await _prefs;
    await prefs.setString(_blogs_key, jsonEncode(blogs));
  }

  /// Get the blogs data from SharedPreferences
  Future<List<dynamic>?> getBlogs() async {
    final prefs = await _prefs;
    final data = prefs.getString(_blogs_key);
    if (data == null) return null;
    return jsonDecode(data);
  }

  /// Save the progress data to SharedPreferences
  Future<void> saveProgress() async {
    final prefs = await _prefs;
    final progressListJson =
        await WirdulLatifApi.progressList.map((e) => e.toJson()).toList();
    await prefs.setString(_progress_key, jsonEncode(progressListJson));
  }

  /// Get the progress data from SharedPreferences
  Future<void> getProgress() async {
    final prefs = await _prefs;
    final data = prefs.getString(_progress_key);
    if (data == null) {
      await saveProgress();
      return;
    }
    WirdulLatifApi.progressList = (jsonDecode(data) as List<dynamic>)
        .map<Progress>((e) => Progress.fromJson(e))
        .toList();
  }

  Future<void> clearProgress() async {
    final prefs = await _prefs;
    await prefs.remove(_progress_key);
  }

  Future<void> saveVersion(int version) async {
    final prefs = await _prefs;
    await prefs.setInt(_version_key, version);
  }

  Future<int> getVersion() async {
    final prefs = await _prefs;
    final data = prefs.getInt(_version_key);
    if (data == null) return 0;
    return data;
  }

  Future<void> saveFontSize(double fontsize) async {
    final prefs = await _prefs;
    await prefs.setDouble(_fontsize_key, fontsize);
  }

  Future<double> getFontSize() async {
    final prefs = await _prefs;
    final data =await prefs.getDouble(_fontsize_key);
    if (data == null) return 24.0;
    return data;
  }

  Future<void> seenOnboardingScreen() async {
    final prefs = await _prefs;
    await prefs.setBool(_onboarding_key, true);
  }

  Future<bool> getSeenOnboarding() async {
    final prefs = await _prefs;
    bool data = await prefs.getBool(_onboarding_key) ?? false;
    return data;
  }

  Future<void> saveDarkMode(bool darkMode) async {
    final prefs = await _prefs;
    await prefs.setBool(_darkMode_key, darkMode);
  }

  Future<bool> getDarkMode() async {
    final prefs = await _prefs;
    bool data = await prefs.getBool(_darkMode_key) ?? true;
    return data;
  }

  Future<void> saveShowEnglishTranslation(bool showEnglishTranslation) async {
    final prefs = await _prefs;
    await prefs.setBool(_showEnglishTranslation_key, showEnglishTranslation);
  }

  Future<bool> getShowEnglishTranslation() async {
    final prefs = await _prefs;
    bool data = await prefs.getBool(_showEnglishTranslation_key) ?? true;
    return data;
  }

   Future<void> saveShowTransliteration(bool showTransliteration) async {
    final prefs = await _prefs;
    await prefs.setBool(_isTransliteration_key, showTransliteration);
  }

  Future<bool> getShowTransliteration() async {
    final prefs = await _prefs;
    bool data = await prefs.getBool(_isTransliteration_key) ?? true;
    return data;
  }
}
