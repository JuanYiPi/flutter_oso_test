import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/components/list_carts.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
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
      body: _buildPurchasesById(),
    );
  }

  AppBar _buildAppbar( BuildContext context ) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Mis compras',
        style: encabezado
      ),
    );
  }

  Widget _buildPurchasesById() {
    return Container(
      child: FutureBuilder(
        future: cartsProvider.getPurchasesById(),
        builder: ( BuildContext context, AsyncSnapshot snapshot ) {
          if (snapshot.hasData) {

            return ListCartsById(
              carts: snapshot.data,
            );

          } else {
            return Container(
              height: 400.0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
      ),
    );
  }

}