import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/components/server_image.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/cart_compuesto.dart';
import 'package:flutter_oso_test/src/providers/carts_provider.dart';

class ShoppingCartProduct extends StatelessWidget {

  final CartDetail cartItem;

  ShoppingCartProduct({
    Key key, 
    @required this.cartItem, 
  }) : super(key: key);

  final cartsProvider = CartsProvider();

  @override
  Widget build(BuildContext context) {
    final cardProduct = Card(
      elevation: 0.0,
      child: Container(
        padding: EdgeInsets.only(left: 10.0),
        height: 120.0,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildProductImg(),
            SizedBox(width: 10.0,),
            _buildProductText(context),
          ],
        ),
      ),
    );

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.redAccent, 
        child: Center(
          child: Text(
            'Eliminar', 
            style: TextStyle(color: Colors.white),
          )
        )
      ),
      onDismissed: (_) async {
        await cartsProvider.deleteFromShoppingCart(this.cartItem);
      },
      child: cardProduct
    );
  }

  Widget _buildProductImg() {
    return ServerImage(
      width: 85.0, 
      heigt: 85.0, 
      imageUrl: this.cartItem.getImg()
    ); 
  }

  Widget _buildProductText(BuildContext context) {
    return Flexible( 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  this.cartItem.descripcion.toLowerCase(),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: kTextColor,
                  ),
                ),
              ),
              IconButton(icon: Icon(Icons.delete, color: kTextLightColor,), onPressed: () async {
                await cartsProvider.deleteFromShoppingCart(this.cartItem);
              })
            ],
          ),
          // SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                onPressed: (){}, 
                child: Text('Cantidad: ${this.cartItem.cantidad}', style: textoLight,)
              ),
              Text(
                '\$${this.cartItem.total}0',
                style: Theme.of(context).textTheme.headline6.copyWith(color: kTextColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}