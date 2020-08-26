import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/components/cart_counter.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';

class DetProductPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Product product = ModalRoute.of(context).settings.arguments;
    final screenSize = MediaQuery.of(context).size;

    product.cantidadCompra = 1;
  

    return Scaffold(
      appBar: _buildAppBarDet(),
      body: _buildBodyDet(context, product, screenSize),
    );
  }

  AppBar _buildAppBarDet() {
    return AppBar(
      title: Text('Producto', style: encabezado,),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.favorite_border), 
          onPressed: () {}
        ),

        IconButton(
          icon: Icon(Icons.search), 
          onPressed: () {}
        ),

        IconButton(
          icon: Icon(Icons.shopping_cart), 
          onPressed: () {}
        ),
      ],
    );
  }

  _buildBodyDet(BuildContext context, Product product, Size screenSize) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: screenSize.height,
            child: _buildProductTitleImgPrice(context, screenSize, product),
          )
        ],
      ),
    );
  }

  _buildProductTitleImgPrice(BuildContext context, Size screenSize, Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: kDefaultPaddin,),
          _productDescription(product),
          _productID(product),
          SizedBox(height: kDefaultPaddin,),
          _productImg(screenSize, product),
          SizedBox(height: kDefaultPaddin,),
          _productPrice(product),
          SizedBox(height: kDefaultPaddin * 1.5,),
          _productStock(product),
          SizedBox(height: kDefaultPaddin/2,),
          CartCounter(product: product, stock: product.stock,),
          SizedBox(height: kDefaultPaddin * 2,),
          _builPayCartButtons(context, product,),
        ],
      ),
    );
  }

  Text _productDescription(Product product) {
    return Text(
      product.descripcion.toLowerCase(),
      style: TextStyle(color: kTextColor, fontWeight: FontWeight.w500, fontSize: 20.0),
    );
  }

  Text _productID(Product product) {
    return Text(
      'ID ${product.id.toString()}',
      style: TextStyle(color: kTextLightColor),
    );
  }

  ClipRRect _productImg(Size screenSize, Product product) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      clipBehavior: Clip.antiAlias,
      child: FadeInImage(
        width: screenSize.width * 0.9,
        height: screenSize.width * 0.9,
        fit: BoxFit.cover,
        placeholder: AssetImage('assets\img\loading.gif'), 
        image: NetworkImage(product.getImg()),
      ),
    );
  }

  RichText _productPrice(Product product) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: '\$${product.precio} MXN\n', style: price),
          TextSpan(text: 'IVA Incluido', style: textoLightColor),
        ]
      )
    );
  }

  RichText _productStock(Product product) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: 'Stock disponible: ', style: textoLight),
          TextSpan(text: '${product.stock}', style: textoLightColor),
        ]
      )
    );
  }

  _builPayCartButtons(BuildContext context, Product product) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          _buildFlatButton(
            texto: 'Comprar ahora',
            btnColor: Theme.of(context).primaryColor,
            txtColor: Colors.white,
            press: () {
              // Navigator.pushNamed(context, 'pay', arguments: product);
            }
          ),

          SizedBox(height: kDefaultPaddin/2),

          _buildFlatButton(
            texto: 'Agregar al carrito',
            btnColor: Colors.white,
            txtColor: Theme.of(context).primaryColor,
            press: () {}
          ),
        ],
      ),
    );
  }

  Widget _buildFlatButton({String texto, Color btnColor, Color txtColor, Function press}) {
    return SizedBox(
      height: 45.0,
      width: double.infinity,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: btnColor,
        ),
        child: OutlineButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          onPressed: press, 
          child: Text(texto, style: TextStyle(color: txtColor, fontSize: 18.0, fontWeight: FontWeight.w400),),
        ),
      ),
    );
  }
}