import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/cart_detail_model.dart';
import 'package:flutter_oso_test/src/providers/carts_provider.dart';

class ShoppingCartPage extends StatelessWidget {

  final cartsProvider = new CartsProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Carrito de compras', style: encabezado,),
      ),
      body: FutureBuilder(
        future: cartsProvider.getShoppingCart(),
        builder: (BuildContext context, AsyncSnapshot<List<CartDetail>> snapshot) {
          if (snapshot.hasData) {
            return _buildProductList(context, snapshot.data);
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }

  Widget _buildProductList(BuildContext context, List<CartDetail> productos) {
    return ListView.separated(
      padding: EdgeInsets.all(kDefaultPaddin),
      itemBuilder: (context, index) {
        return _productIndividual(context, productos[index]);
      }, 
      separatorBuilder: (context, index) => Divider(), 
      itemCount: productos.length
    );
  }

  Widget _productIndividual(BuildContext context, CartDetail producto) {
    return ListTile(
      title: Text(producto.productId.toString()),
      subtitle: Text('\$${producto.precio}'),
    );
  }
}