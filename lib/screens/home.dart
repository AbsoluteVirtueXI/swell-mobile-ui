import 'package:flutter/material.dart';
import 'package:swell_mobile_ui/models/secret.dart';
// TODO should check if register
class Home extends StatelessWidget {
  final Secret secret;
  Home(this.secret);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('home'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Home page'),
                Text(secret.ethAddress),
                Text(secret.ethPrivate),
                Text('${secret.isFirstUse}')]),
        )
      )
    );
  }
}