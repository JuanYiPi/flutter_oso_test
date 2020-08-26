import 'package:flutter_oso_test/src/models/product_model.dart';

class Products {

  List<Product> items = new List();

  Products();

  Products.fromJsonList(List<dynamic> jsonList) {
    

    if (jsonList == null) return;

    for (var item in jsonList) {
      
      final product = new Product.fromJsonMap(item);
      items.add(product);

    }
    
  }

}
