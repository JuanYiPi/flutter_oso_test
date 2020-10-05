import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/models/cart_model.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';

class ListCartsById extends StatelessWidget {

  final List<Cart> carts;
  ListCartsById({@required this.carts});
  final prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {

    return ListView(
      children: _crearListCartsById( context, carts )
    );
  }

  List<Widget> _crearListCartsById( BuildContext context, List<Cart> carts ) {

    final List<Widget> cartsById = [];

    carts.forEach((cart) {
      
      final tempWidget = _catIndividual( context, cart );

      cartsById.add(tempWidget);
      cartsById.add(Divider());

    });

    return cartsById;
  }

  Widget _catIndividual( BuildContext context, Cart cart ) {

    final tarjeta = ListTile(
      title: Column(
        children: <Widget>[
          Text(cart.id.toString()),
          SizedBox(height: 5),
          Text(cart.fechaPedido),
          SizedBox(height: 5),
          Text(cart.total.toString()),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, 'det_shopping', arguments: cart.id.toString());
      },
    );

    return tarjeta;
  }
}