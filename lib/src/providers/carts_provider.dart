import 'dart:async';
import 'dart:convert';
import 'package:flutter_oso_test/src/models/cart_compuesto.dart';
import 'package:flutter_oso_test/src/models/cart_detail_list_model.dart';
import 'package:flutter_oso_test/src/models/cart_detail_model.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';
import 'package:flutter_oso_test/src/providers/directions_provider.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_oso_test/src/providers/user_preferences.dart';
import 'package:flutter_oso_test/src/models/carts_model.dart';
import 'package:flutter_oso_test/src/models/cart_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CartsProvider {

  static final CartsProvider _instancia = new CartsProvider._internal();

  factory CartsProvider() {
    return _instancia;
  }

  CartsProvider._internal();

  String authority = DotEnv().env['OSO_BASE_URL'];
  String apiKey    = DotEnv().env['OSO_API_KEY'];

  final prefs      = new UserPreferences();
  final directionsProvider = DirectionsProvider();
  
  static Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  // CARTMAP STREAM
  final _shoppingCartInfoStreamController = StreamController<CartMap>.broadcast();
  Function(CartMap) get shoppingCartInfoSink => _shoppingCartInfoStreamController.sink.add;
  Stream<CartMap> get shoppingCartInfoStream => _shoppingCartInfoStreamController.stream;
  // CARTMAP STREAM

  // TOTAL ITEMS STREAM
  final _totalItemsStreamController = StreamController<int>.broadcast();
  Function(int) get itemsSink => _totalItemsStreamController.sink.add;
  Stream<int> get itemsStream => _totalItemsStreamController.stream;
  // TOTAL ITEMS STREAM

    void disposeStreams() {
    _shoppingCartInfoStreamController?.close();
    _totalItemsStreamController?.close();
  }
  //STREAM


  Future<List<Cart>> getAllPurchases() async {

    final url = Uri.https(authority, 'api/users/${prefs.idUsuario}/carts', {
      'api_key'               : apiKey,
    });

    final resp = await http.get(url);

    try {
      final decodedData = json.decode(resp.body);
      final purchases = new Carts.fromJsonList(decodedData['data']);
      return purchases.items;
    } catch (err) {
      print(err.toString());
    }
    return null;
  }

  Future<List<CartDetail>> getCartDetailList({String cartId}) async {
    final url = Uri.https(authority, 'api/carts/$cartId/details', {'api_key': apiKey});
    
    final response = await http.get(url);

    try {
      final decodedData = json.decode(response.body);
      final cartDetailList = CartDetailList.fromJsonList(decodedData['data']);
      return cartDetailList.items;
    } catch (err) {
      print(err.toString());
    }
    return null;
  }

  getNumbOfItemOfCart() async {

    final url = Uri.https(authority, 'api/users/${prefs.idUsuario}/cartdetails', {
      'api_key': apiKey
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        final decodedData = json.decode(response.body);
        print(decodedData);

        final shoppingList = CartDetailList.fromJsonList(decodedData['data']);

        itemsSink(shoppingList.items.length);       //STREAM

      } catch (err) {
        print(err.toString());
      }
    }

  }

  Future<List<CartDetail>> getShoppingCart() async {

    final url = Uri.https(authority, 'api/users/${prefs.idUsuario}/cartdetails', {
      'api_key': apiKey
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        final decodedData = json.decode(response.body);
        print(decodedData);

        final shoppingList = CartDetailList.fromJsonList(decodedData['data']);
        final cartInfo = Cart.fromJsonMap(decodedData['total']);

        final cartCompuesto = new CartMap(
          data: shoppingList.items,
          total: cartInfo,
        );

        shoppingCartInfoSink(cartCompuesto);        //STREAM

        return shoppingList.items;
      } catch (err) {
        print(err.toString());
      }
    }
    return null;
  }

  Future<Cart> getActiveCart() async {
    final url = Uri.https(authority, 'api/users/${prefs.idUsuario}/cartactive', {
      'api_key': apiKey
    });

    final response = await http.get(url);
    if(response.statusCode == 200) {
      try {
        final decodedData = json.decode(response.body);
        final cart = new Cart.fromJsonMap(decodedData['data']);
        return cart;
      } catch (err) {
        print(err.toString());
        return null;
      }
    } else {
      return null;
    }
  }

  Future<CartMap> getCartMap() async {
    final url = Uri.https(authority, 'api/users/${prefs.idUsuario}/cartdetails', {
      'api_key': apiKey
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        final decodedData = json.decode(response.body);
        print(decodedData);
        final shoppingList = CartDetailList.fromJsonList(decodedData['data']);
        final cartInfo = Cart.fromJsonMap(decodedData['total']);

        if (cartInfo.directionId != 0) {
          final direction = await directionsProvider.getDirectionById(cartInfo.directionId.toString());
          final cartCompuesto = new CartMap(
            data: shoppingList.items,
            total: cartInfo,
            direction: direction
          );

          return cartCompuesto;
        }

        final cartMap = new CartMap(
          data: shoppingList.items,
          total: cartInfo
        );       //STREAM

        return cartMap;
      } catch (err) {
        print(err.toString());
      }
    }
    return null;
  }

  Future<bool> addToShoppingCart(Product producto) async {
    final url = Uri.https(authority, 'api/users/${prefs.idUsuario}/cartdetails');

    final response = await http.post(
      url, 
      body: {
        'api_key'         : apiKey,
        'product_id'      : producto.id.toString(),
        'IdProductoCodigo': producto.idProductoCodigo.toString(),
        'IdProductoDesc'  : producto.idProductoDesc.toString(),
        'IdProductoPres'  : producto.idProductoPres.toString(),
        'Cantidad'        : producto.cantidadCompra.toString(),
        'Precio'          : '${producto.getPrice()[0]}.${producto.getPrice()[1]}'
      }
    );
    if (response.statusCode == 201) {
      this.getNumbOfItemOfCart();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteFromShoppingCart(CartDetail item) async {
    final url = Uri.https(authority, 'api/cartdetail/${item.id}', {'api_key': apiKey});

    final response = await http.delete(url);
    if (response.statusCode == 200) {
      this.getShoppingCart();  // STREAM
      this.getNumbOfItemOfCart();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateShoppingCart({String directionId, String estado, String gastos, String mEntrega, String payReference}) async {
    final url = Uri.https(authority, 'api/carts/${prefs.idActiveCart}');

    final body = {
      'api_key'         : apiKey,
      if (directionId != null)
        'direction_id'  : directionId,
      if (estado != null)
        'Estado'        : estado,
      if (gastos != null)
        'Gastos'        : gastos,
      if (mEntrega != null)
        'MetodoEntrega' : mEntrega,
      if (payReference != null)
        'ReferenciaPago': payReference
    };

    final response = await http.put(url, body: body, headers: headers);

    if (response.statusCode == 200) {
      print('OK');
      return true;
    } else {
      print('ERROR');
      return false;
    }
  }  
}