import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/providers/carts_provider.dart';
import 'package:flutter_oso_test/src/providers/directions_provider.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/direction_model.dart';
// import 'package:flutter_oso_test/src/providers/user_preferences.dart';

class ChooseAddress extends StatefulWidget {
  @override
  _ChooseAddressState createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {

  final directionsProvider = new DirectionsProvider();
  final cartsProvider = new CartsProvider();
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
      body: ListView(
        children: [
          _builDirections(directions),
          _addDirectionButton(),
          SizedBox(height: 20.0,),
        ],
      ), 
      // ListView.builder(
      //   itemBuilder: (context, index) {
          // return _directionCard(directions[index]);
      //   },
      //   itemCount: directions.length,
      // ),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  _builDirections(List<Direction> directions) {
    return Column(children: directions.map((direction) => 
    new Card(
      elevation: 0.0,
      child:  RadioListTile(
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
    )).toList());
  }

  _addDirectionButton() {
    return FlatButton(
      child: Text('Agregar dirección'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultRadius)
      ),
      textColor: kColorSecundario,
      onPressed: () {
        _navigateToNewAddress();
      },
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
              Text('Envío:', style: Theme.of(context).textTheme.headline6.copyWith(color: kTextColor),),
              Text('\$150.00', style: Theme.of(context).textTheme.headline6.copyWith(color: kTextColor)),
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
          borderRadius: BorderRadius.circular(kDefaultRadius)
        ),
        // elevation: 3.0,
        color: kColorSecundario,
        child: Text('Continuar compra', style: TextStyle(color: Colors.white),),
        onPressed: _directionId != null && !_isLoading? () {
          _updateShippingcart(context);
        } : null
      ),
    );
  }

  void _updateShippingcart(BuildContext context) async {
    setState(() {_isLoading = true;});

    final resp = await cartsProvider.updateShoppingCart(
      gastos: '150.0',
      mEntrega: 'Domicilio',
      directionId: _directionId.toString()
    );

    setState(() {_isLoading = false;});
    
    if (resp == true) {
      Navigator.pushNamed(context, 'confirm');      
    } else {
      _mostrarSnackbar('Algo salio mal, inténtelo de nuevo más tarde');
    }
  }

  Scaffold _buildEmptyScreen() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Mis direcciones'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No ha registrado ninguna dirección\n'),
            OutlineButton(
              child: Text('Agregar dirección'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kDefaultRadius)
              ),
              textColor: kColorSecundario,
              onPressed: () {
                _navigateToNewAddress();
              },
            )
          ],
        ),
      ),
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

  // Widget _directionCard(Direction direction) {
  //   return Card(
  //     elevation: 0.0,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(5.0)
  //     ),
  //     child: RadioListTile(
  //       value: direction.id, 
  //       groupValue: _directionId, 
  //       onChanged: _setSelectedRadio,
  //       title: ListTile(
  //         title: Text('${direction.street} - ${direction.numberExt}', style: Theme.of(context).textTheme.subtitle2,),
  //         subtitle: RichText(
  //           text: TextSpan(
  //             style: TextStyle(color: kTextLightColor,),
  //             children: [
  //               TextSpan(text: '\n${direction.colony} - ${direction.city}\n'),
  //               TextSpan(text: '${direction.state} - ${direction.country}\n${direction.reference}\n'),
  //               TextSpan(text: '${direction.receive}\n${direction.receivePhone}\n')
  //             ]
  //           )
  //         ),
  //       ),
  //     ),
  //   );
  // }

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

  void _navigateToNewAddress() async {
    final resp = await Navigator.pushNamed(context, 'register_addresses');
    setState(() {});
  }
}