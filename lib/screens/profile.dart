import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/providers/secret_provider.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/screens/home.dart';
import 'package:swell_mobile_ui/screens/registration.dart';
import 'package:swell_mobile_ui/models/user.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.widget.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('rebuild profile screen');
    return Scaffold(
      body: Center(
        child: Consumer<User>(
          builder: (context, profile, child) {
            if (profile != null) {
              print('profile not null null');
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.brown.shade800,
                    child: Text(profile.login),
                  ),
                  Text(profile.login),
                  Text(profile.bio),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text('${profile.czar}'),
                          Text('CZAR'),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text('${profile.liked.length - 1}'),
                          Text('Liked'),
                        ],
                      ),
                    ],
                  ),
                  RaisedButton(
                    onPressed: () =>
                        //pushNewScreen(context, screen: HomeScreen(), platformSpecific: false, withNavBar: true)/*
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(),
                    ))
                  ),
                ],
              );
            } else {
              print('profile is null');
            return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}