import 'package:flutter_oso_test/src/models/cart_model.dart';

class Carts {

  List<Cart> items = new List();

  Carts();

  Carts.fromJsonList(List<dynamic> jsonList) {

    if( jsonList == null ) return;

    for(var item in jsonList){

      final cart = new Cart.fromJsonMap(item);
      items.add(cart);
    }
  }
}