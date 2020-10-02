import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/providers/directions_provider.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/direction_model.dart';
import 'package:flutter_oso_test/src/components/list_directions.dart';

class AddressesPage extends StatelessWidget {

  final directionsProvider = new DirectionsProvider();

  @override
  Widget build(BuildContext context) {
    directionsProvider.getAllDirections();

    return 
    StreamBuilder<List<Direction>>(
      stream: directionsProvider.addressStream,
      builder: (BuildContext context, AsyncSnapshot<List<Direction>> snapshot) {

        if (!snapshot.hasData) {
          return _loading();
        }

        final _directions = snapshot.data;

        if (_directions.length == 0) {
          return _emptyPage(context);
        }
        return _buildScaffold(_directions, context); 
      },
    );
  }

  Container _loading() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Center(child: CircularProgressIndicator()),
      color: Colors.white,
    );
  }

  Scaffold _emptyPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text('Direcciones'),
      ),
      body: Center(child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(text: 'Sin direcciones\n\n', style: textoLight),
            TextSpan(text: 'Agrega una dirección de envío\npara poder realizar compras', 
              style: textoLightColor.copyWith(fontWeight: FontWeight.normal)
            ),
          ]
        )
      )),
      floatingActionButton: _addAddresses(context),
    );
  }

  Scaffold _buildScaffold(List<Direction> items, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text('Direcciones'),
      ),
      body: ListAllDirections(
        directions: items, 
        onChange: directionsProvider.getAllDirections,
      ),
      floatingActionButton: _addAddresses(context),
    );
  }

  Widget _addAddresses( BuildContext context ) {

    return FloatingActionButton(  
      child: Icon(Icons.add),
      backgroundColor: kColorPrimario.shade700,
      onPressed: () => Navigator.pushNamed(context, 'register_addresses')
    );
  }
}