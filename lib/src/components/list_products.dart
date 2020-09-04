import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/providers/products_provider.dart';

import 'package:flutter_oso_test/src/components/search_delegate.dart';
import 'package:flutter_oso_test/src/constants/constants.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';


class MyCustomScrollView extends StatelessWidget {

  final List<Product> products;
  final String title;
  final Function nextPage;

  MyCustomScrollView({
    Key key, @required this.products, @required this.title, @required this.nextPage,
  }) : super(key: key);

  final ScrollController _scrollController = new ScrollController();
  final productsProvider = new ProductsProvider();

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
        _mySliverAppBar(context, title),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _myProductCard(context, products[index], _screenSize),
            childCount: products.length,
          ),
        ),
      ],
    );
  }

  _mySliverAppBar(BuildContext context, String title) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      snap: false,
      title: Text(title),
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
          onPressed: () {
            Navigator.pushNamed(context, 'shopping_cart');
          },
        ),
      ],
    );
  }

  _myProductCard(BuildContext context, Product product, Size screenSize) {
    
    final cardProduct = Card(
      elevation: 0.0,
      child: Container(
        padding: EdgeInsets.only(left:5.0),
        height: 120.0,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildProductImg(product),
            SizedBox(width: kDefaultPaddin/2,),
            _buildProductText(context,screenSize, product),
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

  Widget _buildProductText(BuildContext context, Size screenSize, Product product) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
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
            style: Theme.of(context).textTheme.headline6.copyWith(color: kTextColor)
          ),

          SizedBox(height: 8.0),

          Text(
            'Disponibilidad: ${product.stock}',
            style: TextStyle(
              fontSize: 11.0,
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
        future: productsProvider.checkUrl(product.getImg()),
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
}



