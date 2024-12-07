import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/screens/reels_screen/youtube_player_item_screen.dart';
import 'package:wirdul_latif/screens/reels_screen/youtube_reels_screen_model.dart';

class YoutubeReelsScreen extends StatefulWidget {
  const YoutubeReelsScreen({Key? key}) : super(key: key);

  @override
  State<YoutubeReelsScreen> createState() => _YoutubeReelsScreenState();
}

class _YoutubeReelsScreenState extends State<YoutubeReelsScreen> {

  @override
  void initState() {
    super.initState();
   
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => YoutubeReelsScreenModel(),
      child: Consumer<YoutubeReelsScreenModel>(
        builder: (context, model, child) {
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
              itemCount: model.videoIds.length,
              itemBuilder: (context, index) {
                return YoutubePlayerItem(
                  videoId: model.videoIds[index],
                  controller:model.controller,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
