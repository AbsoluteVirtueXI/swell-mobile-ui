import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/screens/root.dart';
import 'package:swell_mobile_ui/screens/registration.dart';
import 'package:swell_mobile_ui/services/api_service.dart';
import 'package:swell_mobile_ui/services/secret_service.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureProvider<Secret>(
        create: (_) async => Provider.of<SecretService>(context, listen: false).loadSecret(),
        child: Scaffold(
            body: Center(
              child: Consumer<Secret>(
                  builder: (context, secret, child) {
                    if (secret == null) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('images/squarrin_logo.jpg',
                              width: 600, height: 240, fit: BoxFit.cover),
                          Text('squarrin', style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                        ],
                      );
                    } else {
                      return FutureProvider<bool>(
                          create: (context) async => await Provider.of<ApiService>(context, listen: false).get_isRegistered(secret.ethAddress),
                          child: Consumer<bool>(
                           builder: (context, isRegistered, child) {
                             if (isRegistered == true) {
                               return Root(secret);
                             } else if (isRegistered == false) {
                               return RegistrationScreen(secret);
                             } else {
                               return CircularProgressIndicator();
                             }
                           }
                          ),
                      );
                    }
                  }
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
