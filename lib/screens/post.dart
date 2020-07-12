import "package:flutter/material.dart";
import "package:swell_mobile_ui/models/item.dart";
import "package:provider/provider.dart";
import 'package:swell_mobile_ui/models/cart.dart';

class Post extends StatelessWidget {
  final Item item;

  Post(this.item);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('${item.owner_id}', style: TextStyle(fontWeight: FontWeight.bold),)
              ],
            ),
            Spacer(),
            IconButton(icon: Icon(Icons.more_vert), onPressed: () => {},)
          ],
        ),
        GestureDetector(
          
        )
      ],
    );
  }
}
