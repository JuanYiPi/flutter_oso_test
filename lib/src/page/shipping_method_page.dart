import 'package:flutter/material.dart';

class ShippingMethod extends StatelessWidget {
  const ShippingMethod({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final String total = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Selecciona un método de entrega'),
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
              subtitle: Text('Se aplicaran costos de envio adicionales'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {

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

              },
            )
          )
        ],
      )
    );
  }
}