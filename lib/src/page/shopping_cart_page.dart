import 'package:flutter/material.dart';
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
  bool _isLoading;

  @override
  void initState() { 
    super.initState();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Carrito de compras', style: encabezado,),
      ),
      body: Stack(
        children: [
          _buildBody(),
          _loadingIndicator(),
        ],
      ) 
    );
  }

  Widget _loadingIndicator() {
    if (_isLoading == true) {
      return Stack(
        children: [
          Container(color: Colors.white.withOpacity(0.85),),
          Center(child: CircularProgressIndicator(),),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _buildBody() {
    return FutureBuilder(
      future: cartsProvider.getShoppingCart(),
      builder: (BuildContext context, AsyncSnapshot<List<CartDetail>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
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
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
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
        padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin/2),
        height: 120.0,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // SizedBox(width: kDefaultPaddin/2,),
            _buildProductImg(cartItem),
            SizedBox(width: kDefaultPaddin/2,),
            _buildProductText(cartItem),
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
      onDismissed: (direction) async {
        await cartsProvider.deleteFromShoppingCart(cartItem);
        setState(() {});
      },
      child: cardProduct 
    );
  }

  Widget _buildProductText(CartDetail cartItem) {
    return Flexible( 
      // width: screenSize.width * 0.5,
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
              IconButton(icon: Icon(Icons.delete, color: kTextLightColor,), onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                await cartsProvider.deleteFromShoppingCart(cartItem);
                // cartsProvider.getShoppingCart();
                setState(() {
                  _isLoading = false;
                });
              })
            ],
          ),
          SizedBox(height: 15.0),

          // mostrar el precio del producto
          Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                onPressed: (){}, 
                child: Text('Cantidad: ${cartItem.cantidad}', style: textoLight,)
              ),
              Text(
                '\$${cartItem.total}',
                style: priceLight,
              ),
            ],
          ),

          // SizedBox(height: 8.0),

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
                height: 100.0,
                width: 100.0,
              );
            }
            return Container(
              height: 100.0,
              width: 100.0,
              child: FadeInImage(
                placeholder: AssetImage('assets/img/loading.gif'), 
                image: NetworkImage(cartItem.getImg()),
                fit: BoxFit.cover,
              ),
            );
          } else {
            return Container(
              height: 100.0,
              width: 100.0,
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