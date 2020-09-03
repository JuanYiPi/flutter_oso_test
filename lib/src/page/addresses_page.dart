import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/components/list_directions.dart';
import 'package:flutter_oso_test/src/models/direction_model.dart';
import 'package:flutter_oso_test/src/providers/directions_provider.dart';

class AddressesPage extends StatelessWidget {

  final directionProvider = new DirectionsProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Mis direcciones de envio'),
      ),
      body: FutureBuilder(
        future: directionProvider.getAllDirection(),
        builder: (BuildContext context, AsyncSnapshot<List<Direction>> snapshot) {
          
          if ( snapshot.hasData ) {
            return ListAllDirections(directions: snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: addAddresses(context),
    );
  }

  Widget addAddresses( BuildContext context ) {

    return FloatingActionButton(  
      child: Icon(Icons.add),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: ()=> Navigator.pushNamed(context, 'register_addresses')
    );
  }
}