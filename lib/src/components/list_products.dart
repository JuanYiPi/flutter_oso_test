import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_oso_test/src/components/search_delegate.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/categories_model.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';


class MyCustomScrollView extends StatelessWidget {

  final List<Product> products;
  final Categoria categoria;
  final Function nextPage;

  MyCustomScrollView({
    Key key, @required this.products, @required this.categoria, @required this.nextPage,
  }) : super(key: key);

  final ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        _mySliverAppBar(context, categoria),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _myProductCard(context, products[index], _screenSize),
            childCount: products.length,
          ),
        ),
      ],
    );
  }

  _mySliverAppBar(BuildContext context ,Categoria categoria) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      snap: false,
      title: Text(categoria.descripcion, style: encabezado,),
      actions: [
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

  _myProductCard(BuildContext context, Product product, Size screenSize) {
    
    final cardProduct = Card(
      elevation: 0.0,
      child: Container(
        height: 120.0,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            SizedBox(width: kDefaultPaddin/2,),

            _buildProductImg(product),

            SizedBox(width: kDefaultPaddin/2,),

            _buildProductText(screenSize, product),

            _buildFavoriteIcon(context),
          ],
        ),
      ),
    );

    return GestureDetector(
      child: cardProduct,
      onTap: () {
        Navigator.pushNamed(context, 'det_product', arguments: product);
      },
    );
  }

  Column _buildFavoriteIcon(BuildContext context) {
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.favorite_border, size: 16.0, color: Theme.of(context).primaryColor,), 
          onPressed: () {}
        ),
      ],
    );
  }

  Container _buildProductText(Size screenSize, Product product) {
    return Container(
      width: screenSize.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // mostrar el nombre del producto
          Text(
            product.descripcion.toLowerCase(),
            style: TextStyle(
              fontSize: 14.0,
              color: kTextColor,
            ),
          ),

          SizedBox(height: 15.0),

          // mostrar el precio del producto
          Text(
            '\$${product.precio}',
            style: priceLight,
          ),

          SizedBox(height: 8.0),

          Text(
            'Disponibilidad: ${product.stock}',
            style: TextStyle(
              fontSize: 12.0,
              // fontStyle: FontStyle.italic,
              color: kTextGreenColor
            ),
          ),

        ],
      ),
    );
  }

  ClipRRect _buildProductImg(Product product) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(10.0),
      child: FutureBuilder(
        future: _checkUrl(product.getImg()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != 200) {
              return Container(
                child: Image(image: AssetImage('assets/img/no_disponible.jpg')),
                height: 100.0,
                width: 100.0,
              );
            }
            return Container(
              height: 100.0,
              width: 100.0,
              child: FadeInImage(
                placeholder: AssetImage('assets/img/loading.gif'), 
                image: NetworkImage(product.getImg()),
                fit: BoxFit.cover,
              ),
            );
          } else {
            return Container(
              height: 100.0,
              width: 100.0,
              child: Image(
                image: AssetImage('assets/img/loading.gif'), 
                fit: BoxFit.cover,
              ),
            );
          }
        },
      ),
    );
  }

  Future<int> _checkUrl(String url) async {
    try {
      final response = await http.get(url);
      print(response.statusCode);
      return response.statusCode;
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}



