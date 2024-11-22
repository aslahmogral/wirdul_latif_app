import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
    return Column(
      // alignment: Alignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(),
        Center(
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          ),
        ),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Icon(Icons.play_arrow),
                        backgroundColor: Colors.teal,
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Motivational Video ',style: TextStyle(color: Colors.white),),
                          Text('Wirdul Latif'),
                        ],
                      ),
                    ],
                  )
                ),

               
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite),
                        color: Colors.white,
                      ),
                      Transform.rotate(
                        angle: -0.5, // Adjust the angle as needed
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.send),
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
