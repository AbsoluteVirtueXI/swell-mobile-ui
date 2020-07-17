import 'package:flutter/material.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/components/registration_form.dart';
class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
            body: Center(
                child: RegistrationForm()),//Container(height: 600, child: LoginForm(this.secret))
        );
  }
}