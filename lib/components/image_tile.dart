import 'package:flutter/material.dart';
import 'package:swell_mobile_ui/models/feed.dart';
import 'package:swell_mobile_ui/screens/preview_screen.dart';

const BASE_URL = 'https://api.squarrin.com';


class ImageTile extends StatelessWidget {
  final Feed feed;
  ImageTile(this.feed);


  Widget build(BuildContext context) {
    final url = feed.media_type == "VIDEO" ? feed.thumbnail_path : feed.path;
    return GestureDetector(
        onTap: () => {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PreviewScreen(feed)))
        },
        child: GridTile(

            header: GridTileBar(
              leading : feed.media_type == "VIDEO" ? Icon(Icons.videocam) : Icon(Icons.photo_camera),
            ),
            child: Image.network('$BASE_URL/$url', fit: BoxFit.cover)));
  }
}