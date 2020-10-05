import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/components/categories_swiper.dart';
import 'package:flutter_oso_test/src/components/my_drawer.dart';
import 'package:flutter_oso_test/src/components/recent_products_beta.dart';
import 'package:flutter_oso_test/src/components/shopping_cart_button.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/providers/carts_provider.dart';
import '../components/search_delegate.dart';

import 'package:flutter_oso_test/src/models/product_model.dart';

import 'package:flutter_oso_test/src/providers/recent_products_provider.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';
import '../providers/categories_provider.dart';

class HomePage extends StatelessWidget {

  final prefs = UserPreferences();
  final catProvider = CategoriasProvider();
  final recentProductsProvider = RecentProductsProvider();
  final cartsProvider = CartsProvider();

  @override
  Widget build(BuildContext context) {

    recentProductsProvider.getRecentProducts();
    cartsProvider.getNumbOfItemOfCart();

    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      drawer: MyDrawer(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        _categorias(),
        _listaCategorias(context),
        // _productosRecientes(),
        _productosRecientesBeta(),
      ],
    );
  }

  Widget _listaCategorias(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.0,),
        Container(
          height: 40.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultRadius),
            color: kColorPrimario.withOpacity(0.2),
          ),
          child: OutlineButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefaultRadius)
            ),
            child: Text('Lista de categorías', style: TextStyle(color: kColorPrimario)),
            onPressed: (){
            Navigator.pushNamed(context, 'cat_page');
          }),
        ),
      ],
    );
  }

  Widget _productosRecientesBeta() {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Column(
        children: [
          Text('Agregados recientemente', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0,),
          StreamBuilder(
            stream: recentProductsProvider.productosRecientesStream,
            builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot){
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              final productosRecientes = snapshot.data;

              if (productosRecientes.length == 0) {
                return Center(child: Text('No hay productos recientes'));
              }

              return RecentProductBeta(productos: productosRecientes);
            },
          ),
        ],
      ),
    );
  }

  Widget _categorias() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: FutureBuilder(
        future: catProvider.getAllCategorias(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return CategoriesSwiper(
              categorias: snapshot.data
            );
          } else {
            return Container(
              height: 400.0,
              child: Center(
                child: CircularProgressIndicator()
              )
            );
          }  
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Inicio'),
      actions: <Widget>[

        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          }
        ),

        ShoppingCartButton(),
        
        IconButton(
          icon: Icon(Icons.star),
          onPressed: (prefs.idUsuario == 0) 
          ? () => Navigator.pushReplacementNamed(context, 'login') 
          : () => Navigator.pushNamed(context, 'favorites'),
        ),
        
      ],
    );
  }
}

