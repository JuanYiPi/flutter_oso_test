import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/components/server_image.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/cart_detail_model.dart';
import 'package:flutter_oso_test/src/models/cart_model.dart';
import 'package:flutter_oso_test/src/providers/carts_provider.dart';

class PurchaseDetPage extends StatelessWidget {

  final cartsProvider = CartsProvider();

  @override
  Widget build(BuildContext context) {

    final Cart purchase = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Detalle de compra'),
      ), 
      body: _buildBody(purchase),
    );
  }

  FutureBuilder<List<CartDetail>> _buildBody(Cart purchase) {
    return FutureBuilder(
      future: cartsProvider.getCartDetailList(cartId: purchase.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List<CartDetail>> snapshot) {
        if (snapshot.hasData) {
          return _buildDetalle(context, snapshot.data, purchase);
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

  Widget _buildDetalle(BuildContext context, List<CartDetail> cartItems, Cart cart) {
    return ListView(
      children: [
        _buildHeader(context, cart),
        _buildCardItem(context, cartItems),
        // _buildShippingMethod(),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, Cart cart) {
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
              Text('Cargo de envío', style: textoS.copyWith(color: Colors.white),),
              Text('\$ ${cart.gastos}0', style: textoS.copyWith(color: Colors.white))
            ],
          ),
          SizedBox(height: 15.0,),
          Divider(color: Colors.white,),
          SizedBox(height: 15.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tu pago', style: textoS.copyWith(color: Colors.white)),
              Text('\$ ${cart.gastos + cart.total}0', style: textoS.copyWith(color: Colors.white))
            ],
          ),
          SizedBox(height: 25.0,),
          Container(
            width: double.infinity,
            child: Text('Referencia de pago:\n${cart.referenciaPago}', style: textoS.copyWith(color: Colors.white))),
          SizedBox(height: 25.0,),
          Container(
            width: double.infinity,
            child: Text('Estado del pedido:\n${cart.estado}', style: textoS.copyWith(color: Colors.white))),
        ],
      ),
    );
  }

  _buildCardItem(BuildContext context, List<CartDetail> cartItems) {
    return Column(children: cartItems.map((item) => 
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
              child: ServerImage(
                width: 60.0, 
                heigt: 60.0, 
                imageUrl: item.getImg(), 
                errorImagePath: 'assets/img/no_disponible.jpg',
              ),
            ),
            // Container(
            //   clipBehavior: Clip.antiAlias,
            //   decoration: BoxDecoration(shape: BoxShape.circle),
            //   child: FadeInImage(
            //     imageErrorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
            //       print('Error Handler');
            //       return Container(
            //         width: 60.0,
            //         height: 60.0,
            //         child: Image.asset('assets/img/no_disponible.jpg'),
            //       );
            //     },
            //     placeholder: AssetImage('assets/img/loading.gif'), 
            //     image: item.getImg() != null? NetworkImage(item.getImg()): AssetImage('assets/img/no_disponible.jpg'),
            //     fit: BoxFit.cover,
            //     height: 60.0,
            //     width: 60.0,
            //   ),
            // ),
            SizedBox(height: 10.0,),
            Text(item.descripcion.toLowerCase()),
            SizedBox(height: 10.0,),
            Text('Cantidad: ${item.cantidad}')
          ],
        ),
      ),
    )).toList());
  }
}