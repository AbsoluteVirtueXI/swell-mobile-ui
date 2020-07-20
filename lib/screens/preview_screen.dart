import 'package:flutter/material.dart';
import 'package:swell_mobile_ui/models/feed.dart';
import 'package:swell_mobile_ui/models/feedme.dart';
import 'package:swell_mobile_ui/screens/play_video.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/models/cart.dart';
import 'package:swell_mobile_ui/models/feed.dart';



const BASE_URL = 'https://api.squarrin.com';


class PreviewScreen extends StatelessWidget {
  final Feed feed;
  PreviewScreen(this.feed);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Preview"), centerTitle: true,),
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Center(child: feed.media_type == "VIDEO" ? VideoPlayerScreen('$BASE_URL/${feed.path}') : FittedBox(alignment: Alignment.center, child: Image.network('$BASE_URL/${feed.path}', fit: BoxFit.fill), fit: BoxFit.fill)),
            Positioned.fill(
                child: Align(alignment: Alignment.bottomCenter,
                  child: IconButton(icon: Icon(Icons.shopping_cart),iconSize: 50.0, onPressed: ()  {
                    cart.addItem(feed);
                  Navigator.pop(context);
                  }),)),
            Positioned.fill(
              child: Align(alignment: Alignment.topCenter,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text("${feed.description}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    Text("${feed.price} quadreum", style: TextStyle(fontSize: 20),),
                  ],
                ),
              )
            ),

          ],
        )
    );
  }
}

class PreviewScreenMe extends StatelessWidget {
  final Feedme feed;
  PreviewScreenMe(this.feed);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    return Scaffold(
        appBar: AppBar(title: Text("Preview"), centerTitle: true,),
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Center(child: feed.media_type == "VIDEO" ? VideoPlayerScreen('$BASE_URL/${feed.path}') : FittedBox(alignment: Alignment.center, child: Image.network('$BASE_URL/${feed.path}', fit: BoxFit.fill), fit: BoxFit.fill)),
            /*Positioned.fill(
                child: Align(alignment: Alignment.bottomCenter,
                  child: IconButton(icon: Icon(Icons.shopping_cart),iconSize: 50.0, onPressed: ()  {
                    cart.addItem(feed);
                    Navigator.pop(context);
                  }),)),*/
            Positioned.fill(
                child: Align(alignment: Alignment.topCenter,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Text("${feed.description}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Text("${feed.price} quadreum", style: TextStyle(fontSize: 20),),
                    ],
                  ),
                )
            ),

          ],
        )
    );
  }
}
