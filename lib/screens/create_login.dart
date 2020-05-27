import 'package:flutter/material.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/components/login_form.dart';
class CreateLogin extends StatelessWidget {
  final Secret secret;
  CreateLogin(this.secret);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Create Login'),
            ),
            body: Container(height: 600, child: LoginForm(this.secret))
        )
    );
  }
}