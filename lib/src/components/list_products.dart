import 'package:flutter/material.dart';
import 'package:flutter_oso_test/src/components/my_product_card.dart';
// import 'package:flutter_oso_test/src/components/server_image.dart';
import 'package:flutter_oso_test/src/components/shopping_cart_button.dart';
import 'package:flutter_oso_test/src/models/categories_model.dart';
import 'package:flutter_oso_test/src/providers/products_provider.dart';

import 'package:flutter_oso_test/src/components/search_delegate.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';


class MyCustomScrollView extends StatelessWidget {

  final List<Product> products;
  final Categoria categoria;
  final Function nextPage;

  MyCustomScrollView({
    Key key, 
    @required this.products, 
    @required this.nextPage, 
    @required this.categoria,
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
      physics: BouncingScrollPhysics(),
      controller: _scrollController,
      slivers: [
        _mySliverAppBar(context, categoria),
        SliverList(
          delegate: SliverChildListDelegate(
            List.generate(products.length, (index) => _myProductCard(context, products[index]))
          )
        ),
      ],
    );
  }

  _mySliverAppBar(BuildContext context, Categoria categoria) {
    return SliverAppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: ()=> Navigator.pop(context)
      ),
      floating: true,
      pinned: true,
      snap: false,
      // expandedHeight: MediaQuery.of(context).size.width * 0.65,
      // flexibleSpace: FlexibleSpaceBar(
      //   // centerTitle: true,
      //   title: Text(
      //     categoria.descripcion,
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   // background: ServerImage(
      //   //   width: double.infinity, 
      //   //   heigt: double.infinity, 
      //   //   imageUrl: categoria.getImg(),
      //   //   borderRadius: 0.0,
      //   // )
      // ),
      title: Text(categoria.descripcion),
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

        ShoppingCartButton(),
        
      ],
    );
  }

  _myProductCard(BuildContext context, Product product) {

    return MyProductCard(product: product);

  }
}



