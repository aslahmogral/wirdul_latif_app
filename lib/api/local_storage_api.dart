import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class localStorage {
  /// The instance of SharedPreferences
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  /// The key to store data in SharedPreferences
  static const String _wird_data_key = 'wird_data';
  static const String _reels_key = 'reels';
  static const String _blogs_key = 'blogs';
  static const String _progress_key = 'progress';
  static const String _version_key = 'version';

  /// Save the wird data to SharedPreferences
  Future<void> saveWirdData(String data) async {
    final prefs = await _prefs;
    await prefs.setString(_wird_data_key, data);
  }

  /// Get the wird data from SharedPreferences
  Future<String?> getWirdData() async {
    final prefs = await _prefs;
    return prefs.getString(_wird_data_key);
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
  Future<void> saveProgress(List<dynamic> progress) async {
    final prefs = await _prefs;
    await prefs.setString(_progress_key, jsonEncode(progress));
  }

  /// Get the progress data from SharedPreferences
  Future<List<dynamic>?> getProgress() async {
    final prefs = await _prefs;
    final data = prefs.getString(_progress_key);
    if (data == null) return null;
    return jsonDecode(data);
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
}
