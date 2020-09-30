import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/providers/carts_provider.dart';

import 'package:flutter_oso_test/src/providers/user_preferences.dart';

class ShoppingCartButton extends StatelessWidget {

  ShoppingCartButton({
    Key key, 
  }) : super(key: key);

  final prefs = UserPreferences();
  final cartsProvider = CartsProvider();

  @override
  Widget build(BuildContext context) {

    return (prefs.idUsuario == 0) ? Container() : StreamBuilder(
      stream: cartsProvider.itemsStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot){

        if (!snapshot.hasData) {
          return Icon(Icons.shopping_cart);
        }

        final items = snapshot.data;

        if (items == 0) {
          return Icon(Icons.shopping_cart);
        }

        if (items > 9) {
          return _buildButton(context, '+9');
        }

        return _buildButton(context, items.toString());

      },
    );
  }

  Widget _buildButton(BuildContext context, String totalItems) {
    return IconButton(
      icon: (totalItems == null) ? 
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
              child: Text(totalItems, style: TextStyle(fontSize: 10.0) ),
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