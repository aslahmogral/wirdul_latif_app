import 'package:flutter/material.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:wirdul_latif/widgets/firebase_analytics.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeReelsScreenModel with ChangeNotifier {
   final List<dynamic> videoIds = WirdulLatif.Reels;

  late YoutubePlayerController controller;

  YoutubeReelsScreenModel(){
     controller = YoutubePlayerController(
      initialVideoId: videoIds[0],
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: true,
        enableCaption: false,
      ),
    );

    WfirebaseAnalytics.screenTracker('Reels Screen');

  }
}