import 'package:flutter/material.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/components/registration_form.dart';
class RegistrationScreen extends StatelessWidget {
  final Secret secret;
  RegistrationScreen(this.secret);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
            appBar: AppBar(
              title: Text('Registration for ${secret.ethAddress}'), centerTitle: true,),
            body: Center(child: RegistrationForm(secret)),//Container(height: 600, child: LoginForm(this.secret))
        );
  }
}