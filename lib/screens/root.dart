import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/providers/secret_provider.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/providers/user_provider.dart';
import 'package:swell_mobile_ui/screens/home.dart';
import 'package:swell_mobile_ui/screens/registration.dart';
import 'package:swell_mobile_ui/models/user.dart';
import 'package:swell_mobile_ui/screens/profile.dart';
import 'package:swell_mobile_ui/services/api_service.dart';

class Root extends StatelessWidget {
  final Secret secret;

  Root(this.secret);

  @override
  Widget build(BuildContext context) {
    var api = Provider.of<ApiService>(context, listen: false);
    return FutureProvider<int>(
        create: (_) => api.getId(secret.ethAddress),
        child: Consumer<int>(
          builder: (context, id, child) {
            return (id != null)
                ? StreamProvider<User>(
                    create: (_)  => api.profileStream(id),
                    catchError: (context, error) {
                      print(error.toString());
                      return User.empty();
                    },
                    child: ProfileScreen())
                : CircularProgressIndicator();
          },
        ));
  }
}

/*
Consumer<int>(
          builder: (context, id, child) {
            return (id != null)
                ? StreamProvider<User>(
                    create: (_) => api.profileStream(id),
                    catchError: (context, error) {
                      print(error.toString());
                      return User.empty();
                    },
                    child: Profile())
                : CircularProgressIndicator();
          },
        ));
 */
