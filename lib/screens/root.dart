import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/models/cart.dart';
import 'package:swell_mobile_ui/providers/secret_provider.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/providers/user_provider.dart';
import 'package:swell_mobile_ui/screens/registration.dart';
import 'package:swell_mobile_ui/models/user.dart';
import 'package:swell_mobile_ui/screens/profile.dart';
import 'package:swell_mobile_ui/screens/record_video.dart';
import 'package:swell_mobile_ui/screens/feed_grid_screen.dart';
import 'package:swell_mobile_ui/screens/feed_list_screen.dart';
import 'package:swell_mobile_ui/screens/shopping.dart';
import 'package:swell_mobile_ui/screens/threads.dart';
import 'package:swell_mobile_ui/screens/sell.dart';
import 'package:swell_mobile_ui/screens/search.dart';
import 'package:swell_mobile_ui/screens/shopping.dart';
import 'package:swell_mobile_ui/services/api_service.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:swell_mobile_ui/models/feed.dart';
import 'package:swell_mobile_ui/components/profile.dart';


class Root extends StatelessWidget {
  final int id;

  Root(this.id);

  @override
  Widget build(BuildContext context) {
    var api = Provider.of<ApiService>(context, listen: false);
    return MultiProvider(
        providers: [
          StreamProvider<User>(
            create: (_) => api.profileStream(id),
            catchError: (context, error) {
              print("IN USER STREAM CATCH ERROR");
              print(error.toString());
            },
            lazy: false,
          ),
          ChangeNotifierProvider<CartModel>(
            create: (_) => CartModel(),
          ),
        ],
        child: Consumer<User>(builder: (context, user, child) {
          if (user == null) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return StreamProvider<List<Feed>>(
                create: (_) => api.allFeedsStream(user.id),
                catchError: (context, error) {
                  print("IN FEED CATCH ERROR");
                  print(error.toString());
                  return null;
                },
                lazy: false,
                child: MaterialApp(
                  title: 'Squarrin',
                  home: Squarrin(),
                  theme: ThemeData(
                    brightness: Brightness.dark,
                    fontFamily: 'Roboto',
                    primarySwatch: Colors.blueGrey,
                    primaryColor: Colors.black,
                    //backgroundColor: Colors.black,
                    scaffoldBackgroundColor: Colors.black,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    buttonTheme: ButtonThemeData(
                        buttonColor: Colors.cyanAccent
                    ),
                  ),
                ));
          }
        }));
  }
}

class Squarrin extends StatefulWidget {
  @override
  _SquarrinState createState() => _SquarrinState();
}

class _SquarrinState extends State<Squarrin> {
  PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 2);
  }

  List<Widget> _buildScreens(id) {
    return [
      FeedGridScreen(),
      FeedListScreen(),
      RecordScreen(),
      ThreadsScreen(),
      //ShoppingScreen(),
      ProfileWidget(id),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: ("Search"),
        activeColor: Colors.blue,
        inactiveColor: Colors.grey,
      ),
      /*PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: ("Search"),
        activeColor: Colors.teal,
        inactiveColor: Colors.grey,
        isTranslucent: false,
      ),*/
      PersistentBottomNavBarItem(
        icon: Icon(Icons.rss_feed),
        title: ("Feed"),
        activeColor: Colors.greenAccent,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.videocam),
        title: ("Record"),
        activeColor: Colors.deepOrange,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.message),
        title: ("Messages"),
        activeColor: Colors.indigo,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.account_box),
        title: ("Profile"),
        activeColor: Colors.indigo,
        inactiveColor: Colors.grey,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context, listen: true);
    var _pageController = PageController(
      initialPage: 2
    );
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: PageView(
          physics: BouncingScrollPhysics(),
          children: _buildScreens(user.id),
          controller: _pageController,
        ),
      /*PersistentTabView(
        //bottomScreenMargin: 0,
        resizeToAvoidBottomInset: true,
        hideNavigationBarWhenKeyboardShows: true,
        controller: _controller,
        screens: _buildScreens(user.id),
        items: _navBarsItems(),
        // Redundant here but defined to demonstrate for other than custom style
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        onItemSelected: (index) {
          setState(() {
            print(index);
          }); // This is required to update the nav bar if Android back button is pressed
        },
        navBarStyle: NavBarStyle.style7,
        // Choose the nav bar style with this property
        itemCount: 5,
        iconSize: 26.0,
      ),*/
    );
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
