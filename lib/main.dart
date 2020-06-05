import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/models/user.dart';
import 'package:swell_mobile_ui/screens/splash.dart';
import 'package:swell_mobile_ui/services/secret_service.dart';
import 'package:swell_mobile_ui/services/api_service.dart';
import 'package:swell_mobile_ui/screens/root.dart';
import 'package:swell_mobile_ui/screens/play_video.dart';

void main(){

  runApp(Squarrin());
}

class Squarrin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<SecretService>(
            create: (_) => SecretService(),
          ),
          Provider<ApiService>(
            create: (_) => ApiService(),
          ),
        ],
        child: MaterialApp(
          title: 'Squarrin',
          //home: SplashScreen(),
          home: Root(1),
          //home: VideoPlayerApp(),
        ));
  }
}
