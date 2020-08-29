import 'package:flutter/material.dart';

class AddressesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Mis direcciones de envio'),
      ),
      body: Column(
        children: <Widget>[
          Expanded( child: Container() ),
        ],
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