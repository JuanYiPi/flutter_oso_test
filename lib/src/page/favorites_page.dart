import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/components/my_product_card.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';
import 'package:flutter_oso_test/src/providers/favorites_provider.dart';


class FavoritesPage extends StatelessWidget {

  final favsProvider = FavoritesProvider();

  @override
  Widget build(BuildContext context) {

    favsProvider.getFavorites();

    return StreamBuilder<List<Product>>(
      stream: favsProvider.favoritosStream,
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {

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
        centerTitle: true,
        title: Text('Mis favoritos'),
      ),
      body: Center(child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(text: 'Sin favoritos\n\n', style: textoLight),
            TextSpan(text: 'Parece que aun no has\nagregado ningún producto a\ntu lista de favoritos', 
              style: textoLightColor.copyWith(fontWeight: FontWeight.normal)
            ),
          ]
        )
      )),
    );
  }

  Scaffold _buildScaffold(List<Product> products, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Mis favoritos'),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => MyProductCard(
          product: products[index], 
          isFavoriteCard: true,
          onDelete: favsProvider.getFavorites,
        ),
        itemCount: products.length,
      ),   
    );
  }
}