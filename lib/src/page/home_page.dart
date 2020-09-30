import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/components/categories_swiper.dart';
import 'package:flutter_oso_test/src/components/my_drawer.dart';
import 'package:flutter_oso_test/src/components/recent_products.dart';
import 'package:flutter_oso_test/src/components/shopping_cart_button.dart';
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
        _productosRecientes(),
      ],
    );
  }

  Widget _listaCategorias(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: FlatButton(
          child: Text('Lista de categorías'),
          onPressed: (){
          Navigator.pushNamed(context, 'cat_page');
        }),
    );
  }

  Widget _productosRecientes() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
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

                return RecentProducts(productos: productosRecientes);
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
          onPressed: () => Navigator.pushNamed(context, 'favorites'),
        ),
        
      ],
    );
  }
}

