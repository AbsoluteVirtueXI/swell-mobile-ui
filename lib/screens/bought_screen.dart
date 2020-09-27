import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/models/cart.dart';
import 'package:swell_mobile_ui/services/api_service.dart';
import 'package:swell_mobile_ui/models/user.dart';
class BoughtScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context, listen: false);
    var cart = Provider.of<CartModel>(context);
    var api = Provider.of<ApiService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Bought videos", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Krona', color: Colors.white),),),
      body: Center(child: Text('BOUGHT VIDEO'),),
    );
  }
}
