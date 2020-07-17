import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/services/api_service.dart';
import 'package:swell_mobile_ui/screens/root.dart';
import 'package:swell_mobile_ui/eth_utils/keys.dart';
import 'package:swell_mobile_ui/services/secret_service.dart';

class RegistrationForm extends StatefulWidget {
  @override
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  bool registered = false;
  final _loginController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100.0),
                  child: Text('Welcome to Squarrin',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),
                TextFormField(
                  controller: _loginController,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    hintText: 'Login',
                    labelText: 'Enter your login',
                    isDense: true,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your login';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Processing data')));
                        _register(context, _loginController.text);
                        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(widget.secret)));
                      }
                    },
                    child: Text('Register'),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  _register(BuildContext context, String login) async {
    var keys = await generateNewCredentials();
    var api = Provider.of<ApiService>(context, listen: false);
    var user = await api.register(login, keys.ethAddress);
    var id = user.id;
    var secret = Secret(id, keys.ethPrivateKey, keys.ethAddress);
    await Provider.of<SecretService>(context, listen: false)
        .writeSecret(secret);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Root(id)));
  }
}
