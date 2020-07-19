import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/providers/secret_provider.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/screens/home.dart';
import 'package:swell_mobile_ui/screens/registration.dart';
import 'package:swell_mobile_ui/models/user.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.widget.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('rebuild profile screen');
    return Scaffold(
      body: Consumer<User>(
        builder: (context, profile, child) {
          if (profile != null) {
            print('profile not null null');
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
                                    : NetworkImage(profile.avatar),
                                fit: BoxFit.cover),
                          )),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  detailsWidget(
                                      profile.quadreum.toString(), 'Quadreum'),
                                  detailsWidget("0".toString(), 'followers'),
                                  detailsWidget("0".toString(), 'following')
                                ]),
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 12.0, left: 20.0, right: 20.0),
                                child: Container(
                                  width: 210.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(4.0),
                                      border: Border.all(color: Colors.grey)),
                                  child: Center(
                                    child: Text('Edit Profile',
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                ),
                              ),
                              onTap: () {},
                            )
                          ],
                        ))
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
                  child: profile.bio.isNotEmpty ? Text(profile.bio) : Container(),
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
                        onTap: () {
                        },
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.stay_current_portrait,
                          color: Colors.white,
                        ),
                        onTap: () {
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Divider(),
                ),
              ],
            );
          } else {
            print('profile is null');
            return CircularProgressIndicator();
          }
        },
      ),
    );
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

class ProfileScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('rebuild profile screen');
    return Scaffold(
      body: Center(
        child: Consumer<User>(
          builder: (context, profile, child) {
            if (profile != null) {
              print('profile not null null');
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.brown.shade800,
                        child: Text(profile.username),
                      ),
                      Text(profile.username),
                      Text(profile.bio),
                      Column(
                        children: <Widget>[
                          Text('${profile.quadreum}'),
                          Text('CZAR'),
                        ],
                      ),
                    ],
                  ),
                  RaisedButton(
                      onPressed: () =>
                          //pushNewScreen(context, screen: HomeScreen(), platformSpecific: false, withNavBar: true)/*
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ))),
                ],
              );
            } else {
              print('profile is null');
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
/*
class InstaProfileScreen extends StatefulWidget {
  // InstaProfileScreen();

  @override
  _InstaProfileScreenState createState() => _InstaProfileScreenState();
}

class _InstaProfileScreenState extends State<InstaProfileScreen> {
  var _repository = Repository();
  Color _gridColor = Colors.blue;
  Color _listColor = Colors.grey;
  bool _isGridActive = true;
  User _user;
  IconData icon;
  Color color;
  Future<List<DocumentSnapshot>> _future;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    retrieveUserDetails();
    icon = FontAwesomeIcons.heart;
  }

  retrieveUserDetails() async {
    FirebaseUser currentUser = await _repository.getCurrentUser();
    User user = await _repository.retrieveUserDetails(currentUser);
    setState(() {
      _user = user;
    });
    _future = _repository.retrieveUserPosts(_user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: new Color(0xfff8faf8),
          elevation: 1,
          title: Text('Profile'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings_power),
              color: Colors.black,
              onPressed: () {
                _repository.signOut().then((v) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                        return MyApp();
                      }));
                });
              },
            )
          ],
        ),
        body: _user != null
            ? ListView(
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
                            image: _user.photoUrl.isEmpty
                                ? AssetImage('assets/no_image.png')
                                : NetworkImage(_user.photoUrl),
                            fit: BoxFit.cover),
                      )),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          StreamBuilder(
                            stream: _repository
                                .fetchStats(
                                uid: _user.uid, label: 'posts')
                                .asStream(),
                            builder: ((context,
                                AsyncSnapshot<List<DocumentSnapshot>>
                                snapshot) {
                              if (snapshot.hasData) {
                                return detailsWidget(
                                    snapshot.data.length.toString(),
                                    'posts');
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                          ),
                          StreamBuilder(
                            stream: _repository
                                .fetchStats(
                                uid: _user.uid, label: 'followers')
                                .asStream(),
                            builder: ((context,
                                AsyncSnapshot<List<DocumentSnapshot>>
                                snapshot) {
                              if (snapshot.hasData) {
                                return Padding(
                                  padding:
                                  const EdgeInsets.only(left: 24.0),
                                  child: detailsWidget(
                                      snapshot.data.length.toString(),
                                      'followers'),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                          ),
                          StreamBuilder(
                            stream: _repository
                                .fetchStats(
                                uid: _user.uid, label: 'following')
                                .asStream(),
                            builder: ((context,
                                AsyncSnapshot<List<DocumentSnapshot>>
                                snapshot) {
                              if (snapshot.hasData) {
                                return Padding(
                                  padding:
                                  const EdgeInsets.only(left: 20.0),
                                  child: detailsWidget(
                                      snapshot.data.length.toString(),
                                      'following'),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                          ),
                        ],
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, left: 20.0, right: 20.0),
                          child: Container(
                            width: 210.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(color: Colors.grey)),
                            child: Center(
                              child: Text('Edit Profile',
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: ((context) => EditProfileScreen(
                                  photoUrl: _user.photoUrl,
                                  email: _user.email,
                                  bio: _user.bio,
                                  name: _user.displayName,
                                  phone: _user.phone
                              ))
                          ));
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 30.0),
              child: Text(_user.displayName,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 10.0),
              child: _user.bio.isNotEmpty ? Text(_user.bio) : Container(),
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
                      color: _gridColor,
                    ),
                    onTap: () {
                      setState(() {
                        _isGridActive = true;
                        _gridColor = Colors.blue;
                        _listColor = Colors.grey;
                      });
                    },
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.stay_current_portrait,
                      color: _listColor,
                    ),
                    onTap: () {
                      setState(() {
                        _isGridActive = false;
                        _listColor = Colors.blue;
                        _gridColor = Colors.grey;
                      });
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: postImagesWidget(),
            ),
          ],
        )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
*/
