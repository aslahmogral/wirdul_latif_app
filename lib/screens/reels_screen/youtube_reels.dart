import 'package:flutter/material.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeReelsScreen extends StatefulWidget {
  const YoutubeReelsScreen({Key? key}) : super(key: key);

  @override
  State<YoutubeReelsScreen> createState() => _YoutubeReelsScreenState();
}

class _YoutubeReelsScreenState extends State<YoutubeReelsScreen> {
  final List<dynamic> videoIds = WirdulLatif.reels;

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
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close)),
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videoIds.length,
        itemBuilder: (context, index) {
          return YoutubePlayerItem(
            videoId: videoIds[index],
            controller: _controller,
          );
        },
      ),
    );
  }
}

class YoutubePlayerItem extends StatefulWidget {
  final String videoId;
  final YoutubePlayerController controller;

  const YoutubePlayerItem({
    Key? key,
    required this.videoId,
    required this.controller,
  }) : super(key: key);

  @override
  _YoutubePlayerItemState createState() => _YoutubePlayerItemState();
}

class _YoutubePlayerItemState extends State<YoutubePlayerItem> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: false,
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
    return Stack(
      alignment: Alignment.center,
      children: [
        YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
        ),
        // Positioned(
        //   bottom: 30,
        //   child: FloatingActionButton(
        //     backgroundColor: Colors.white,
        //     onPressed: () {
        //       setState(() {
        //         _controller.value.isPlaying
        //             ? _controller.pause()
        //             : _controller.play();
        //       });
        //     },
        //     child: Icon(
        //       _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        //       color: Colors.black,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
