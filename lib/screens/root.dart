import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/providers/secret_provider.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/screens/home.dart';
import 'package:swell_mobile_ui/screens/create_login.dart';


class Root extends StatelessWidget {
  final Secret secret;
  Root(this.secret);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          FutureProvider(create: (_) async => SecretProvider().loadSecret()),
        ],
        child: Scaffold(
          body: Center(
              child: Text('Profil page')
          ),
        ));
  }
}
