import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/providers/secret_provider.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/providers/user_provider.dart';
import 'package:swell_mobile_ui/screens/home.dart';
import 'package:swell_mobile_ui/screens/registration.dart';
import 'package:swell_mobile_ui/models/user.dart';
import 'package:swell_mobile_ui/screens/profile.dart';
import 'package:swell_mobile_ui/screens/record_video.dart';
import 'package:swell_mobile_ui/screens/search.dart';
import 'package:swell_mobile_ui/services/api_service.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Root extends StatelessWidget {
  final int id;

  Root(this.id);

  @override
  Widget build(BuildContext context) {
    var api = Provider.of<ApiService>(context, listen: false);
    return StreamProvider<User>(
      create: (_) => api.profileStream(id),
      catchError: (context, error) {
        print("IN USER STREAM CATCH ERROR");
        print(error.toString());
      },
      lazy: false,
      child: MaterialApp(
        title: 'Squarrin',
        home: Squarrin(),
      ),
    );
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
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      SearchScreen(),
      RecordScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColor: Colors.blue,
        inactiveColor: Colors.grey,
        isTranslucent: false,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: ("Search"),
        activeColor: Colors.teal,
        inactiveColor: Colors.grey,
        isTranslucent: false,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.videocam),
        title: ("Record"),
        activeColor: Colors.deepOrange,
        inactiveColor: Colors.grey,
        isTranslucent: false,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.account_box),
        title: ("Profile"),
        activeColor: Colors.indigo,
        inactiveColor: Colors.grey,
        isTranslucent: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,
      screens: _buildScreens(),
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
      itemCount: 4,
      iconSize: 26.0,
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