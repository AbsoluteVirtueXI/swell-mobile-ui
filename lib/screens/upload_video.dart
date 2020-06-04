import 'package:flutter/material.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/screens/play_video.dart';
import 'package:swell_mobile_ui/screens/profile.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/models/user.dart';
// TODO should check if register

class UploadScreen extends StatelessWidget {
  String filePath;
  UploadScreen(this.filePath);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<User>(
          builder: (context, profile, child) {
            if (profile != null) {
              return Text('in upload with ${profile.login} who want to upload ${filePath}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}