import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_oso_test/src/providers/user_preferences.dart';
import 'package:flutter_oso_test/src/models/products_model.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';


class ProductsProvider {

  String authority = DotEnv().env['OSO_BASE_URL'];
  String apiKey    = DotEnv().env['OSO_API_KEY'];
  final prefs = new UserPreferences();

  int _productPage = 0;
  bool _loadingPage = false;

  // STREAM 
  List<Product> _productos = new List();
  final _productsStreamController = StreamController<List<Product>>.broadcast();
  Function(List<Product>) get productsSink => _productsStreamController.sink.add;
  Stream<List<Product>> get productsStream => _productsStreamController.stream;

  void disposeStreams() {
    _productsStreamController?.close();
  }
  //STREAM

  Future<List<Product>> getProducts() async {

    if (_loadingPage) return [];
    _loadingPage = true;
    _productPage++;
    print("page: $_productPage");

    final url = Uri.http(authority, 'api/categories/${prefs.idCategoria}/products',{
      'api_key'               : apiKey,
      'page': _productPage.toString(),
      'rows': '20',
      'user_id': prefs.idUsuario.toString()
    });

    final resp = await _procesarResp(url);
    _productos.addAll(resp);
    productsSink(_productos);
    _loadingPage = false;
    return resp;
  }

  Future<List<Product>> _procesarResp(Uri url) async {
    try {
      final resp = await http.get(url);
      final decodedData = json.decode(resp.body);
      final allProducts = new Products.fromJsonList(decodedData['data']);
      print(decodedData['data']);
      return allProducts.items;
    } catch (err) {
      print(err.toString());
      print('error');
    }
    return null;
  }

  Future<List<Product>> getAllProducts() async {

    final url = Uri.http(authority, 'api/products', {
      'api_key'               : apiKey,
    });
    try {
      final resp = await http.get(url);
      final decodedData = json.decode(resp.body);
      final allProducts = new Products.fromJsonList(decodedData['data']);
      print(decodedData['data']);
      return allProducts.items;
    } catch (err) {
      print(err.toString());
      print('error');
    }
    return null;
  }

  Future<List<Product>> getAllProductsByCategoryID(String id) async {

    final url = Uri.http(authority, 'api/categories/$id/products',{
      'api_key'               : apiKey,
      'page': '1',
      'rows': '20',
      'user_id': prefs.idUsuario.toString()
    });

    try {
      final resp = await http.get(url);
      final decodedData = json.decode(resp.body);
      final allProducts = new Products.fromJsonList(decodedData['data']);
      print(decodedData['data']);
      return allProducts.items;
    } catch (err) {
      print(err.toString());
      print('error');
    }
    return null;
  }

  Future<Product> getProductById(String id) async {
    
    final url = Uri.http(authority, 'api/products/$id');
    try {
      final resp = await http.get(url);
      final decodedData = json.decode(resp.body);
      final product = new Product.fromJsonMap(decodedData['data']);
      print(decodedData['data']);
      return product;
    } catch (err) {
      print(err.toString());
    }
    return null;
  }

  Future<List<Product>> searchProduct(String query) async {
    final url = Uri.http(authority, 'api/products',{
      'api_key': apiKey,
      'query'  : query
    });
    return await _procesarResp(url);
  }

  Future<int> checkUrl(String url) async {
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
