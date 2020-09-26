import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/components/categories_swiper.dart';

import 'package:flutter_oso_test/src/components/my_drawer.dart';
import 'package:flutter_oso_test/src/components/recent_products.dart';
import 'package:flutter_oso_test/src/models/categories_model.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';
import 'package:flutter_oso_test/src/providers/products_provider.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';

import '../components/search_delegate.dart';
import '../constants/constants.dart';
import '../providers/categories_provider.dart';

class HomePage extends StatelessWidget {

  final prefs = new UserPreferences();
  final catProvider = new CategoriasProvider();
  final productsProvider = new ProductsProvider();

  @override
  Widget build(BuildContext context) {
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
        SizedBox(height: kDefaultPaddin,),
        _categorias(),
        SizedBox(height: kDefaultPaddin,),
        FlatButton(
          child: Text('Lista de categorías'),
          onPressed: (){
          Navigator.pushNamed(context, 'cat_page');
        }),
        SizedBox(height: kDefaultPaddin,),
        Column(
          children: [
            Text('Agregados recientemente', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0,),
            FutureBuilder(
              future: productsProvider.getRecentProducts(),
              builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
                if (snapshot.hasData) {
                  return RecentProducts(productos: snapshot.data);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  FutureBuilder<List<Categoria>> _categorias() {
    return FutureBuilder(
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
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: (){
            if (prefs.idUsuario != 0) {
              Navigator.pushNamed(context, 'shopping_cart');
            } else {
              Navigator.pushNamed(context, 'login');
            }
          }       
        ),
        // SizedBox(width: 10.0),
        IconButton(
          icon: Icon(Icons.star),
          onPressed: () => Navigator.pushNamed(context, 'favorites'),
        ),
        SizedBox(width: 10.0),
      ],
    );
  }
}