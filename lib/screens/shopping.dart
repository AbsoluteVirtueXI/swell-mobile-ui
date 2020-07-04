import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/models/cart.dart';
import 'package:swell_mobile_ui/services/api_service.dart';


class ShoppingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);
    var api = Provider.of<ApiService>(context, listen: false);
    var price = 0;
    cart.items.forEach((item) => price += item.price);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: () {
                    cart.removeItem(cart.items[index]);
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(cart.items[index].path),
                    ),
                    title: Text('${cart.items[index].title} \t\t\t\t ${cart.items[index].price} Quadreum'),
                    subtitle: Text('${cart.items[index].bio}'),
                    trailing: Icon(Icons.remove_shopping_cart),
                    dense: true,
                  ),
                );
              },
            ),
          ),
          Text('Price: $price'),
          RaisedButton(child: Text('Buy'), color: Colors.redAccent,),
        ],
      ),
    );
  }
}
