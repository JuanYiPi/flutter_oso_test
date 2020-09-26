import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/components/shopping_cart_product.dart';
import 'package:flutter_oso_test/src/providers/products_provider.dart';

import 'package:flutter_oso_test/src/providers/user_preferences.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/cart_compuesto.dart';
import 'package:flutter_oso_test/src/providers/carts_provider.dart';

class ShoppingCartPage extends StatefulWidget {

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {

  final cartsProvider = new CartsProvider();
  final productsProvider = new ProductsProvider();
  final prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    cartsProvider.getShoppingCart();
    return _buildBody(context); 
  }

  Widget _buildBody(BuildContext context) {

    return StreamBuilder<CartMap>(
      stream: cartsProvider.shoppingCartInfoStream,
      builder: (BuildContext context, AsyncSnapshot<CartMap> snapshot) {

        if (!snapshot.hasData) {
          return _loading();
        }

        final cartMap = snapshot.data;
        final cartDetail = cartMap.data;
        final cart = cartMap.total;
        prefs.idActiveCart = cart.id;
        print(prefs.idActiveCart);

        if (cartDetail.length == 0) {
          return _emptyCart();
        }
        return _buildScaffold(cartDetail, context, cart); 
      },
    );
  }

  Container _loading() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Center(child: CircularProgressIndicator()),
      color: Colors.white,
    );
  }

  Scaffold _emptyCart() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Carrito de compras'),
      ),
      body: Center(child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(text: 'Tu carrito esta vacío\n\n', style: textoLight),
            TextSpan(text: '¿No sabes que comprar?\nRevisa las categorías de productos\nque tenemos disponibles para ti', 
              style: textoLightColor.copyWith(fontWeight: FontWeight.normal)
            ),
          ]
        )
      )),
    );
  }

  Scaffold _buildScaffold(List<CartDetail> items, BuildContext context, Cart total) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Carrito de compras'),
      ),
      body: _listCartDetail(cartItems: items),
      bottomNavigationBar: _buildButtonBar(context, total)
    );
  }

  Widget _listCartDetail({List<CartDetail> cartItems}) {
    return ListView.builder(
      itemBuilder: (context, index) => ShoppingCartProduct(
        cartItem: cartItems[index], 
        onDelete: cartsProvider.getShoppingCart
      ),
      itemCount: cartItems.length,
    );
  }

  Widget _buildButtonBar(BuildContext context, Cart cart) {
    return Container(
      padding: EdgeInsets.only(left: kDefaultPaddin, right: kDefaultPaddin, top: kDefaultPaddin/2),
      height: 110.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow> [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5.0,
            offset: Offset(0.0, 5.0),
            spreadRadius: 5.0,
         ),
        ]
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total:', style: Theme.of(context).textTheme.headline6.copyWith(color: kTextColor)),
              Text('\$${cart.total}0', style: Theme.of(context).textTheme.headline6.copyWith(color: kTextColor),)
            ],
          ),
          Divider(),
          Container(
            width: double.infinity,
            height: 45.0,
            child: RaisedButton(
              // elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kDefaultRadius)
              ),
              color: kColorSecundario,
              child: Text('Finalizar compra', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pushNamed(context, 'shipping', arguments: cart.total.toString());
              }
            ),
          )
        ],
      ),
    );
  }
}