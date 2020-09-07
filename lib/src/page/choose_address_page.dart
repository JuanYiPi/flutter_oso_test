import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/providers/carts_provider.dart';
import 'package:flutter_oso_test/src/providers/directions_provider.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/direction_model.dart';

class ChooseAddress extends StatefulWidget {
  @override
  _ChooseAddressState createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {

  final directionsProvider = new DirectionsProvider();
  final cartsProvider = new CartsProvider();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  int _directionId;

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Direction>>(
      future: directionsProvider.getAllDirections(),
      builder: (BuildContext context, AsyncSnapshot<List<Direction>> snapshot) {
        if (!snapshot.hasData){
          return _buildLoadingScreen();
        }
        if (snapshot.data.length == 0) {
          return _buildEmptyScreen();
        } 
        final directions = snapshot.data;
        return _buildScaffold(directions, context);
      },
    );
  }

  Scaffold _buildScaffold(List<Direction> directions, BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Mis direcciones'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return _directionCard(directions[index]);
          },
          itemCount: directions.length,
        ),
        bottomNavigationBar: _buildBottonButton(context),
      );
  }

  Container _buildBottonButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow> [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5.0,
            offset: Offset(0.0, 5.0),
            spreadRadius: 5.0,
        ),
        ]
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Container(
        height: 45.0,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 3.0,
          color: Theme.of(context).primaryColor,
          child: Text('Continuar compra', style: TextStyle(color: Colors.white),),
          onPressed: _directionId != null? () async {
            final cart = await cartsProvider.getActiveCart();
            if (cart != null) {
              final status = await cartsProvider.updateCartById(_directionId.toString() ,cart.id.toString());
              if (status == true) Navigator.pushNamed(context, 'payment');
              else _mostrarSnackbar('Algo salio mal, intentelo de nuevo mas tarde');
            }
          } : null
        ),
      ),
    );
  }

  Scaffold _buildEmptyScreen() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Mis direcciones'),
      ),
      body: Center(child: Text('No ha registrado ninguna direccion'),),
    );
  }

  Container _buildLoadingScreen() {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator()
      ),
    );
  }

  Widget _directionCard(Direction direction) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
      child: RadioListTile(
        value: direction.id, 
        groupValue: _directionId, 
        onChanged: _setSelectedRadio,
        title: ListTile(
          title: Text('${direction.street} - ${direction.numberExt}', style: Theme.of(context).textTheme.subtitle2,),
          subtitle: RichText(
            text: TextSpan(
              style: TextStyle(color: kTextLightColor,),
              children: [
                TextSpan(text: '\n${direction.colony} - ${direction.city}\n'),
                TextSpan(text: '${direction.state} - ${direction.country}\n${direction.reference}\n'),
                TextSpan(text: '${direction.receive}\n${direction.receivePhone}\n')
              ]
            )
          ),
        ),
      ),
    );
  }

  void _setSelectedRadio(int value) {
    _directionId = value;
    print('$_directionId');
    setState(() {});
  }

  void _mostrarSnackbar(String text) {
    final snackbar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(text),
      duration: Duration(milliseconds: 2000),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}