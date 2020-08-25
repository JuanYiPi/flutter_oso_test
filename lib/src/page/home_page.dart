import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Osonline'),
        actions: <Widget>[
          Icon(Icons.shopping_cart),
          Icon(Icons.favorite)
        ],
      ),
    );
  }
}