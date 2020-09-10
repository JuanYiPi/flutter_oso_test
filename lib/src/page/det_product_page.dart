import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/providers/products_provider.dart';

import 'package:flutter_oso_test/src/components/cart_counter.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';
import 'package:flutter_oso_test/src/providers/carts_provider.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';

class DetProductPage extends StatefulWidget {

  @override
  _DetProductPageState createState() => _DetProductPageState();
}

class _DetProductPageState extends State<DetProductPage> {

  final cartsProvider = new CartsProvider();
  final productsProvider = new ProductsProvider();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final prefs = UserPreferences();

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
    return prefs.idUsuario !=0? AppBar(
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
    ) : AppBar(
      title: Text('Producto'),
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
      child: FadeInImage(
        imageErrorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
          print('Error Handler');
          return Container(
            width: screenSize.width * 0.9,
            height: screenSize.width * 0.9,
            child: Image.asset('assets/img/no_disponible.jpg'),
          );
        },
        placeholder: AssetImage('assets/img/loading.gif'), 
        image: product.getImg() != null? 
          NetworkImage(product.getImg()) : AssetImage('assets/img/no_disponible'),
        fit: BoxFit.cover,
        height: screenSize.width * 0.9,
        width: screenSize.width * 0.9,
      ), 
    );
  }

  RichText _productPrice(Product product) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: '\$${product.getPrice()[0]}.', style: price),
          TextSpan(text: '${product.getPrice()[1]} MXN\n',style: price.copyWith(fontSize: 20.0)),
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

  Widget _builPayCartButtons(BuildContext context, Product product) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: prefs.idUsuario != 0? Column(
            children: <Widget>[

              _buildFlatButton(
                texto: 'Comprar ahora',
                btnColor: kColorPrimario,
                txtColor: Colors.white,
                press: !_isLoading? () {
                  _addProductAndPay(product);
                } : null
              ),

              SizedBox(height: kDefaultPaddin/2),

              _buildFlatButton(
                texto: 'Agregar al carrito',
                btnColor: kColorPrimario,
                txtColor: Colors.white,
                press: !_isLoading? () {
                  _addToShoppingCart(context, product);
                } : null
              ),
            ],
          ) : Container(
            height: 45.0,
            child: RaisedButton(
              color: kColorPrimario,
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => false);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kDefaultRadius)
              ),
              child: Text('Inicia sesión para comprar', style: TextStyle(color: Colors.white),),
            ),
          )
        ),
        _loadingIndicator()
      ],
    );
    
  }

  Widget _buildFlatButton({String texto, Color btnColor, Color txtColor, Function press}) {
    return SizedBox(
      height: 45.0,
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        // elevation: 3.0,
        onPressed: press,
        color: btnColor,
        child: Text(texto, style: TextStyle(color: txtColor)),
      )
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
      _mostrarSnackbar('Agregado al carrito exitosamente!', Colors.green);
      print('Agregado exitosamente');
    } else {
      _mostrarSnackbar('No se pudo agregar al carrito :(', Colors.red);
      print('error al agregar');
    }
  }

  void _mostrarSnackbar(String text, Color color) {
    final snackbar = SnackBar(
      backgroundColor: color,
      content: Text(text),
      duration: Duration(milliseconds: 2000),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void _addProductAndPay(Product product) async {
    setState(() {
      _isLoading = true;
    });

    final response = await cartsProvider.addToShoppingCart(product);

    setState(() {
      _isLoading = false;
    });

    if (response == true) {
      Navigator.pushNamed(context, 'shopping_cart');
      print('Agregado exitosamente');
    } else {
      _mostrarSnackbar('No se pudo agregar al carrito :(', Colors.red);
      print('error al agregar');
    }
  }
}