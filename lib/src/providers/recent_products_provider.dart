import 'dart:async';
import 'dart:convert';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';
import 'package:flutter_oso_test/src/models/products_model.dart';

class RecentProductsProvider {

  static final RecentProductsProvider _instancia = new RecentProductsProvider._internal();

  factory RecentProductsProvider() {
    return _instancia;
  }

  RecentProductsProvider._internal();

  final prefs = UserPreferences();

  String authority = DotEnv().env['OSO_BASE_URL'];
  String apiKey    = DotEnv().env['OSO_API_KEY'];

  // STREAM 
  List<Product> _productosRecientes = new List();
  final _productosRecientesStreamController = StreamController<List<Product>>.broadcast();
  Function(List<Product>) get productosRecientesSink => _productosRecientesStreamController.sink.add;
  Stream<List<Product>> get productosRecientesStream => _productosRecientesStreamController.stream;

  void disposeStreams() {
    _productosRecientesStreamController?.close();
  }
  //STREAM

  getRecentProducts() async {

    final url = Uri.http(authority, 'api/recentproducts', {
      'api_key': apiKey,
      'user_id': prefs.idUsuario.toString()
    });
    
    try {
      final resp = await http.get(url);
      final decodedData = json.decode(resp.body);
      final allProducts = new Products.fromJsonList(decodedData['data']);
      print(decodedData['data']);

      _productosRecientes.clear();
      _productosRecientes.addAll(allProducts.items);
      productosRecientesSink(_productosRecientes);

      // return allProducts.items;
    } catch (err) {
      print(err.toString());
      print('error');
    }
    // return null;
  }

}