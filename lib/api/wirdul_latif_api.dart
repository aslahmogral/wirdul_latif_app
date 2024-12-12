import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wirdul_latif/api/local_storage_api.dart';
import 'package:wirdul_latif/model/progress.dart';
import 'package:wirdul_latif/model/wird.dart';

class WirdulLatifApi {
  // static List<Wird> morningWird = [];
  // static List<Wird> eveningWird = [];
  static List<Wird> haddad = [];

  static Map<String, Map<String, dynamic>> _wirdMap = {};
  static List<dynamic> reels = [];
  static List<dynamic> blogs = [];
  static List<dynamic> progressList = [];

  static const String _reels_key = 'reels';
  static const String _blogs_key = 'blogs';
  static const String _version_key = 'version';

  static const String _contentsUrl =
      'https://aslahmogral.github.io/wird-al-latif-json/contents.json';
  static const String _wirdUrl =
      'https://aslahmogral.github.io/wird-al-latif-json/haddad.json';

  Future<void> initWirdData({bool sync = false}) async {
    final bool versionChanged = await hasVersionChanged();
    if (sync || versionChanged) {
      final response = await http.get(Uri.parse(_wirdUrl));

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
          await localStorage().saveWirdData(_wirdMap);
        } else {
          throw Exception('Invalid data structure');
        }
      } else {
        throw Exception('Failed to load JSON');
      }
    } else {
      final wirdData = await localStorage().getWirdData();
      if (wirdData == null) {
        await initWirdData(sync: true);
      } else {
        _wirdMap = wirdData.map((key, value) {
          if (value is Map<String, dynamic>) {
            return MapEntry(key, value);
          } else {
            throw Exception('Invalid data structure');
          }
        });
      }
    }
    getContents(sync: sync, versionChanged: versionChanged);
    await localStorage().getProgress();
    // morningWird = _getMorningWird();
    // eveningWird = _getEveningWird();
    haddad = _getHaddad();
  }



  Future<void> getContents({sync, versionChanged}) async {
    if (sync || versionChanged) {
      final response = await http.get(Uri.parse(_contentsUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        reels = data[_reels_key];
        await localStorage().saveReels(reels);

        blogs = data[_blogs_key];
        await localStorage().saveBlogs(blogs);
      } else {
        throw Exception('Failed to load JSON');
      }
    } else {
      final reels = await localStorage().getReels();
      if (reels == null) {
        await getContents();
      }

      final blogs = await localStorage().getBlogs();
      if (blogs == null) {
        await getContents();
      }
    }
  }

  Future<bool> hasVersionChanged() async {
    try {
      final localVersion = await localStorage().getVersion();
      final response = await http.get(Uri.parse(
          'https://aslahmogral.github.io/wird-al-latif-json/version.json'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is Map<String, dynamic> && data.containsKey(_version_key)) {
          final remoteVersion = data[_version_key];
          if (remoteVersion != localVersion) {
            await localStorage().saveVersion(remoteVersion);
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

  static List<Wird> _getHaddad() {
    List<Wird> finalList = [];
    _wirdMap.forEach((key, value) {
      // String eveningWird = value['eveningwird'] ?? '';
      finalList.add(Wird(
          wird:value['wird'],
          english: value['english'],
          transliteration: value['transliteration'],
          count: value['count']));
    });
    return finalList;
  }
}
