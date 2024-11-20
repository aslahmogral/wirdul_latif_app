import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wirdul_latif/model/wird.dart';

class WirdulLatif {
  static List<Wird> morningWird = [];
  static List<Wird> eveningWird = [];
  static List<Wird> Zikr = [];
  static Map<String, Map<String, dynamic>> _wirdList = {};
  static int wirdVersion = 0;
  static List<dynamic> Reels = [];
  static List<dynamic> blogs = [];

  Future<void> initWirdData({bool sync = false}) async {
    final bool versionChanged = await hasVersionChanged();
    if (sync || versionChanged) {
      final prefs = await SharedPreferences.getInstance();
      final response = await http.get(Uri.parse(
          'https://aslahmogral.github.io/wird-al-latif-json/wird.json'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is Map<String, dynamic>) {
          _wirdList = data.map((key, value) {
            if (value is Map<String, dynamic>) {
              return MapEntry(key, value);
            } else {
              throw Exception('Invalid data structure');
            }
          });

          await prefs.setString('wird_data', jsonEncode(_wirdList));
        } else {
          throw Exception('Invalid data structure');
        }
      } else {
        throw Exception('Failed to load JSON');
      }
    } else {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString('wird_data');
      if (data == null) {
        await initWirdData(sync: true);
      } else {
        final wirdData = jsonDecode(data);
        if (wirdData is Map<String, dynamic>) {
          _wirdList = wirdData.map((key, value) {
            if (value is Map<String, dynamic>) {
              return MapEntry(key, value);
            } else {
              throw Exception('Invalid data structure');
            }
          });

          await prefs.setString('wird_data', jsonEncode(_wirdList));
        } else {
          throw Exception('Invalid data structure');
        }
      }
    }
    getContents(sync: sync, versionChanged: versionChanged);
    morningWird = _getMorningWird();
    eveningWird = _getEveningWird();
  }

  Future<void> getContents({sync, versionChanged}) async {
    if (sync || versionChanged) {
      final prefs = await SharedPreferences.getInstance();
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
    } else {
      final prefs = await SharedPreferences.getInstance();
      final reelsFromPrefs = prefs.getString('reels');
      if (reelsFromPrefs == null) {
        await getContents();
      } else {
        final reelsData = jsonDecode(reelsFromPrefs);
        Reels = reelsData;
        await prefs.setString('reels', jsonEncode(Reels));
      }

       final blogsFromPrefs = prefs.getString('blogs');
      if (blogsFromPrefs == null) {
        await getContents();
      } else {
        final blogsData = jsonDecode(blogsFromPrefs);
        blogs = blogsData;
        await prefs.setString('blogs', jsonEncode(blogs));
      }
    }
  }

  Future<bool> hasVersionChanged() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final localVersion = prefs.getInt('version') ?? 0;

      final response = await http.get(Uri.parse(
          'https://aslahmogral.github.io/wird-al-latif-json/version.json'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is Map<String, dynamic> && data.containsKey('version')) {
          final remoteVersion = data['version'];
          if (remoteVersion != localVersion) {
            await prefs.setInt('version', remoteVersion);
            return true;
          }
        }
      }
    } on Exception {
      // Handle no internet connection
      print('No internet connection');
    }

    return false;
  }

  static List<Wird> _getMorningWird() {
    List<Wird> finalList = [];
    _wirdList.forEach((key, value) {
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
    _wirdList.forEach((key, value) {
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
