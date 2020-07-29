import 'package:flutter/material.dart';
import 'package:swell_mobile_ui/models/cart.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/screens/play_video.dart';
import 'package:swell_mobile_ui/screens/preview_screen.dart';
import 'package:swell_mobile_ui/screens/profile.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/models/user.dart';
import 'package:swell_mobile_ui/services/api_service.dart';
import 'package:swell_mobile_ui/models/video.dart';
import 'package:swell_mobile_ui/models/item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:swell_mobile_ui/models/feed.dart';
import 'package:swell_mobile_ui/components/image_tile.dart';
import 'package:swell_mobile_ui/screens/messages_screen.dart';
import 'package:swell_mobile_ui/components/profile.dart';

// TODO should check if register

const BASE_URL = 'https://api.squarrin.com';

class FeedListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var api = Provider.of<ApiService>(context, listen: false);
    //var cart = Provider.of<CartModel>(context, listen: true);
    var user = Provider.of<User>(context, listen: false);
    var feeds = Provider.of<List<Feed>>(context, listen: true);
    return Consumer<CartModel>(builder: (context, cart, child) {
      return Scaffold(
        body: Center(
            child: Consumer<List<Feed>>(builder: (context, lstFeed, child) {
          if (lstFeed == null) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: lstFeed.length,
              itemBuilder: (context, index) {
                for (final elem in cart.feeds) {
                  if (lstFeed[index].id == elem.id) {
                    return Container();
                  }
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PreviewScreen(lstFeed[index])));
                  },
                  child:
                      /*ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(lstItem[index].path),
                                ),
                                title: Text('${lstItem[index].title} \t\t\t\t ${lstItem[index].price} Quadreum'),
                                subtitle: Text('${lstItem[index].bio}'),
                                trailing: Icon(Icons.add_shopping_cart),
                                dense: true,
                              )*/
                      Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProfileWidget(lstFeed[index].seller_id)
                              ));
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80.0),
                                  image: DecorationImage(
                                      image: lstFeed[index].avatar.isEmpty
                                          ? AssetImage('images/no_image.png')
                                          : NetworkImage(lstFeed[index].avatar),
                                      fit: BoxFit.cover),
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('${lstFeed[index].username}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () => {},
                            )
                          ],
                        ),
                      ),
                      lstFeed[index].media_type == "IMAGE"
                          ? Image.network("${BASE_URL}/${lstFeed[index].path}",
                              fit: BoxFit.fitWidth,
                              width: MediaQuery.of(context).size.width)
                          : Image.network(
                              "${BASE_URL}/${lstFeed[index].thumbnail_path}",
                              fit: BoxFit.fitWidth,
                              width: MediaQuery.of(context).size.width),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 28.0,
                            icon: Icon(Icons.favorite_border),
                            onPressed: () => {},
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 28.0,
                            icon: Icon(Icons.chat_bubble_outline),
                            onPressed: () => {
                              if (user.id != feeds[index].seller_id)
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MessagesScreen(
                                                user.id,
                                                feeds[index].avatar,
                                                feeds[index].username,
                                                feeds[index].seller_id,
                                              )))
                                }
                            },
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 28.0,
                            icon: Icon(Icons.share),
                            onPressed: () => {},
                          ),
                          Spacer(),
                        ],
                      ),
                      Text(
                        '${lstFeed[index].description}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                          '${lstFeed[index].created_at.toString().substring(0, 19)}'),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                      ),
                    ],
                  ),
                );
              },
            );
            /*DefaultTabController(
                  length: 2,

                  child: Scaffold(
                    appBar: AppBar(
                      bottom: TabBar(
                        tabs: [
                          Tab(icon: Icon(Icons.videocam)),
                          Tab(icon: Icon(Icons.shopping_cart)),
                        ],
                      ),
                    ),
                    body: TabBarView(
                      children: [GridView.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        children: lstVideo.map((elem) {
                          return GridTile(
                            child: InkResponse(
                              child: Center(child: Column(
                                children: <Widget>[
                                  Text(elem.title, style: Theme.of(context).textTheme.headline5),
                                  Text("${elem.price} CZAR", style: Theme.of(context).textTheme.headline6)
                                ],
                              ), ),
                              onTap: () => Navigator.of(context)
                                  .push(MaterialPageRoute(
                                  builder: (context) => VideoPlayerScreen(elem.path))),),
                          );
                        }).toList(growable: true)
                        ,),
                        ListView.builder(
                          itemCount: lstItem.length,
                          itemBuilder: (context, index){
                            for (final elem in cart.items) {
                              if (lstItem[index].id == elem.id) {
                                return Container();
                              }
                            }
                            return GestureDetector(
                              onTap: () {
                                cart.addItem(lstItem[index]);
                              },
                              child: /*ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(lstItem[index].path),
                                ),
                                title: Text('${lstItem[index].title} \t\t\t\t ${lstItem[index].price} Quadreum'),
                                subtitle: Text('${lstItem[index].bio}'),
                                trailing: Icon(Icons.add_shopping_cart),
                                dense: true,
                              )*/
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('${lstItem[index].owner_id}', style: TextStyle(fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      Spacer(),
                                      IconButton(
                                        icon: Icon(Icons.more_vert),
                                        onPressed: () => {},
                                      )
                                    ],
                                  ),
                                  Image.network(lstItem[index].path, fit: BoxFit.fitWidth, width: MediaQuery.of(context).size.width),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        iconSize: 28.0,
                                        icon: Icon(Icons.favorite_border),
                                        onPressed: () => {},
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        iconSize: 28.0,
                                        icon: Icon(Icons.chat_bubble_outline),
                                        onPressed: () => {},
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        iconSize: 28.0,
                                        icon: Icon(Icons.share),
                                        onPressed: () => {},
                                      ),
                                      Spacer(),
                                    ],

                                  ),
                                  Text('${lstItem[index].title}', style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text('${lstItem[index].bio}', style: TextStyle(fontWeight: FontWeight.bold),),
                                ],
                              ),
                            );
                          },
                          ),
                      ],
                    ),
                  ),
                );*/
          }
        })),
      );
    });
  }
}
