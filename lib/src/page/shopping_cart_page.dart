import 'package:flutter/material.dart';
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

        final cartInfo = snapshot.data;
        final items = cartInfo.data;
        final total = cartInfo.total;

        if (items.length == 0) {
          return _emptyCart();
        }
        return _buildScaffold(items, context, total); 
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
            TextSpan(text: '¿No sabes que comprar?\nRevisa las categorias de productos\nque tenemos disponibles para ti', 
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
      itemBuilder: (context, index) => _cartDetail(context, cartItems[index]),
      itemCount: cartItems.length,
    );
  }

  Widget _cartDetail(BuildContext context, CartDetail cartItem) {

    final cardProduct = Card(
      elevation: 0.0,
      child: Container(
        padding: EdgeInsets.only(left: kDefaultPaddin/2),
        height: 120.0,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildProductImg(cartItem),
            SizedBox(width: kDefaultPaddin/2,),
            _buildProductText(context, cartItem),
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
      onDismissed: (direction) {
        cartsProvider.deleteFromShoppingCart(cartItem);
      },
      child: cardProduct
    );
  }

  ClipRRect _buildProductImg(CartDetail cartItem) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(10.0),
      child: FutureBuilder(
        future: productsProvider.checkUrl(cartItem.getImg()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != 200) {
              return Container(
                child: Image(image: AssetImage('assets/img/no_disponible.jpg')),
                height: 85.0,
                width: 85.0,
              );
            }
            return Container(
              height: 85.0,
              width: 85.0,
              child: FadeInImage(
                placeholder: AssetImage('assets/img/loading.gif'), 
                image: NetworkImage(cartItem.getImg()),
                fit: BoxFit.cover,
              ),
            );
          } else {
            return Container(
              height: 85.0,
              width: 85.0,
              child: Image(
                image: AssetImage('assets/img/loading.gif'), 
                fit: BoxFit.cover,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildProductText(BuildContext context, CartDetail cartItem) {
    return Flexible( 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  cartItem.descripcion.toLowerCase(),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: kTextColor,
                  ),
                ),
              ),
              IconButton(icon: Icon(Icons.delete, color: kTextLightColor,), onPressed: () {
                cartsProvider.deleteFromShoppingCart(cartItem);
              })
            ],
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                onPressed: (){}, 
                child: Text('Cantidad: ${cartItem.cantidad}', style: textoLight,)
              ),
              Text(
                '\$${cartItem.total}0',
                style: Theme.of(context).textTheme.headline6.copyWith(color: kTextColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonBar(BuildContext context, Cart cartDet) {
    return Container(
      padding: EdgeInsets.only(left: kDefaultPaddin, right: kDefaultPaddin, top: kDefaultPaddin/2),
      height: 140.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
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
              Text('Total:', style: Theme.of(context).textTheme.headline5),
              Text('\$${cartDet.total}0', style: Theme.of(context).textTheme.headline5,)
            ],
          ),
          Divider(),
          Container(
            width: double.infinity,
            height: 45.0,
            child: RaisedButton(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)
              ),
              color: Theme.of(context).primaryColor,
              child: Text('Finalizar compra', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pushNamed(context, 'shipping', arguments: cartDet.total.toString());
              }
            ),
          )
        ],
      ),
    );
  }
}