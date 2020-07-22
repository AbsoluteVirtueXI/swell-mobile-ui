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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var api = Provider.of<ApiService>(context, listen: false);
    var cart = Provider.of<CartModel>(context);
    var user = Provider.of<User>(context, listen: false);
    return
        StreamProvider<List<Feed>>(
      /*MultiProvider(
      providers: [
        StreamProvider<List<Video>>(
            create: (_) => api.allVideoStream(),
            catchError: (context, error)  {
              print("IN VIDEO STREAM CATCH ERROR");
              print(error.toString());
              },
            lazy: false),
        StreamProvider<List<Item>>(
          create: (_) => api.allItemStream(),
          catchError: (context, error)  {
            print("IN VIDEO STREAM CATCH ERROR");
            print(error.toString());
          },
          lazy: false),
      ]*/
          create: (_) => api.allFeedsStream(user.id),
          catchError: (context, error) {
            print("IN FEED CATCH ERROR");
            print(error.toString());
            return null;
            },
          lazy: false,
          child: Scaffold(
            body: Center(
                child: Consumer<List<Feed>>(
                    builder: (context, lstFeed, child) {
                      if(lstFeed == null) {
                        return CircularProgressIndicator();
                      } else {
                        return GridView.count(
                            crossAxisCount: 3,
                            childAspectRatio: 1.0,
                            mainAxisSpacing: 1.5,
                            crossAxisSpacing: 1.5,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: lstFeed.map((elem) {
                              for (final elem in cart.feeds) {
                                if (elem.id == elem.id) {
                                  return Container();
                                }
                              }
                              //return Image.network(url, fit: BoxFit.fitWidth, width: MediaQuery.of(context).size.width);
                              //return Image.network('${BASE_URL}/$url');
                              return ImageTile(elem);
                            }).toList(),

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
            }
          )
        ),
      ),

    );
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