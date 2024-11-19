import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wirdul_latif/model/wird.dart';

class WirdulLatif {
  static List<Wird> morningWird = [];
  static List<Wird> eveningWird = [];
  static List<Wird> Zikr = [];

  Future<void> fetchData({bool sync = false}) async {
    if (sync) {
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
        await fetchData(sync: true);
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
  }

  // Future<void> _initFromStorage() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final data = prefs.getString('wird_data');
  //   if (data != null) {
  //     try {
  //       _wirdList = jsonDecode(data).map((key, value) {
  //         if (value is Map<String, dynamic>) {
  //           return MapEntry(key, value);
  //         } else {
  //           throw Exception('Invalid data structure');
  //         }
  //       });
  //     } catch (e) {
  //       print('Error loading data from SharedPreferences: $e');
  //     }
  //   }
  // }

  static Map<String, Map<String, dynamic>> _wirdList = {};
  static void initWird({bool sync = false}) async {
    await WirdulLatif().fetchData(sync: sync);
    morningWird = _getMorningWird();
    eveningWird = _getEveningWird();
    Zikr = [
      Wird(
          wird: 'هِ الرَّحْمَنِ الرَّحِيمِ',
          english: 'english',
          count: 3,
          transliteration: ''),
      Wird(
          wird: 'هِنِ الرَّحِيمِ',
          english: 'english',
          count: 2,
          transliteration: '')
    ];
  }

  // static List<Wird> _getZikr() {
  //   List<Wird> finalList = [];
  //   _zikrList.forEach((key, value) {
  //     finalList.add(Wird(
  //       wird: value['wird'],
  //       // eveningWird: value['eveningwird'],
  //       english: value['english'],
  //       count: value['count'],
  //     ));
  //   });
  //   return finalList;
  // }

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
