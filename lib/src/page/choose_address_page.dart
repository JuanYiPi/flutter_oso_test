import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/direction_model.dart';
import 'package:flutter_oso_test/src/providers/directions_provider.dart';

class ChooseAddress extends StatefulWidget {
  @override
  _ChooseAddressState createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {

  final directionsProvider = new DirectionsProvider();

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
          bottomNavigationBar: Container(
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
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: RaisedButton(
              elevation: 3.0,
              color: Theme.of(context).primaryColor,
              child: Text('Continuar compra', style: TextStyle(color: Colors.white),),
              onPressed: _directionId != null? () {
                
              } : null
            ),
          ),
        );
      },
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

  _setSelectedRadio(int value) {
    _directionId = value;
    print('$_directionId');
    setState(() {});
  }
}