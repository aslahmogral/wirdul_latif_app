import 'package:flutter/material.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:wirdul_latif/screens/reels_screen/youtube_player_item_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeReelsScreen extends StatefulWidget {
  const YoutubeReelsScreen({Key? key}) : super(key: key);

  @override
  State<YoutubeReelsScreen> createState() => _YoutubeReelsScreenState();
}

class _YoutubeReelsScreenState extends State<YoutubeReelsScreen> {
  final List<dynamic> videoIds = WirdulLatif.Reels;

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: videoIds[0],
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: true,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 2,
        leading: SizedBox(),
        title: Text('Shorts'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close))
        ],
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videoIds.length,
        itemBuilder: (context, index) {
          return YoutubePlayerItem(
            videoId: videoIds[index], controller: _controller,
            // controller: _controller,
          );
        },
      ),
    );
  }
}
