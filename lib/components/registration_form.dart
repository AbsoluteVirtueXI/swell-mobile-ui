
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/services/api_service.dart';
import 'package:swell_mobile_ui/screens/root.dart';

class RegistrationForm extends StatefulWidget {
  final Secret secret;
  RegistrationForm(this.secret);
  @override
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  bool registered = false;
  final _loginController = TextEditingController();
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
            controller: _loginController,
            decoration: InputDecoration(
                hintText: 'Login',
                labelText: 'Enter your login',
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
                  _register(context, _loginController.text);
                  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(widget.secret)));
                }
              },
              child: Text('Register'),
            ),
          ),

        ],
      )
    );
  }

  _register(BuildContext context, String login) async {
    var api = Provider.of<ApiService>(context, listen: false);
    var res = await api.register(widget.secret.ethAddress, login);
    if(res == true) {
      var id = await api.getId(widget.secret.ethAddress);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Root(id)));
    }
  }

}
