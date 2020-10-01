import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';


class CartCounterBeta extends StatefulWidget {

  final int stock;
  final Product product;

  CartCounterBeta({
    @required this.stock, 
    @required this.product
  });

  @override
  _CartCounterBetaState createState() => _CartCounterBetaState();
}

class _CartCounterBetaState extends State<CartCounterBeta> {

  final textController = new TextEditingController();
  // final _focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {

    String cantidad = widget.product.cantidadCompra.toString();

    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kDefaultRadius)),
      elevation: 0.0,
      onPressed: (){
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Introduzca la cantidad'),
            content: TextField(
              controller: textController,
              autofocus: true,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                cantidad = value;
                print(cantidad);
              },
            ),
            actions: [
              MaterialButton(
                child: Text('Aceptar'),
                textColor: Colors.blue,
                onPressed: () {
                  textController.clear();
                  _verificar(cantidad);
                  Navigator.pop(context);
                }
              ),
              MaterialButton(
                child: Text('Cancelar'),
                textColor: Colors.blue,
                onPressed: () {
                  textController.clear();
                  Navigator.pop(context);
                }
              )
            ],
          )
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Cantidad: $cantidad', 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              color: Colors.black87
            ),
          ),
          Icon(Icons.chevron_right, color: kColorPrimario,),
        ],
      ) ,
    );
  }

  void _verificar(String input) {
    try {
      final cantidad = int.parse(input);
      if(cantidad <= widget.product.stock) {
        widget.product.cantidadCompra = cantidad;
      } else {
        print('Stock insuficiente');
      }

    } catch (e) {
      print('No se pudo agregar la cantidad seleccionada');
    }
    setState(() {});
  }
}