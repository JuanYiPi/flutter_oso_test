import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/providers/carts_provider.dart';

class ShippingMethod extends StatelessWidget {

  // ShippingMethod({Key key}) : super(key: key);

  final cartsProvider = new CartsProvider();

  @override
  Widget build(BuildContext context) {

    final String total = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Método de entrega'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
            ),
            child: ListTile(
              title: Text('Entrega a domicilio'),
              subtitle: Text('Se aplicarán costos de envío adicionales'),
              trailing: Icon(Icons.chevron_right),
              onTap: () async {
                Navigator.pushNamed(context, 'address');
              },
            )
          ),
          SizedBox(height: 10.0,),
          Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
            ),
            child: ListTile(
              title: Text('Recoger en tienda'),
              subtitle: Text('Pagas: \$${total}0'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                // Navigator.pushNamed(context, 'payment', arguments: total);
                _navigateToConfirm(context, 0.0, 'Tienda');
              },
            )
          )
        ],
      )
    );
  }

  void _navigateToConfirm(BuildContext context, double gastos, String mEntrega) async {
    final resp = await cartsProvider.updateShoppingCart(
      gastos  : gastos.toString(),
      mEntrega: mEntrega,
    );
    if (resp == true){
      Navigator.pushNamed(context, 'confirm');
    } else {
      print('Error al actualizar');
    }
  }
}