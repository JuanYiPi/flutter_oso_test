import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';

class BuySuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _builFondo(context),
        ],
      )
    );
  }

  _builFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondo = Container(
      color: kColorPrimario,
    );

    final img = Container(
      padding: EdgeInsets.all(40.0),
      child: Column(
        children: <Widget>[
          Text('¡Excelente compra!\n', 
            style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Text('En breve empacaremos tu paquete', 
            style: texto.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.0,),
          Text('Puedes revisar el estado de tu pedido en la sección de "Mis compras"', 
            style: texto.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Expanded(child: 
            Center(
              child: Container(
                height: 45.0,
                width: 150.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  color: kColorSecundario,
                  child: Text('Ir a Inicio', style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, 'home');
                  }
                ),
              )
            ),
          ),
          Container(
            width: size.width * 0.5,
            child: Image
            (image: AssetImage('assets/img/paquete.png'))
          ),
        ],
      ),
    );

    return Stack(
      children: [
        fondo,
        img
      ],
    );
  }
}