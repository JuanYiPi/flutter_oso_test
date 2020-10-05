import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/components/server_image.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';

class RecentProducts extends StatelessWidget {

  final List<Product> productos;

  RecentProducts({
    Key key, 
    @required this.productos
  }) : super(key: key);

  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.5,

  );

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 250.0,
      child: _buildProducts(context, this.productos)
    );
  }

  Widget _buildProducts(BuildContext context, List<Product> products) {
    return PageView(
      physics: BouncingScrollPhysics(),
      controller: _pageController,
      pageSnapping: false,
      children: products.map((product) => 
      GestureDetector(
        child: Container(
          margin: EdgeInsets.only(right: 15.0),
          child: Column(
            children: [
              Text(product.descripcion, overflow: TextOverflow.ellipsis,),
              SizedBox(height: 5.0,),
              _img(product),
              SizedBox(height: 5.0,),
              Text('\$${product.getPrice()[0]}.${product.getPrice()[1]}', style: priceLight)
            ],
          )
        ),
        onTap: () {
          Navigator.pushNamed(context, 'det_product', arguments: product);
        },
      )
    ).toList());
  }


  Widget _img(Product product) {
    return ServerImage(
      width: double.infinity, 
      heigt: 150.0,
      imageUrl: product.getImg()
    );
  }
}