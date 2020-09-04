import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_oso_test/src/components/cart_counter.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';
import 'package:flutter_oso_test/src/providers/carts_provider.dart';

class DetProductPage extends StatefulWidget {

  @override
  _DetProductPageState createState() => _DetProductPageState();
}

class _DetProductPageState extends State<DetProductPage> {

  final cartsProvider = new CartsProvider();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLoading;

  @override
  void initState() { 
    super.initState();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {

    final Product product = ModalRoute.of(context).settings.arguments;
    final screenSize = MediaQuery.of(context).size;

    product.cantidadCompra = 1;
  
    return Scaffold(
      key: scaffoldKey,
      appBar: _buildAppBarDet(context),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            _buildProductTitleImgPrice(context, screenSize, product),
          ],
        ),
      )
    );
  }

  Widget _loadingIndicator() {
    if (_isLoading == true) {
      return Center(child: CircularProgressIndicator(),);
    } else {
      return Container();
    }
  }

  AppBar _buildAppBarDet(BuildContext context) {
    return AppBar(
      title: Text('Producto'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.favorite_border), 
          onPressed: () {}
        ),

        IconButton(
          icon: Icon(Icons.shopping_cart), 
          onPressed: () {
            Navigator.pushNamed(context, 'shopping_cart');
          }
        ),
      ],
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
          SizedBox(height: kDefaultPaddin * 2,)
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
      'ID ${product.idProductoCodigo.toString()}',
      style: TextStyle(color: kTextLightColor, ),
    );
  }

  ClipRRect _productImg(Size screenSize, Product product) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(10.0),
      child: FutureBuilder(
        future: _checkUrl(product.getImg()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != 200) {
              return Container(
                child: Image(image: AssetImage('assets/img/no_disponible.jpg')),
                width: screenSize.width * 0.9,
                height: screenSize.width * 0.9,
              );
            }
            return Container(
              width: screenSize.width * 0.9,
              height: screenSize.width * 0.9,
              child: FadeInImage(
                placeholder: AssetImage('assets/img/loading.gif'), 
                image: NetworkImage(product.getImg()),
                fit: BoxFit.cover,
              ),
            );
          } else {
            return Container(
              width: screenSize.width * 0.9,
              height: screenSize.width * 0.9,
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

          Stack(
            children: [
              _buildFlatButton(
                texto: 'Agregar al carrito',
                btnColor: _isLoading? Colors.grey : Colors.white,
                txtColor: _isLoading? Colors.white : Theme.of(context).primaryColor,
                press: () {
                  _addToShoppingCart(context, product);
                }
              ),
              _loadingIndicator()
            ],
          )
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

  void _addToShoppingCart(BuildContext context, Product producto) async {

    setState(() {
      _isLoading = true;
    });

    final response = await cartsProvider.addToShoppingCart(producto);

    setState(() {
      _isLoading = false;
    });

    if (response == true) {
      _mostrarSnackbar('Agregado al carrito exitosamente!');
      print('Agregado exitosamente');
    } else {
      _mostrarSnackbar('No se pudo agregar al carrito :(');
      print('error al agregar');
    }
  }

  void _mostrarSnackbar(String text) {
    final snackbar = SnackBar(
      backgroundColor: Colors.green,
      content: Text(text),
      duration: Duration(milliseconds: 2000),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Future<int> _checkUrl(String url) async {
    try {
      final response = await http.get(url);
      print(response.statusCode);
      return response.statusCode;
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}