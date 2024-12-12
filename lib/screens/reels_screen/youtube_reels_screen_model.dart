import 'package:flutter/material.dart';
import 'package:wirdul_latif/data/wirdul_latif_api.dart';
import 'package:wirdul_latif/widgets/firebase_analytics.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeReelsScreenModel with ChangeNotifier {
  final List<dynamic> videoIds = WirdulLatifApi.Reels;

  late YoutubePlayerController controller;

  YoutubeReelsScreenModel() {
    controller = YoutubePlayerController(
      initialVideoId: videoIds[0],
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: true,
        enableCaption: false,
      ),
    );

    FirbaseApi.screenTracker('Reels Screen');
  }
}
