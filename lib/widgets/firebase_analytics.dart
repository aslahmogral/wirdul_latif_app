import 'package:firebase_analytics/firebase_analytics.dart';

class FirbaseApi {
  static FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static void screenTracker(String screenName,
      {Map<String, String>? parameters}) {
    _analytics.logScreenView(
        screenName: screenName,
        screenClass: screenName,
        parameters: parameters);
  }

  static void logWirdProgress(String type, String progress) {
    _analytics.logEvent(
        parameters: {'type': type, 'progress': progress},
        name: 'wird_progress');
  }

  static void logZikrCount(String count) {
    _analytics.logEvent(parameters: {'count': count}, name: 'Zikr');
  }
}
