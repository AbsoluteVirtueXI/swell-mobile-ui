import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/providers/secret_provider.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/screens/home.dart';
import 'package:swell_mobile_ui/screens/registration.dart';
import 'package:swell_mobile_ui/models/user.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<User>(
          builder: (context, profile, child) {
            if (profile != null) {
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
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Home(),
                    ))
                  ),
                ],
              );
            } else {
            return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}