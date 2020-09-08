import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';

class ConfirmBuyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                Text('\$208.00', style: textoS,)
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Envio', style: textoS,),
                Text('\$150.00', style: textoS)
              ],
            ),
            SizedBox(height: 15.0,),
            Divider(),
            SizedBox(height: 15.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pagas', style: textoS),
                Text('\$358.00', style: textoS)
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