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
import 'package:swell_mobile_ui/components/profile.dart';


// TODO should check if register

const BASE_URL = 'https://api.squarrin.com';

class FeedGridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var api = Provider.of<ApiService>(context, listen: false);
    //var cart = Provider.of<CartModel>(context, listen: true);
    var user = Provider.of<User>(context, listen: false);
    var feeds = Provider.of<List<Feed>>(context, listen: true);
    return Consumer<CartModel>(builder: (context, cart, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: Text("Squarrin"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: UserSearch());
              },
            ),
          ],
        ),
        body: Center(
            child: Consumer<List<Feed>>(builder: (context, lstFeed, child) {
              if (lstFeed == null) {
                return Center(child: CircularProgressIndicator());
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
            })),
      );
    });
  }
}

class UserSearch extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Search';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () {
        query = "";
      }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: AnimatedIcon(
      icon: AnimatedIcons.menu_arrow, progress: transitionAnimation,),
      onPressed: () {
        close(context, null);
      },);
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var api = Provider.of<ApiService>(context, listen: false);
    var user = Provider.of<User>(context, listen: false);
    return FutureBuilder<List<User>>(
        future: api.search(user.id, query),
        builder: (context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.blueGrey,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ProfileWidget(
                                snapshot.data[index].id
                            )));
                      },
                      leading: CircleAvatar(
                        backgroundImage: snapshot.data[index].avatar.isEmpty ? AssetImage('images/no_image.png') : NetworkImage("$BASE_URL/${snapshot.data[index].avatar}"),
                      ),
                      title: Text(snapshot.data[index].username),
                      subtitle: Text("${snapshot.data[index].bio}", overflow: TextOverflow.ellipsis,),
                    );
                  }
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }
}
