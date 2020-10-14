import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';


class CommentDonePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Text(
            '¡Muchas gracias por su comentario! Será de ayuda para las demás personas que quieran comprar este producto', 
            style: Theme.of(context).textTheme.headline5.copyWith(color: kTextColor),
            textAlign: TextAlign.center,
          )
        ),
      ),
    );
  }
}