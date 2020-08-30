import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:swell_mobile_ui/models/user.dart';
import 'package:swell_mobile_ui/models/follower.dart';
import 'package:swell_mobile_ui/models/followee.dart';

import 'package:swell_mobile_ui/models/profile.dart';
import 'package:swell_mobile_ui/services/api_service.dart';
import 'package:swell_mobile_ui/screens/shopping.dart';
import 'package:swell_mobile_ui/screens/messages_screen.dart';
import 'package:swell_mobile_ui/screens/followers_screen.dart';
import 'package:swell_mobile_ui/screens/followees_screen.dart';


import 'package:swell_mobile_ui/models/feedme.dart';
import 'package:swell_mobile_ui/components/image_tile.dart';
import 'package:swell_mobile_ui/screens/edit_profile_screen.dart';

const BASE_URL = 'https://api.squarrin.com';


class ProfileWidget extends StatelessWidget {
  final int user_id;

  const ProfileWidget(this.user_id);

  @override
  Widget build(BuildContext context) {
    var api = Provider.of<ApiService>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text("MY SQUARRIN", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Krona', color: Colors.white),),),
        body: Consumer<User>(builder: (context, user, child) {
      if (user != null) {
        return StreamProvider<Profile>(
            create: (_) => api.getProfileById(user_id),
            catchError: (context, error) {
              print("IN Profile CATCH ERROR");
              print(error.toString());
              return null;
            },
            lazy: false,
            child: Consumer<Profile>(builder: (context, profile, child) {
              if (profile != null) {
                return ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Container(
                              width: 110.0,
                              height: 110.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80.0),
                                image: DecorationImage(
                                    image: profile.avatar.isEmpty
                                        ? AssetImage('images/no_image.png')
                                        : NetworkImage("${BASE_URL}/${profile.avatar}"),
                                    fit: BoxFit.cover),
                              )),
                        ),
                        Padder(profile, user, context),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(profile.username,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0)),
                          Text(profile.eth_address,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10.0))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 10.0),
                      child: profile.bio.isNotEmpty
                          ? Text(profile.bio)
                          : Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            child: Icon(
                              Icons.grid_on,
                              color: Colors.white,
                            ),
                            onTap: () {},
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.stay_current_portrait,
                              color: Colors.white,
                            ),
                            onTap: () {},
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Divider(),
                    ),
                    StreamProvider<List<Feedme>>(
                      create: (_) => api.allMyFeedStream(profile.id),
                      lazy: false,
                      catchError: (context, error) {
                        print("In IsRegister catchError");
                        print(error.toString());
                      },
                      child: Consumer<List<Feedme>>(
                          builder: (context, lstFeedme, child) {
                        if (lstFeedme == null) {
                          return CircularProgressIndicator();
                        } else {
                          return GridView.count(
                            crossAxisCount: 3,
                            childAspectRatio: 1.0,
                            mainAxisSpacing: 1.5,
                            crossAxisSpacing: 1.5,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            //physics: const NeverScrollableScrollPhysics(),
                            children: lstFeedme.map((elemme) {
                              return ImageTileMe(elemme);
                            }).toList(),
                          );
                        }
                      }),
                    )
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
                // DO THE THING HERE
              }
            }));
      } else {
        return Center(child: CircularProgressIndicator());
      }
    }));
  }
}

Widget detailsWidget(String count, String label) {
  return Column(
    children: <Widget>[
      Text(count,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.white)),
      Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child:
            Text(label, style: TextStyle(fontSize: 10.0, color: Colors.white)),
      )
    ],
  );
}

Widget Padder(Profile profile, User user, context) {
  var api = Provider.of<ApiService>(context, listen: false);
  return MultiProvider(
    providers: [
      StreamProvider<List<Follower>>(
        create: (_) => api.followersStream(user.id, profile.id),
        catchError: (context, error) {
          print("IN FOLLOWER STREAM CATCH ERROR");
          print(error.toString());
        },
        lazy: false,
      ),
      StreamProvider<List<Followee>>(
        create: (_) => api.followeesStream(user.id, profile.id),
        catchError: (context, error) {
          print("IN FOLLOWEE STREAM CATCH ERROR");
          print(error.toString());
        },
        lazy: false,
      ),
    ],
    child: Consumer2<List<Follower>, List<Followee>>(
        builder: (context, followers, followees, child) {
          if(followers != null && followees != null) {
            var isFollowed = false;
            for (final elem in followers) {
              if(elem.id == user.id) {
                isFollowed = true;
              }
            }
            return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          detailsWidget(profile.quadreum.toString(), 'Quadreum'),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => FollowersScreen(
                                      profile.id
                                    )));
                              },
                              child: detailsWidget(followers.length.toString(), 'followers')),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => FolloweesScreen(
                                      profile.id
                                    )));
                              },
                              child: detailsWidget(followees.length.toString(), 'following'))
                        ]),
                    user.id == profile.id ?
                    GestureDetector(
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 12.0, left: 20.0, right: 20.0),
                        child: Container(
                          width: 210.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                              color: Colors.cyanAccent,
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(color: Colors.grey)),
                          child: Center(
                            child: Text('Edit Profile',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => EditProfileScreen(user)));
                      },
                    ) : GestureDetector(
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 12.0, left: 20.0, right: 20.0),
                        child: Container(
                          width: 210.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(color: Colors.grey)),
                          child: Center(
                            child: Text(isFollowed ? 'Unfollow' : 'Follow',
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                      ),
                      onTap: () {
                        if(isFollowed) {
                          api.unfollow(user.id, profile.id);
                        } else {
                          api.follow(user.id, profile.id);
                        }
                      },
                    ),
                    profile.id == user.id ?
                    IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 30.0,
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ShoppingScreen()))
                      },
                    ) : IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 28.0,
                      icon: Icon(Icons.chat_bubble_outline),
                      onPressed: () => {

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MessagesScreen(
                                      user.id,
                                      profile.avatar,
                                      profile.username,
                                      profile.id,
                                    )))

                      },
                    ),
                  ],
                ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
    }),
  );
}
