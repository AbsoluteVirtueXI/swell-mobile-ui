import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/services/api_service.dart';

const BASE_URL = 'https://api.squarrin.com';



class MessagesScreen extends StatelessWidget {
  final int myId;
  final int otherId;
  final String otherAvatar;
  final String otherUsername;
  const MessagesScreen(this.myId, this.otherAvatar, this.otherUsername, this.otherId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: CircleAvatar(
        backgroundImage: otherAvatar.isEmpty ? AssetImage('images/no_image.png') : NetworkImage("$BASE_URL/${otherAvatar}"),
      ), title: Text('${otherUsername}'),),
      body: Center(child: Text("OTHER")),
    );
  }
}
