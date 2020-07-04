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

// TODO should check if register

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var api = Provider.of<ApiService>(context, listen: false);
    var cart = Provider.of<CartModel>(context);
    return
      MultiProvider(
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
      ],
      child: Scaffold(
        body: Center(
          child: Consumer2<List<Video>, List<Item>>(
            builder:(context, lstVideo, lstItem, child) {
              if(lstVideo == null && lstItem == null) {
                return CircularProgressIndicator();
              } else {
                return DefaultTabController(
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
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(lstItem[index].path),
                                ),
                                title: Text('${lstItem[index].title} \t\t\t\t ${lstItem[index].price} Quadreum'),
                                subtitle: Text('${lstItem[index].bio}'),
                                trailing: Icon(Icons.add_shopping_cart),
                                dense: true,
                              ),
                            );
                          },
                          ),
                      ],
                    ),
                  ),
                );
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