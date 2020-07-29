import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/models/user.dart';
import 'package:swell_mobile_ui/services/api_service.dart';

import 'package:swell_mobile_ui/components/profile.dart';
import 'package:swell_mobile_ui/models/follower.dart';

const BASE_URL = 'https://api.squarrin.com';


class FollowersScreen extends StatelessWidget {
  final int profile_id;
  const FollowersScreen(this.profile_id);
  @override
  Widget build(BuildContext context) {
    var api = Provider.of<ApiService>(context, listen: false);
    var user = Provider.of<User>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('Followers')),
      body: StreamProvider<List<Follower>>(
        create: (_) => api.followersStream(user.id, profile_id),
        catchError: (context, error) {
          print("IN FOLLOWER STREAM CATCH ERROR");
          print(error.toString());
        },
        lazy: false,
        child: Consumer<List<Follower>>(
          builder: (context, followers, child) {
            if(followers == null) {
              return Center(child: CircularProgressIndicator());
            } else if (followers.isEmpty) {
              return Center(child: Text("No followers"));
            } else {
              return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.blueGrey,
                  ),
                  itemCount: followers.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ProfileWidget(
                              followers[index].id
                            )));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: followers[index].avatar.isEmpty ? AssetImage('images/no_image.png') : NetworkImage("$BASE_URL/${followers[index].avatar}"),
                        ),
                        title: Text("${followers[index].username}"),
                        subtitle: Text("${followers[index].bio}", overflow: TextOverflow.ellipsis,),
                        trailing: RaisedButton(
                          onPressed: () {
                            api.unfollow(user.id, followers[index].id);
                          },
                          child: Text('unfollow'),
                        ),
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
