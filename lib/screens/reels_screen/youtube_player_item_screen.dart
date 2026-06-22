import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:wirdul_latif/utils/responsive.dart';

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
    final isTablet = context.isTablet;

    Widget body = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
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
                        const CircleAvatar(
                          backgroundColor: Colors.teal,
                          child: Icon(Icons.play_arrow, color: Colors.white),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Motivational Video ',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            Text('Wirdul Latif', style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ],
                    )),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          comingSoonDialog(context);
                        },
                        icon: const Icon(Icons.favorite),
                        color: Colors.white,
                      ),
                      Transform.rotate(
                        angle: -0.5, // Adjust the angle as needed
                        child: IconButton(
                          onPressed: () {
                            comingSoonDialog(context);
                          },
                          icon: const Icon(Icons.send),
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          comingSoonDialog(context);
                        },
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

    if (isTablet) {
      return Container(
        color: Colors.black,
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.teal, width: 2),
            ),
            clipBehavior: Clip.antiAlias,
            width: 400,
            height: 700,
            child: body,
          ),
        ),
      );
    }

    return body;
  }

  void comingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Coming Soon'),
          content: const Text('This feature will be available soon.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: TextStyle(color: Colors.teal)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
