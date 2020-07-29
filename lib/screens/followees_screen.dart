import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/models/user.dart';
import 'package:swell_mobile_ui/services/api_service.dart';

import 'package:swell_mobile_ui/components/profile.dart';
import 'package:swell_mobile_ui/models/followee.dart';

const BASE_URL = 'https://api.squarrin.com';


class FolloweesScreen extends StatelessWidget {
  final int profile_id;
  const FolloweesScreen(this.profile_id);
  @override
  Widget build(BuildContext context) {
    var api = Provider.of<ApiService>(context, listen: false);
    var user = Provider.of<User>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('Followees')),
      body: StreamProvider<List<Followee>>(
        create: (_) => api.followeesStream(user.id, profile_id),
        catchError: (context, error) {
          print("IN FOLLOWEE STREAM CATCH ERROR");
          print(error.toString());
        },
        lazy: false,
        child: Consumer<List<Followee>>(
          builder: (context, followees, child) {
            if(followees == null) {
              return Center(child: CircularProgressIndicator());
            } else if (followees.isEmpty) {
              return Center(child: Text("No followees"));
            } else {
              return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.blueGrey,
                  ),
                  itemCount: followees.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ProfileWidget(
                                followees[index].id
                            )));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: followees[index].avatar.isEmpty ? AssetImage('images/no_image.png') : NetworkImage("$BASE_URL/${followees[index].avatar}"),
                        ),
                        title: Text("${followees[index].username}"),
                        subtitle: Text("${followees[index].bio}", overflow: TextOverflow.ellipsis,),
                      ),
                    );
                    //Text("${threads[index].content}");
                  });
            }
          },
        ),
      ),
    );
  }
}