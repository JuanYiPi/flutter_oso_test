import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/components/categories_swiper.dart';

import 'package:flutter_oso_test/src/components/my_drawer.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';

import '../components/search_delegate.dart';
import '../constants/constants.dart';
import '../providers/categories_provider.dart';

class HomePage extends StatelessWidget {

  final prefs = new UserPreferences();
  final catProvider = new CategoriasProvider();

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
      children: [
        SizedBox(height: kDefaultPaddin,),
        FutureBuilder(
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
        SizedBox(height: kDefaultPaddin,),
        FlatButton(
          child: Text('Lista de categorías'),
          onPressed: (){
          Navigator.pushNamed(context, 'cat_page');
        })
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Osoonline'),
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
        SizedBox(width: 10.0),
        Icon(Icons.favorite),
        SizedBox(width: 10.0),
      ],
    );
  }
}