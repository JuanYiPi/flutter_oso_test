import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/components/list_carts.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/cart_model.dart';
import 'package:flutter_oso_test/src/providers/carts_provider.dart';

class MyShoppingPage extends StatefulWidget {

  @override
  _MyShoppingPageState createState() => _MyShoppingPageState();
}

class _MyShoppingPageState extends State<MyShoppingPage> {

  final cartsProvider = CartsProvider();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar( BuildContext context ) {
    return AppBar(
      centerTitle: true,
      title: Text('Mis compras'),
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
      future: cartsProvider.getAllPurchases(),
      builder: ( BuildContext context, AsyncSnapshot<List<Cart>> snapshot ) {

        if (!snapshot.hasData) {
          return _loading();
        }

        final purchases = snapshot.data;

        if (purchases.length == 0) {
          return _emptyPage();
        }
        return _buildPurchases(context, purchases); 
      }
    );
  }

  Widget _loading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _emptyPage() {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(text: 'No hay compras recientes\n\n', style: textoLight),
            TextSpan(text: 'El detalle de las compras\nque realices se mostrarán aquí', 
              style: textoLightColor.copyWith(fontWeight: FontWeight.normal)
            ),
          ]
        )
      )
    );
  }

  Widget _buildPurchases(BuildContext context, List<Cart> purchases) {
    return ListView.builder(
      itemBuilder: (context, index) => _purchaseCard(context ,purchases[index]),
      itemCount: purchases.length,
    );
  }

  Widget _purchaseCard(BuildContext context, Cart purchas) {
    final card = Card(
      elevation: 0.0,
      child: Container(
        height: 100.0,
      ),
    );

    return GestureDetector(
      child: card,
      onTap: () {},
    );
  }

}