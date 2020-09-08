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
        // prefs.idActiveCart = cart.id;

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
        title: Text(''),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Confirma tu compra\n', style: encabezado),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Producto', style: textoS,),
                Text(cart.total.toString(), style: textoS,)
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Envio', style: textoS,),
                Text(cart.gastos.toString(), style: textoS)
              ],
            ),
            SizedBox(height: 15.0,),
            Divider(),
            SizedBox(height: 15.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pagas', style: textoS),
                Text((cart.gastos + cart.total).toString(), style: textoS)
              ],
            ),
            SizedBox(height: 25.0,),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)
              ),
              color: Theme.of(context).secondaryHeaderColor,
              onPressed: () {},
              child: Text('Confirmar compra'),
            )
          ],
        ),
      )
    );
  }
}