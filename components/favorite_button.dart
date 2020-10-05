import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/providers/favorites_provider.dart';

import 'package:flutter_oso_test/src/models/product_model.dart';

class FavoriteButton extends StatefulWidget {

  final Product product;
  final bool littleSize;

  const FavoriteButton({
    Key key, 
    @required this.product, 
    this.littleSize = true
  }) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState(this.product, this.littleSize);
}

class _FavoriteButtonState extends State<FavoriteButton> {

  final Product product;
  final bool littleSize;
  final favProvider = FavoritesProvider();

  _FavoriteButtonState(
    this.product, 
    this.littleSize
  );

  @override
  Widget build(BuildContext context) {

    return littleSize ? IconButton(
      icon: (product.favorite == 1) 
      ? Icon( Icons.star, size: 17.0 )
      : Icon( Icons.star_border, size: 17.0 ), 
      onPressed: () {
        _addToFavorite();
      }
    ) : IconButton(
      icon: (product.favorite == 1) 
      ? Icon( Icons.star)
      : Icon( Icons.star_border), 
      onPressed: () {
        _addToFavorite();
      }
    );
  }

  void _addToFavorite() async {

    if(this.product.favorite == 0) {
      final resp = await favProvider.addToFavorite(this.product.id.toString());
      setState(() {
        if(resp) {
          this.product.favorite = 1;
        } else {
          this.product.favorite = 0;
        }
      });
    } else {
      final resp = await favProvider.deleteFavorite(this.product.id.toString());
      if (resp) {
        setState(() {
          this.product.favorite = 0;
        });
      }
    }
    
  }
}