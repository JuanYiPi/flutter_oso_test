import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/cart_compuesto.dart';
import 'package:flutter_oso_test/src/providers/carts_provider.dart';

class ConfirmBuyPage extends StatelessWidget {

  final cartsProvider = CartsProvider();

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: cartsProvider.getCartMap(),
      builder: (BuildContext context, AsyncSnapshot<CartMap> snapshot) {
        if (!snapshot.hasData) {
          return _loading();
        }

        final cartMap = snapshot.data;
        final cartDetail = cartMap.data;
        final cart = cartMap.total;

        if (cartDetail.length == 0) {
          return _emptyCart();
        }
        
        return _buildScaffold(context, cart, cartDetail); 
      },
    );
  }

  Widget _loading() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Center(child: CircularProgressIndicator()),
      color: Colors.white,
    );
  }

  Widget _emptyCart() {
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

  Widget _buildScaffold(BuildContext context, Cart cart, List<CartDetail> cartDetail) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Confirma tu compra'),
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: 30.0),
        children: [
          _buildHeader(cart, context),
          _builCardItem(cartDetail),
          _buildShippingDirection(),
        ],
      ) 
    );
  }

  Widget _buildHeader(Cart cart, BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(top: 20.0, bottom: 30.0, left: 20.0, right: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Producto', style: textoS.copyWith(color: Colors.white),),
              Text('\$ ${cart.total}0', style: textoS.copyWith(color: Colors.white),)
            ],
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Envio', style: textoS.copyWith(color: Colors.white),),
              Text('\$ ${cart.gastos}0', style: textoS.copyWith(color: Colors.white))
            ],
          ),
          SizedBox(height: 15.0,),
          Divider(color: Colors.white,),
          SizedBox(height: 15.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pagas', style: textoS.copyWith(color: Colors.white)),
              Text('\$ ${cart.gastos + cart.total}0', style: textoS.copyWith(color: Colors.white))
            ],
          ),
          SizedBox(height: 25.0,),
          Container(
            width: double.infinity,
            height: 45.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)
              ),
              color: kColorSecundario,
              child: Text('Confirmar compra', style: TextStyle(color: Colors.white),),
              onPressed: () {
                _pay(context, (cart.total+cart.gastos).toString());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _builCardItem(List<CartDetail> items) {
    return Column(children: items.map((item) => 
    new Card(
      elevation: 0.0,
      child: Container(
        padding: EdgeInsets.all(10.0),
        height: 150.0,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: FadeInImage(
                imageErrorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                  print('Error Handler');
                  return Container(
                    width: 50.0,
                    height: 50.0,
                    child: Image.asset('assets/img/no_disponible.jpg'),
                  );
                },
                placeholder: AssetImage('assets/img/loading.gif'), 
                image: item.getImg() != null? NetworkImage(item.getImg()): AssetImage('assets/img/no_disponible.jpg'),
                fit: BoxFit.cover,
                height: 50.0,
                width: 50.0,
              ),
            ),
            SizedBox(height: 10.0,),
            Text(item.descripcion.toLowerCase()),
            SizedBox(height: 10.0,),
            Text('Cantidad: ${item.cantidad}')
          ],
        ),
      ),
    )).toList());
  }

  Widget _buildShippingDirection() {
    return Card(
      elevation: 0.0,
      child: Container(
        padding: EdgeInsets.all(20.0),
        height: 200.0,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_shipping, size: 40.0, color: kColorSecundario),
            Text('Codigo Postal'),
            Text('Toda la direccion aqui')
          ],
        ),
      ),
    );
  }

  _pay(BuildContext context, String total) {
    Navigator.pushNamed(context, 'payment', arguments: total);
  }

}