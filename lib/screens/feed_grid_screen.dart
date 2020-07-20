import 'package:flutter/material.dart';
import 'package:swell_mobile_ui/models/cart.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/screens/play_video.dart';
import 'package:swell_mobile_ui/screens/profile.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/models/user.dart';
import 'package:swell_mobile_ui/services/api_service.dart';
import 'package:swell_mobile_ui/models/video.dart';
import 'package:swell_mobile_ui/models/item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:swell_mobile_ui/models/feed.dart';
import 'package:swell_mobile_ui/components/image_tile.dart';

// TODO should check if register

const BASE_URL = 'https://api.squarrin.com';

class FeedGridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var api = Provider.of<ApiService>(context, listen: false);
    //var cart = Provider.of<CartModel>(context, listen: true);
    var user = Provider.of<User>(context, listen: false);
    var feeds = Provider.of<List<Feed>>(context, listen: true);
    return
      Consumer<CartModel>(
        builder: (context, cart, child) {
          return Scaffold(
            body: Center(
                child: Consumer<List<Feed>>(
                    builder: (context, lstFeed, child) {
                      if (lstFeed == null) {
                        return CircularProgressIndicator();
                      } else {
                        return GridView.count(
                          crossAxisCount: 3,
                          childAspectRatio: 1.0,
                          mainAxisSpacing: 1.5,
                          crossAxisSpacing: 1.5,
                          shrinkWrap: true,
                          //physics: const NeverScrollableScrollPhysics(),
                          children: lstFeed.map((elem) {
                            if (cart.hasItem(elem)) {
                              return Container();
                            } else {
                              return ImageTile(elem);
                            }
                          }).toList(),

                        );
                      }
                    }
                )
            ),
          );
        });
    /*
    return Scaffold(
      body: Center(
        child: Consumer<User>(
          builder: (context, profile, child) {
            if (profile != null) {
              return Text('in home with ${profile.login}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );*/
  }
}