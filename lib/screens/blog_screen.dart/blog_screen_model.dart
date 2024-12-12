import 'package:flutter/foundation.dart';
import 'package:wirdul_latif/api/firebase_analytics.dart';

class BlogScreenModel with ChangeNotifier {
  BlogScreenModel() {
    FirbaseApi.screenTracker(
      'blog screen',
    );
  }
}
