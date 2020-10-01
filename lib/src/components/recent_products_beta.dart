import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/components/server_image.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';

class RecentProductBeta extends StatelessWidget {

  final List<Product> productos;

  RecentProductBeta({
    Key key, 
    @required this.productos
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 260.0,
      child: _buildProducts(context, this.productos)
    );
  }

  Widget _buildProducts(BuildContext context, List<Product> products) {

    return ListView(

      padding: EdgeInsets.only(left: 20.0),
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),

      children: products.map((product) => GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: <BoxShadow> [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5.0,
                offset: Offset(0.0, 2.0),
                spreadRadius: 1.0,
              ),
            ]
          ),
          width: 220.0,
          margin: EdgeInsets.only(right: 10.0, bottom: 10.0, top: 10.0, left: 15.0),
          child: Card(
            elevation: 0.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(product.descripcion, overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 5.0,),
                  _img(product),
                  SizedBox(height: 5.0,),
                  Text('\$${product.getPrice()[0]}.${product.getPrice()[1]}', style: priceLight)
                ],
              ),
            ),
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