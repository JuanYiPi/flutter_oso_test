import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/components/server_image.dart';

import 'package:flutter_oso_test/src/models/categories_model.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class CategoriesSwiper extends StatelessWidget {

  final List<Categoria> categorias;
  final prefs = new UserPreferences();

  CategoriesSwiper({Key key, this.categorias}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.width * 0.8,
      width: double.infinity,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return _crearCategoria(context, categorias[index]);
        },
        itemCount: categorias.length,
        autoplay: true,
        autoplayDelay: 5000,
        control: new SwiperControl(),
        viewportFraction: 0.8,
        scale: 0.8,
      ),
    ); 
  }

  Widget _crearCategoria(BuildContext context ,Categoria categoria) {

    final queryData = MediaQuery.of(context);

    final caratulaCategoria = Container(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: <BoxShadow> [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5.0,
            offset: Offset(0.0, 0.0),
            spreadRadius: 3.0,
          ),
        ]
      ),
      child: ServerImage(
        heigt: double.infinity,
        width: double.infinity,
        imageUrl: categoria.getImg(),
        errorImagePath: 'assets/img/white.jpg',
      ),
    );

    final categoryName = Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.grey[700].withOpacity(0.5),
        ),
        padding: EdgeInsets.all(5.0),
        child: Text(
          categoria.descripcion, 
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold,
            fontSize: queryData.devicePixelRatio <= 1.75?
              30.0 : 35.0
          ) 
        ),
      )
    );

    final card = Stack(
      children: [
        caratulaCategoria,
        categoryName
      ],
    );

    return GestureDetector(
      child: card,
      onTap: () {
        prefs.idCategoria = categoria.id;
        Navigator.pushNamed(context, 'products_by_cat', arguments: categoria.descripcion);
      },
    );
  }
}