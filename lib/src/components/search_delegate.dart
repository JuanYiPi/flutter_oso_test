import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/providers/products_provider.dart';


class DataSearch extends SearchDelegate {

  String busqueda = '';

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
    return Center();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // crea las sugerencias que aparecen al escribir
    return Container();
  }

  


}