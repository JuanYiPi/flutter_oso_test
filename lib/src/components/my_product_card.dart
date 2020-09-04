import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';
import 'package:flutter_oso_test/src/providers/products_provider.dart';

class MyProductCard extends StatelessWidget {
  
  MyProductCard({
    Key key,
    @required this.product,
  });

  final Product product;
  final productProvider = new ProductsProvider();

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
            _buildLoveIcon(),
          ],
        ),
      ),
    );

    return GestureDetector(
      child: cardProduct,
      onTap: () {
        Navigator.pushNamed(context, 'detProduct', arguments: product);
      },
    );

  }

  ClipRRect _buildProductImg() {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(10.0),
      child: FutureBuilder(
        future: productProvider.checkUrl(product.getImg()),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != 200) {
              return Container(
                child: Image(image: AssetImage('assets/img/no_disponible.jpg')),
                height: 100.0,
                width: 100.0,
              );
            }
            return Container(
              height: 100.0,
              width: 100.0,
              child: FadeInImage(
                placeholder: AssetImage('assets/img/loading.gif'), 
                image: NetworkImage(product.getImg()),
                fit: BoxFit.cover,
              ),
            );
          } else {
            return Container(
              height: 100.0,
              width: 100.0,
              child: Image(
                image: AssetImage('assets/img/loading.gif'), 
                fit: BoxFit.cover,
              ),
            );
          }
        },
      ),
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
          Text(
            '\$${product.precio}',
            style: Theme.of(context).textTheme.headline6.copyWith(color: kTextColor)
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

  Column _buildLoveIcon() {
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.favorite_border, size: 16.0, color: Colors.deepPurple,), 
          onPressed: () {}
        ),
      ],
    );
  }
}