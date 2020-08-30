import 'package:flutter_oso_test/src/models/cart_detail_model.dart';

class CartDetailList {

  List<CartDetail> items = new List();

  CartDetailList();

  CartDetailList.fromJsonList(List<dynamic> jsonList) {

    if (jsonList == null) return;

    for (var item in jsonList) {
      final cartDetail = new CartDetail.fromJsonMap(item);
      items.add(cartDetail);
    }
  }  
}