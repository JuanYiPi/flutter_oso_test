import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/providers/user_preferences.dart';

class ShoppingCartButton extends StatelessWidget {

  final String totalItems;

  ShoppingCartButton({
    Key key, 
    @required this.totalItems
  }) : super(key: key);

  final prefs = UserPreferences();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: (this.totalItems == null) ? 
      Icon(Icons.shopping_cart) : Stack(
        children: [
          Center(child: Icon(Icons.shopping_cart)),
          Container(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle
              ),
              child: Text(this.totalItems, style: TextStyle(fontSize: 10.0) ),
            ),
          )
        ],
      ),
      onPressed: (){
        Navigator.pushNamed(context, 'shopping_cart');
      }       
    );
  }
}