import 'package:flutter/material.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/screens/play_video.dart';
import 'package:swell_mobile_ui/screens/profile.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/models/user.dart';
import 'package:swell_mobile_ui/services/api_service.dart';
import 'package:swell_mobile_ui/models/video.dart';
// TODO should check if register

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var api = Provider.of<ApiService>(context, listen: false);
    return StreamProvider<List<Video>>(
      create: (_) => api.allVideoStream(),
      catchError: (context, error)  {
        print("IN VIDEO STREAM CATCH ERROR");
        print(error.toString());
      },
    lazy: false,
      child: Scaffold(
        body: Center(
          child: Consumer<List<Video>>(
            builder:(context, lst, child) {
              if(lst == null) {
                return CircularProgressIndicator();
              } else {
                return GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  children: lst.map((elem) {
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
                  ,);
              }
            }
          )
        ),
      ),

    );
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
    );
  }
}