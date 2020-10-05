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

  int cantidadCompra;

  @override
  void initState() {
    cantidadCompra = 1;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    widget.product.cantidadCompra = cantidadCompra;

    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kDefaultRadius)),
      elevation: 0.0,
      onPressed: _insertCuantity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Cantidad: $cantidadCompra', 
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

  _insertCuantity() {

    final textController = new TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Introduzca la cantidad'),
        content: TextField(
          decoration: InputDecoration(
            hintText: '  (${widget.product.stock} disponibles)'
          ),
          controller: textController,
          autofocus: true,
          keyboardType: TextInputType.number,
          onSubmitted: (_){
            _verificar(textController.text);
          },
        ),
        actions: [
          MaterialButton(
            child: Text('Cancelar'),
            textColor: Colors.blue,
            onPressed: () => Navigator.pop(context)
          ),
        ],
      )
    );
  }

  void _verificar(String input) {

    if(input.length >= 1) {
      try {
        final cantidad = int.parse(input);
        if(cantidad <= widget.product.stock) {
          setState(() {
            cantidadCompra = cantidad;
          });
        } else {
          print('Stock insuficiente');
          setState(() {
            cantidadCompra = widget.product.stock;
          });
        }
      } catch (e) {
        print('No se pudo agregar la cantidad seleccionada');
      }
    }
    Navigator.pop(context);
    setState(() {});
  }
}