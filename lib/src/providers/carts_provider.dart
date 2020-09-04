import 'dart:async';
import 'dart:convert';
import 'package:flutter_oso_test/src/models/cart_detail_list_model.dart';
import 'package:flutter_oso_test/src/models/cart_detail_model.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_oso_test/src/providers/user_preferences.dart';
import 'package:flutter_oso_test/src/models/carts_model.dart';
import 'package:flutter_oso_test/src/models/cart_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CartsProvider {

  String authority = DotEnv().env['OSO_BASE_URL'];
  String apiKey    = DotEnv().env['OSO_API_KEY'];

  final prefs      = new UserPreferences();
  
  static Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  // STREAM 
  List<CartDetail> _shoppingCart = new List();
  final _shoppingCartStreamController = StreamController<List<CartDetail>>.broadcast();
  Function(List<CartDetail>) get shoppingCartSink => _shoppingCartStreamController.sink.add;
  Stream<List<CartDetail>> get shoppingCartStream => _shoppingCartStreamController.stream;

  void disposeStreams() {
    _shoppingCartStreamController?.close();
  }
  //STREAM

  Future<List<Cart>> getPurchasesById() async {

    final url = Uri.http(authority, 'api/users/${prefs.id}/carts', {
      'api_key'               : apiKey,
    });
    try {
      final resp = await http.get(url);
      final decodedData = json.decode(resp.body);
      final purchasesById = new Carts.fromJsonList(decodedData['data']);
      return purchasesById.items;
    } catch (err) {
      print(err.toString());
    }
    return null;
  }

  Future<List<CartDetail>> getShoppingCart() async {
    
    final url = Uri.http(authority, 'api/carts/37/details',{
      'api_key': apiKey
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        final decodedData = json.decode(response.body);
        final shoppingList = CartDetailList.fromJsonList(decodedData['data']);

        _shoppingCart.addAll(shoppingList.items);   //STREAM
        shoppingCartSink(_shoppingCart);            //STREAM

        return shoppingList.items;
      } catch (err) {
        print(err.toString());
      }
    }
    return null;
  }

  Future<bool> addToShoppingCart(Product producto) async {
    final url = Uri.http(authority, 'api/cartdetail');

    final response = await http.post(
      url, 
      body: {
        'api_key'         : apiKey,
        'cart_id'         : '37',
        'product_id'      : producto.id.toString(),
        'IdProductoCodigo': producto.idProductoCodigo.toString(),
        'IdProductoDesc'  : producto.idProductoDesc.toString(),
        'IdProductoPres'  : producto.idProductoPres.toString(),
        'Cantidad'        : producto.cantidadCompra.toString(),
        'Precio'          : producto.precio.toString()
      }
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteFromShoppingCart(CartDetail item) async {
    final url = Uri.http(authority, 'api/cartdetail/${item.id}', {'api_key': apiKey});

    final response = await http.delete(url);
    if (response.statusCode == 200) {
      _shoppingCart = []; // STREAM
      getShoppingCart();  // STREAM
      return true;
    } else {
      return false;
    }
  }  
}