import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/components/my_product_card.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';
import 'package:flutter_oso_test/src/providers/products_provider.dart';


class DataSearch extends SearchDelegate {

  @override
  String get searchFieldLabel => "Buscar productos";

  String busqueda = '';
  List<Product> results = new List();

  final productsProvider = new ProductsProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones del appBar
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: () {
          query = '';
        }
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono izquierdo del search
    return IconButton(
      icon: Icon(Icons.arrow_back), 
      onPressed: () {
        close(context, null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultados que vamos a mostrar
    if (results.length != 0) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return MyProductCard(product: results[index]); 
        },
        itemCount: results.length,
      );
    } else {
      return Center(child: Text('Sin resultados :('),);
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // crea las sugerencias que aparecen al escribir
    if (query.isEmpty) return Container();

    return 
    FutureBuilder(
      future: productsProvider.searchProduct(query),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.hasData) {

          results = snapshot.data;

          return ListView(
            children: results.map((product) {
              return ListTile(
                leading: Icon(Icons.search),
                title: Text(product.descripcion.toLowerCase(),),
                trailing: Transform.rotate(
                    angle: -pi/4.0,
                    child: IconButton(
                      icon: Icon(Icons.arrow_upward), 
                      onPressed: () => query = product.descripcion.toLowerCase()
                  ),
                ),
                onTap: () {
                  // close(context, null);
                  query = product.descripcion.toLowerCase();
                  // buildResults(context);
                  // Navigator.pushNamed(context, 'det_product', arguments: product);
                },
              );
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}