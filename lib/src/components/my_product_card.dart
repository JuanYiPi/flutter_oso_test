import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/components/favorite_button.dart';
import 'package:flutter_oso_test/src/components/server_image.dart';

import 'package:flutter_oso_test/src/constants/constants.dart';

import 'package:flutter_oso_test/src/models/product_model.dart';

import 'package:flutter_oso_test/src/providers/favorites_provider.dart';
import 'package:flutter_oso_test/src/providers/products_provider.dart';

class MyProductCard extends StatefulWidget {
  
  final Product product;
  // final bool isFavoriteCard;
  final Function onDelete;
  
  MyProductCard({
    Key key,
    @required this.product, 
    // this.isFavoriteCard = false, 
    this.onDelete,
  });

  @override
  _MyProductCardState createState() => _MyProductCardState();
}

class _MyProductCardState extends State<MyProductCard> {
  final productProvider = ProductsProvider();

  final favsProvider = FavoritesProvider();

  @override
  Widget build(BuildContext context) {

    final cardProduct = Card(
      elevation: 0.0,
      child: Container(
        padding: EdgeInsets.only(left:5.0),
        height: 120.0,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildProductImg(),
            SizedBox(width: kDefaultPaddin/2,),
            _buildProductText(context),
            _buildIcon(context)
          ],
        ),
      ),
    );

    return GestureDetector(
      child: 
      // (this.widget.isFavoriteCard) ? Dismissible(
      //   key: UniqueKey(),
      //   background: Container(
      //     color: Colors.redAccent, 
      //     child: Center(
      //       child: Text(
      //         'Eliminar', 
      //         style: TextStyle(color: Colors.white),
      //       )
      //     )
      //   ),
      //   onDismissed: (_) async {
      //     await favsProvider.deleteFavorite(this.widget.product.id.toString());
      //     this.widget.onDelete();
      //   },
      //   child: cardProduct
      // ) : 
      cardProduct,
      onTap: () async {
        await Navigator.pushNamed(context, 'det_product', arguments: widget.product);
        setState(() {});
      },
    );
  }

  Widget _buildProductImg() {
    return ServerImage(
      width: 100.0, 
      heigt: 100.0, 
      imageUrl: widget.product.getImg()
    ); 
  }

  Expanded _buildProductText(BuildContext context) {

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // mostrar el nombre del producto
          Text(
            widget.product.descripcion.toLowerCase(),
            style: TextStyle(
              fontSize: 14.0,
              color: kTextColor,
            ),
          ),

          SizedBox(height: 15.0),

          // mostrar el precio del producto
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '\$${widget.product.getPrice()[0]}.', style: price.copyWith(fontSize: 20.0)),
                TextSpan(text: '${widget.product.getPrice()[1]}',style: price.copyWith(fontSize: 15.0)),
              ]
            )
          ),

          SizedBox(height: 8.0),

          Text(
            'Disponibilidad: ${widget.product.stock}',
            style: TextStyle(
              fontSize: 12.0,
              color: kTextGreenColor
            ),
          ),
        ],
      ),
    );
  }

  Column _buildIcon(BuildContext context) {
    return Column(
      children: <Widget>[
        FavoriteButton(
          product: widget.product
        )
      ],
    );
  }
}
