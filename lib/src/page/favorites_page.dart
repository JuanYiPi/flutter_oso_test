import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/components/my_product_card.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';
import 'package:flutter_oso_test/src/providers/favorites_provider.dart';


class FavoritesPage extends StatelessWidget {

  final favProvider = FavoritesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis favoritos')
      ),
      body: FutureBuilder(
        future: favProvider.getFavorites(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData) {
            final products = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) => MyProductCard(product: products[index]),
              itemCount: products.length,
            );
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),      
    );
  }
}