import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/providers/favorites_provider.dart';


class FavoritesPage extends StatelessWidget {

  final favProvider = FavoritesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () {
                favProvider.getFavorites();
              }, 
              child: Text('Favoritos')
            )
          ],
        )
      ),
    );
  }
}