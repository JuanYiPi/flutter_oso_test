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
          return Container(
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Image.asset('assets/img/paquete.png', height: 100.0,),
            ),
          );
        }
        if (snapshot.data.length == 0) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Mis direcciones'),
            ),
            body: Center(child: Text('No ha registrado ninguna direccion'),),
          );
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
        );
      },
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     centerTitle: true,
    //     title: Text('Mis direcciones'),
    //   ),
    //   body: FutureBuilder<List<Direction>>(
    //     future: directionsProvider.getAllDirections(),
    //     builder: (BuildContext context, AsyncSnapshot<List<Direction>> snapshot) {
    //       if (snapshot.hasData) {
    //         final directions = snapshot.data;
    //         return ListView.builder(
    //           itemBuilder: (context, index) {
    //             return _directionCard(directions[index]);
    //           },
    //           itemCount: directions.length,
    //         );
    //       } else {
    //         return Center(child: CircularProgressIndicator(),);
    //       }
    //     },
    //   ),
    // );
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
          title: Text(direction.street, style: Theme.of(context).textTheme.subtitle2,),
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