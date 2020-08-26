import 'package:flutter/material.dart';

import 'package:flutter_oso_test/src/components/list_categories.dart';
import 'package:flutter_oso_test/src/components/my_drawer.dart';
import 'package:flutter_oso_test/src/components/search_delegate.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/providers/categories_provider.dart';


class CategoriesPage extends StatefulWidget {

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final categoriesProvider = CategoriasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildAllCategories(),
      // drawer: MyDrawer(),
    );
  }

  Widget _buildAllCategories() {
    return Container(
      child: FutureBuilder(
        future: categoriesProvider.getAllCategorias(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            
            return ListAllCategories(
              categorias: snapshot.data,
            );

          } else {
              return Container(
              height: 400.0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Categorias',
        style: encabezado,
      ),
      leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: ()=> Navigator.pop(context)),
      actions: <Widget>[

        IconButton(
          icon: Icon(Icons.search), 
          onPressed: () {
            showSearch(
              context: context, 
              delegate: DataSearch(),
            );
          }
        ),

        IconButton(
          icon: Icon(Icons.shopping_cart), 
          onPressed: () {},
        ),

      ],
    );
  }
}