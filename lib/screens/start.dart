//import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/providers/secret_provider.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/screens/home.dart';
import 'package:swell_mobile_ui/screens/create_login.dart';
import 'package:swell_mobile_ui/screens/profil.dart';
import 'package:swell_mobile_ui/screens/root.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          FutureProvider(create: (_) async => SecretProvider().loadSecret()),
        ],
        child: Scaffold(
            body: Center(
              child: Consumer<Secret>(builder: (context, secret, child) {
                if (secret == null) {
                  return Text('swell', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
                } else if( secret.isFirstUse == true) {
                  return CreateLogin(secret);
                } else {
                  return Root(secret);
                }}
                ),
        )));
  }
}

/*
class SplashState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 6);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => Home()
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    //Timer(
    //  Duration(seconds: 3),
    //    () => Navigator.of(context).pushReplacement(
    //      MaterialPageRoute(builder: (BuildContext context) => Home())
    //    ));
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: Text('swell', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30))
          ),
        )
      )
    );
  }
}
*/
