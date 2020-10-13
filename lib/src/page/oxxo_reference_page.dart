import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/oxxo_pay_model.dart';

import 'package:flutter_oso_test/src/services/conekta_service.dart';

class OxxoReferencePage extends StatelessWidget {

  final conektaService = ConektaService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: conektaService.payWithOxxo(),
      builder: (BuildContext context, AsyncSnapshot<Data> snapshot) {

        if (!snapshot.hasData) {
          return _loading();
        }

        return _buildScaffold(context, snapshot.data);
      },
    );
  }

  Scaffold _buildScaffold(BuildContext context, Data content) {

    final data = content.paymentMethod;

    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              _buildMessage(data, content, context),
            ],
          )
        ),
      ),
    );
  }

  Container _buildMessage(PaymentMethod data, Data content, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: <BoxShadow> [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 3.0,
            offset: Offset(0.0, 5.0),
            spreadRadius: 3.0,
          ),
        ]
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          _header(),
          _logoOxxo(),
          _referenceCode(data),
          _amount(content),
          _ending(),
          _goHome(context)
        ],
      ),
    );
  }

  Container _goHome(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultRadius),
        // color: Colors.blue
      ),
      height: 45.0,
      child: OutlineButton(
        textColor: kColorPrimario,
        child: Text('Seguir comprando'),
        onPressed: () => Navigator.pop(context)
      ),
    );
  }

  Container _ending() {
    return Container(
      child: Text(
        'Tienes 48 horas para realizar el pago, despues de ese tiempo, el numero de referencia perdera su validez',
      )
    );
  }

  Container _amount(Data content) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(text: 'Monto a pagar:\n\n', style: kTencabezado),
            TextSpan(text: '\$${content.getTotal[0]}.${content.getTotal[1]}\n', style: priceLight),
          ]
        )
      ),
    );
  }

  Container _referenceCode(PaymentMethod data) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(5.0)
      ),
      child: Text('${data.reference}', style: price.copyWith(fontSize: 25.0),),
    );
  }

  Container _logoOxxo() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Image.asset('assets/img/oxxo.jpg')
    );
  }

  Container _header() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(text: '¡Excelente Compra!\n\n\n', style: kTencabezado),
            TextSpan(text: 'Ahora solo debes ir a tu tienda OXXO más cercana, y darle al cajero el siguiente número de referencia:\n', style: texto),
          ]
        )
      ),
    );
  }

  Widget _loading() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Center(child: CircularProgressIndicator()),
      color: Colors.white,
    );
  }
}