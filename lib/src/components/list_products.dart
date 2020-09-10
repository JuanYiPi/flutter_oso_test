import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/components/my_product_card.dart';
import 'package:flutter_oso_test/src/providers/products_provider.dart';

import 'package:flutter_oso_test/src/components/search_delegate.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';


class MyCustomScrollView extends StatelessWidget {

  final List<Product> products;
  final String title;
  final Function nextPage;

  MyCustomScrollView({
    Key key, @required this.products, @required this.title, @required this.nextPage,
  }) : super(key: key);

  final ScrollController _scrollController = new ScrollController();
  final productsProvider = new ProductsProvider();
  final prefs = UserPreferences();

  @override
  Widget build(BuildContext context) {

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
          delegate: SliverChildListDelegate(
            List.generate(products.length, (index) => _myProductCard(context, products[index]))
          )
          // SliverChildBuilderDelegate(
          //   (context, index) => _myProductCard(context, products[index]),
          //   childCount: products.length,
          // ),
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

        if (prefs.idUsuario != 0) IconButton(
          icon: Icon(Icons.shopping_cart), 
          onPressed: () {
            Navigator.pushNamed(context, 'shopping_cart');
          },
        ),
      ],
    );
  }

  _myProductCard(BuildContext context, Product product) {

    return MyProductCard(product: product);

  }
}



