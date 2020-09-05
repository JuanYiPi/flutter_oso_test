import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/models/cart_model.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';
// import 'package:flutter_oso_test/src/bloc/shopping_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/cart_detail_model.dart';
import 'package:flutter_oso_test/src/providers/carts_provider.dart';

class ShoppingCartPage extends StatefulWidget {

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {

  final cartsProvider = new CartsProvider();
  final prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {

    cartsProvider.getShoppingCart();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Carrito de compras'),
      ),
      body: _buildBody(), 
      // bottomNavigationBar: _buildButtonBar(context)
    );
  }

  // Widget _buildButtonBar(BuildContext context) {

  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black26,
  //           blurRadius: 3.0,
  //           offset: Offset(0.0, 5.0),
  //           spreadRadius: 5.0,
  //         )
  //       ]
  //     ),
  //     height: 100.0,
  //     child: RaisedButton(
  //       child: Text('pagar', style: TextStyle(color: Colors.white),),
  //       color: Theme.of(context).primaryColor,
  //       onPressed: (){}
  //     )
  //   ); 
  // }

  Widget _buildBody() {
    return StreamBuilder<List<CartDetail>>(
      stream: cartsProvider.shoppingCartStream,
      builder: (BuildContext context, AsyncSnapshot<List<CartDetail>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }
        final items = snapshot.data;
        if (items.length == 0) {
          return Center(child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(text: 'Tu carrito esta vacío\n\n', style: textoLight),
                TextSpan(text: '¿No sabes que comprar?\nRevisa las categorias de productos\nque tenemos disponibles para ti', 
                  style: textoLightColor.copyWith(fontWeight: FontWeight.normal)
                ),
              ]
            )
          ));
        }
        return _listCartDetail(cartItems: snapshot.data);
      },
    );
    
    // FutureBuilder(
    //   future: cartsProvider.getShoppingCart(),
    //   builder: (BuildContext context, AsyncSnapshot<List<CartDetail>> snapshot) {
    //     if (snapshot.hasData) {
          // if (snapshot.data.length == 0) {
          //   return Center(child: RichText(
          //     textAlign: TextAlign.center,
          //     text: TextSpan(
          //       children: [
          //         TextSpan(text: 'Tu carrito esta vacío\n\n', style: textoLight),
          //         TextSpan(text: '¿No sabes que comprar?\nRevisa las categorias de productos\nque tenemos disponibles para ti', 
          //           style: textoLightColor.copyWith(fontWeight: FontWeight.normal)
          //         ),
          //       ]
          //     )
          //   ));
          // }
    //       return _listCartDetail(cartItems: snapshot.data);
    //     } else {
    //       return Center(child: CircularProgressIndicator(),);
    //     }
    //   },
    // );
  }

  Widget _listCartDetail({List<CartDetail> cartItems}) {
    return ListView.builder(
      itemBuilder: (context, index) => _cartDetail(context, cartItems[index]),
      itemCount: cartItems.length,
    );
  }

  _cartDetail(BuildContext context, CartDetail cartItem) {

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
                '\$${cartItem.total}',
                style: Theme.of(context).textTheme.headline6.copyWith(color: kTextColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ClipRRect _buildProductImg(CartDetail cartItem) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(10.0),
      child: FutureBuilder(
        future: _checkUrl(cartItem.getImg()),
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

  Future<int> _checkUrl(String url) async {
    try {
      final response = await http.get(url);
      print(response.statusCode);
      return response.statusCode;
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}