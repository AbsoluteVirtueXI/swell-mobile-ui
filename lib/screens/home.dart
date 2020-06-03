import 'package:flutter/material.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/screens/play_video.dart';
import 'package:swell_mobile_ui/screens/profil.dart';
// TODO should check if register

class Home extends StatelessWidget {
  final Secret secret;
  Home(this.secret);
  @override
  Widget build(BuildContext context) {
      child: return Scaffold(
        appBar: AppBar(title: Text('Home page for ${secret.ethAddress}'), centerTitle: true,),
        body: Center(
            child: Text('Home page')
        ),
      );
  }
}