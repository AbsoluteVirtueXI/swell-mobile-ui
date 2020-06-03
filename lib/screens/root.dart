import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/providers/secret_provider.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/providers/user_provider.dart';
import 'package:swell_mobile_ui/screens/home.dart';
import 'package:swell_mobile_ui/screens/registration.dart';
import 'package:swell_mobile_ui/models/user.dart';


class Root extends StatelessWidget {
  final Secret secret;

  Root(this.secret);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Home(this.secret)
    );
  }
}