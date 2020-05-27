import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swell_mobile_ui/screens/home.dart';
import 'package:swell_mobile_ui/models/secret.dart';

class LoginForm extends StatefulWidget {
  final Secret secret;
  LoginForm(this.secret);
  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Login',
                labelText: 'Enter you login',
              isDense: true,
            ),
            validator: (value) {
              if(value.isEmpty) {
                return 'Please enter your login';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: RaisedButton(
              onPressed: () {
                if(_formKey.currentState.validate()) {
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing data')));

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(widget.secret)));
                }
              },
              child: Text('Register'),
            ),
          ),

        ],
      )
    );
  }
}