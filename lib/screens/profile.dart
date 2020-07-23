import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/providers/secret_provider.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/models/feedme.dart';
import 'package:swell_mobile_ui/screens/home.dart';
import 'package:swell_mobile_ui/screens/shopping.dart';
import 'package:swell_mobile_ui/screens/registration.dart';
import 'package:swell_mobile_ui/models/user.dart';
//import 'package:persistent_bottom_nav_bar/persistent-tab-view.widget.dart';
import 'package:swell_mobile_ui/components/image_tile.dart';
import 'package:swell_mobile_ui/services/api_service.dart';


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var api = Provider.of<ApiService>(context, listen: false);

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
                                  Padding(padding: EdgeInsets.symmetric(horizontal: 5.0),),
                                  detailsWidget("0".toString(), 'followers'),
                                  Padding(padding: EdgeInsets.symmetric(horizontal: 5.0),),
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
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              iconSize: 30.0,
                              icon: Icon(Icons.shopping_cart),
                              onPressed: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ShoppingScreen()))

                              },
                            ),
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
                StreamProvider<List<Feedme>>(
                  create: (_) => api.allMyFeedStream(profile.id),
                  lazy: false,
                  catchError: (context, error)  {
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
                          //physics: const NeverScrollableScrollPhysics(),
                          children: lstFeedme.map((elemme) {
                            return ImageTileMe(elemme);
                          }).toList(),

                        );
                      }
                    }
                ),)
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
