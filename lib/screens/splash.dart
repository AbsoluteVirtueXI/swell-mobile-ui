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
    return FutureProvider<IsRegister>(
        create: (_) async => Provider.of<SecretService>(context, listen: false).hasSecret(),
        catchError: (context, error)  {
          print("In IsRegister catchError");
          print(error.toString());
        },
        child: Scaffold(
            body: Center(
              child: Consumer<IsRegister>(
                  builder: (context, is_register, child) {
                    if (is_register == null) {
                      return
                        Text('squarrin', style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold));
                    } else if (is_register.register == true){
                      return Root(is_register.secret.id);
                    } else {
                      return RegistrationScreen();
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
