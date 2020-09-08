import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/providers/carts_provider.dart';
import 'package:flutter_oso_test/src/providers/directions_provider.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/direction_model.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';

class ChooseAddress extends StatefulWidget {
  @override
  _ChooseAddressState createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {

  final directionsProvider = new DirectionsProvider();
  final cartsProvider = new CartsProvider();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final prefs = UserPreferences();

  double total = 150.0;
  int _directionId;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

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
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Container _bottomNavigationBar(BuildContext context) {
    return Container(
      height: 130.0,
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Envío:', style: Theme.of(context).textTheme.headline6,),
              Text('\$150.00', style: Theme.of(context).textTheme.headline6),
            ],
          ),
          Divider(),
          _payButton(context),
        ],
      ),
    );
  }

  Widget _payButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        elevation: 3.0,
        color: Theme.of(context).primaryColor,
        child: Text('Continuar compra', style: TextStyle(color: Colors.white),),
        onPressed: _directionId != null && !_isLoading? () {
          _updateCartShippingDirection(context);
        } : null
      ),
    );
  }

  void _updateCartShippingDirection(BuildContext context) async {
    setState(() {_isLoading = true;});

    final cart = await cartsProvider.getActiveCart();
    prefs.idActiveCart = cart.id;

    setState(() {_isLoading = false;});
    if (cart != null) {
      total = total + cart.total;
      print(total);
      final status = await cartsProvider.updateCartById(
        directionId: _directionId.toString(), 
        cartId: cart.id.toString(),
        estado: null 
      );

      if (status == true) 
      // Navigator.pushNamed(context, 'confirm');
      Navigator.pushNamed(context, 'payment', arguments: total.toString());
      else _mostrarSnackbar('Algo salio mal, intentelo de nuevo mas tarde');
    }
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