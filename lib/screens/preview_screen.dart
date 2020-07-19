import 'package:flutter/material.dart';
import 'package:swell_mobile_ui/models/feed.dart';
import 'package:swell_mobile_ui/screens/play_video.dart';

const BASE_URL = 'https://api.squarrin.com';


class PreviewScreen extends StatelessWidget {
  final Feed feed;
  PreviewScreen(this.feed);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Preview"), centerTitle: true,),
        body: Center(child: feed.media_type == "VIDEO" ? VideoPlayerScreen('$BASE_URL/${feed.path}') : Text("Photo"))
    );
  }
}
