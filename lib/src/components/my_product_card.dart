import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/components/favorite_button.dart';
import 'package:flutter_oso_test/src/components/server_image.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';
import 'package:flutter_oso_test/src/providers/favorites_provider.dart';
import 'package:flutter_oso_test/src/providers/products_provider.dart';

class MyProductCard extends StatelessWidget {
  
  MyProductCard({
    Key key,
    @required this.product,
  });

  final Product product;
  final productProvider = ProductsProvider();
  final favProvider = FavoritesProvider();

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
            _buildLoveIcon(context)
          ],
        ),
      ),
    );

    return GestureDetector(
      child: cardProduct,
      onTap: () {
        Navigator.pushNamed(context, 'det_product', arguments: product);
      },
    );

  }

  Widget _buildProductImg() {
    return ServerImage(
      width: 100.0, 
      heigt: 100.0, 
      imageUrl: product.getImg()
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
            product.descripcion.toLowerCase(),
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
                TextSpan(text: '\$${product.getPrice()[0]}.', style: price.copyWith(fontSize: 20.0)),
                TextSpan(text: '${product.getPrice()[1]}',style: price.copyWith(fontSize: 15.0)),
              ]
            )
          ),

          SizedBox(height: 8.0),

          Text(
            'Disponibilidad: ${product.stock}',
            style: TextStyle(
              fontSize: 12.0,
              color: kTextGreenColor
            ),
          ),
        ],
      ),
    );
  }

  Column _buildLoveIcon(BuildContext context) {
    return Column(
      children: <Widget>[

        FavoriteButton(product: product),

      ],
    );
  }
}