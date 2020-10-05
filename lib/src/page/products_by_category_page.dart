import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/components/list_products.dart';
import 'package:flutter_oso_test/src/components/my_drawer.dart';
import 'package:flutter_oso_test/src/models/categories_model.dart';
import 'package:flutter_oso_test/src/providers/products_provider.dart';


class ProductsByCategoryPage extends StatelessWidget {

  final productsProvider = new ProductsProvider();

  @override
  Widget build(BuildContext context) {

    final Categoria categoria = ModalRoute.of(context).settings.arguments;
    productsProvider.getProducts();

    return Scaffold(
      body: _buildBody(categoria),
      drawer: MyDrawer(),
    );
  }

  Container _buildBody(Categoria categoria) {
    return Container(
      child: StreamBuilder(
        stream: productsProvider.productsStream,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot){
          if (snapshot.hasData) {
            return MyCustomScrollView(
              categoria: categoria,
              products: snapshot.data, 
              // title: title, 
              nextPage: productsProvider.getProducts
            );
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}