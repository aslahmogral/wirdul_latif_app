import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wirdul_latif/model/progress.dart';
import 'package:wirdul_latif/model/wird.dart';

class WirdulLatif {
  static List<Wird> morningWird = [];
  static List<Wird> eveningWird = [];
  static List<Wird> Zikr = [];
  static Map<String, Map<String, dynamic>> _wirdMap = {};
  static int wirdVersion = 0;
  static List<dynamic> Reels = [];
  static List<dynamic> blogs = [];
  static List<dynamic> progressList = [];

  Future<void> initWirdData({bool sync = false}) async {
    final bool versionChanged = await hasVersionChanged();
    final prefs = await SharedPreferences.getInstance();

    if (sync || versionChanged) {
      try {
        final response = await http.get(Uri.parse(
            'https://aslahmogral.github.io/wird-al-latif-json/wird.json'));

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data is Map<String, dynamic>) {
            _wirdMap = data.map((key, value) {
              if (value is Map<String, dynamic>) {
                return MapEntry(key, value);
              } else {
                throw Exception('Invalid data structure');
              }
            });

            await prefs.setString('wird_data', jsonEncode(_wirdMap));
          } else {
            throw Exception('Invalid data structure');
          }
        } else {
          throw Exception('Failed to load JSON');
        }
      } catch (e) {
        print("Failed to fetch remote wird.json, falling back: $e");
        await _loadWirdFromPrefsOrAssets(prefs);
      }
    } else {
      await _loadWirdFromPrefsOrAssets(prefs);
    }
    await getContents(sync: sync, versionChanged: versionChanged);
    initProgress();
    morningWird = _getMorningWird();
    eveningWird = _getEveningWird();
  }

  Future<void> _loadWirdFromPrefsOrAssets(SharedPreferences prefs) async {
    var data = prefs.getString('wird_data');
    if (data == null) {
      try {
        data = await rootBundle.loadString('asset/wird.json');
        await prefs.setString('wird_data', data);
      } catch (e) {
        print('Error reading wird.json asset fallback: $e');
        return;
      }
    }

    final wirdData = jsonDecode(data);
    if (wirdData is Map<String, dynamic>) {
      _wirdMap = wirdData.map((key, value) {
        if (value is Map<String, dynamic>) {
          return MapEntry(key, value);
        } else {
          throw Exception('Invalid data structure');
        }
      });
    } else {
      throw Exception('Invalid data structure');
    }
  }

  Future<void> initProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('progress');
    if (data == null) {
      await prefs.setString('progress', jsonEncode([]));
    } else {
      final progress = jsonDecode(data) as List;
      progressList = progress.map((e) => Progress.fromJson(e)).toList();
    }
  }

  Future<void> getContents({bool sync = false, bool versionChanged = false}) async {
    final prefs = await SharedPreferences.getInstance();
    if (sync || versionChanged) {
      try {
        final response = await http.get(Uri.parse(
            'https://aslahmogral.github.io/wird-al-latif-json/contents.json'));

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          Reels = data['reels'];
          await prefs.setString('reels', jsonEncode(Reels));

          blogs = data['blogs'];
          await prefs.setString('blogs', jsonEncode(blogs));
        } else {
          throw Exception('Failed to load JSON');
        }
      } catch (e) {
        print("Failed to fetch remote contents.json, falling back: $e");
        await _loadContentsFromPrefsOrAssets(prefs);
      }
    } else {
      await _loadContentsFromPrefsOrAssets(prefs);
    }
  }

  Future<void> _loadContentsFromPrefsOrAssets(SharedPreferences prefs) async {
    var reelsData = prefs.getString('reels');
    var blogsData = prefs.getString('blogs');

    if (reelsData == null || blogsData == null) {
      try {
        final jsonString = await rootBundle.loadString('asset/contents.json');
        final data = jsonDecode(jsonString);

        if (reelsData == null) {
          Reels = data['reels'];
          await prefs.setString('reels', jsonEncode(Reels));
        } else {
          Reels = jsonDecode(reelsData);
        }

        if (blogsData == null) {
          blogs = data['blogs'];
          await prefs.setString('blogs', jsonEncode(blogs));
        } else {
          blogs = jsonDecode(blogsData);
        }
      } catch (e) {
        print('Error reading contents.json asset fallback: $e');
      }
    } else {
      Reels = jsonDecode(reelsData);
      blogs = jsonDecode(blogsData);
    }
  }

  Future<int> _getDefaultVersion() async {
    try {
      final jsonString = await rootBundle.loadString('asset/version.json');
      final data = jsonDecode(jsonString);
      if (data is Map<String, dynamic> && data.containsKey('version')) {
        return data['version'] as int;
      }
    } catch (e) {
      print('Error reading default version asset: $e');
    }
    return 0;
  }

  Future<bool> hasVersionChanged() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var localVersion = prefs.getInt('version');
      if (localVersion == null) {
        localVersion = await _getDefaultVersion();
        await prefs.setInt('version', localVersion);
      }

      final response = await http.get(Uri.parse(
          'https://aslahmogral.github.io/wird-al-latif-json/version.json'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is Map<String, dynamic> && data.containsKey('version')) {
          final remoteVersion = data['version'] as int;
          if (remoteVersion != localVersion) {
            await prefs.setInt('version', remoteVersion);
            return true;
          }
        }
      }
    } catch (e) {
      print('No internet connection or failed to get version: $e');
    }

    return false;
  }

  static List<Wird> _getMorningWird() {
    List<Wird> finalList = [];
    _wirdMap.forEach((key, value) {
      finalList.add(Wird(
        wird: value['wird'],

        // eveningWird: value['eveningwird'],
        english: value['english'],
        transliteration: value['transliteration'],

        count: value['count'],
      ));
    });
    return finalList;
  }

  static List<Wird> _getEveningWird() {
    List<Wird> finalList = [];
    _wirdMap.forEach((key, value) {
      String eveningWird = value['eveningwird'] ?? '';
      finalList.add(Wird(
          wird: eveningWird != '' ? eveningWird : value['wird'],
          english: value['english'],
          transliteration: value['transliteration'],
          count: value['count']));
    });
    return finalList;
  }
}
