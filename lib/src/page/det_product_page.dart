import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/components/cart_counter_beta.dart';
import 'package:flutter_oso_test/src/components/comment_box.dart';
import 'package:flutter_oso_test/src/components/favorite_button.dart';
import 'package:flutter_oso_test/src/components/my_drawer.dart';
import 'package:flutter_oso_test/src/components/question_box.dart';
import 'package:flutter_oso_test/src/components/search_delegate.dart';
import 'package:flutter_oso_test/src/components/server_image.dart';
import 'package:flutter_oso_test/src/components/shopping_cart_button.dart';
import 'package:flutter_oso_test/src/models/comment_list.dart';

import 'package:flutter_oso_test/src/providers/favorites_provider.dart';
import 'package:flutter_oso_test/src/providers/products_provider.dart';
import 'package:flutter_oso_test/src/providers/carts_provider.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';

import 'package:flutter_oso_test/src/constants/constants.dart';

import 'package:flutter_oso_test/src/models/product_model.dart';

class DetProductPage extends StatefulWidget {

  @override
  _DetProductPageState createState() => _DetProductPageState();
}

class _DetProductPageState extends State<DetProductPage> {

  final cartsProvider = CartsProvider();
  // final productsProvider = ProductsProvider();
  final favProvider = FavoritesProvider();
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
      drawer: MyDrawer(),
      key: scaffoldKey,
      appBar: _buildAppBarDet(context, product),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
      return Container(
        margin: EdgeInsets.only(top: 40.0),
        height: 60.0,
        child: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Container();
    }
  }

  AppBar _buildAppBarDet(BuildContext context, Product product) {
    return (prefs.idUsuario != 0) ? AppBar(
      title: Text('Producto'),
      leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: ()=> Navigator.pop(context)
      ),

      actions: <Widget>[

        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          }
        ),

        ShoppingCartButton(),

        FavoriteButton(product: product, littleSize: false,),

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
          _productDescription(product),
          _productID(product),
          _productImg(screenSize, product),
          _productPrice(product),
          _productStock(product),
          _productCuantity(product),
          _loadingIndicator(),
          _builPayCartButtons(context, product,),
          _questionsBox(),
          _commentBox(product.idProductoCodigo.toString()),
        ],
      ),
    );
  }

  Container _productCuantity(Product product) {
    return Container(
      width: double.infinity,
      height: 45.0,
      margin: EdgeInsets.only(top: 10.0),
      child: CartCounterBeta(stock: product.stock, product: product) 
      // CartCounter(product: product, stock: product.stock,)
    );
  }

  Widget _productDescription(Product product) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Text(
        product.descripcion.toLowerCase(),
        style: TextStyle(color: kTextColor, fontWeight: FontWeight.w500, fontSize: 20.0),
      ),
    );
  }

  Text _productID(Product product) {
    return Text(
      'ID ${product.idProductoCodigo.toString()}',
      style: TextStyle(color: kTextLightColor, ),
    );
  }

  Widget _productImg(Size screenSize, Product product) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 20.0),
        child: ServerImage(
          width: screenSize.width * 0.9, 
          heigt: screenSize.width * 0.9, 
          imageUrl: product.getFullImg()
        ),
      ),
      onTap: () => Navigator.pushNamed(context, 'zoom', arguments: product),
    );
  }

  Widget _productPrice(Product product) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: '\$${product.getPrice()[0]}.', style: price),
            TextSpan(text: '${product.getPrice()[1]} MXN\n',style: price.copyWith(fontSize: 20.0)),
            TextSpan(text: 'IVA Incluido', style: textoLightColor),
          ]
        )
      ),
    );
  }

  Widget _productStock(Product product) {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: 'Stock disponible: ', style: textoLight),
            TextSpan(text: '${product.stock}', style: textoLightColor),
          ]
        )
      ),
    );
  }

  Widget _builPayCartButtons(BuildContext context, Product product) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40.0),
      child: Container(
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
              btnColor: kColorPrimario.withOpacity(0.2),
              txtColor: kColorPrimario,
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
    );
  }

  Widget _buildFlatButton({String texto, Color btnColor, Color txtColor, Function press}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultRadius),
        color: btnColor,
      ),
      height: 45.0,
      width: double.infinity,
      child: OutlineButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultRadius)
        ),
        onPressed: press,
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

  Widget _questionsBox() {
    return QuestionBox();
  }

  Widget _commentBox(String productId) {

    final productsProvider = ProductsProvider();

    return FutureBuilder(
      future: productsProvider.getComments(productId),
      builder: (BuildContext context, AsyncSnapshot<List<Comment>> snapshot) {

        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }

        if (snapshot.data.length == 0) {
          return CommentBox(comments: snapshot.data);
        }

        return CommentBox(comments: snapshot.data);

      },
    );
  }
}