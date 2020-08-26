import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/components/my_drawer.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';

class HomePage extends StatelessWidget {

  final prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Osoonline'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: (){}       
          ),
          SizedBox(width: 10.0),
          Icon(Icons.favorite),
          SizedBox(width: 10.0),
        ],
      ),
      drawer: MyDrawer(),
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text('Categorias'),
            onPressed: ()=> Navigator.pushNamed(context, 'cat_page')
          ),
        ),
      ),
    );
  }
}