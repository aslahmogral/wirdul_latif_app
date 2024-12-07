import 'package:flutter/foundation.dart';
import 'package:wirdul_latif/widgets/firebase_analytics.dart';

class BlogScreenModel with ChangeNotifier {
  BlogScreenModel() {
    WfirebaseAnalytics.screenTracker('blog screen',);
  }
}
