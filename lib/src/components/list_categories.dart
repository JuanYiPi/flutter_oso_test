import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/categories_model.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';

class ListAllCategories extends StatelessWidget {

  final List<Categoria> categorias;

  ListAllCategories({@required this.categorias});

  final prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      itemBuilder: (context, index) {
        return _catIndividual(context, categorias[index]);
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: categorias.length,
      // children: _createListCategorias(context, categorias),
    );
    
  }

  // List<Widget> _createListCategorias(BuildContext context, List<Categoria> categorias) {

  //   final List<Widget> allCategorias = [];

  //   categorias.forEach((categoria) { 

  //     final tempWidget = _catIndividual(context, categoria);

  //     allCategorias.add(tempWidget);
  //     allCategorias.add(Divider());

  //   });

  //   return allCategorias;

  // }

  Widget _catIndividual(BuildContext context, Categoria categoria) {

    final tarjeta = ListTile(
      title: Text(categoria.descripcion, style: cardProductText,),
      trailing: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).primaryColor,),
      onTap: () {
        prefs.idCategoria = categoria.id;
        Navigator.pushNamed(context, 'products_by_cat', arguments: categoria);
      },
    );

    return tarjeta;

  }
}