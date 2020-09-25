import 'dart:async';

import 'package:flutter_oso_test/src/models/favorites_response.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';

class FavoritesProvider {

  final prefs = new UserPreferences();

  String authority = DotEnv().env['OSO_BASE_URL'];
  String apiKey    = DotEnv().env['OSO_API_KEY'];

  // FAVORITES STREAM
  List<Product> _favoritos = new List();
  final _favoritosStreamController = StreamController<List<Product>>.broadcast();
  Function(List<Product>) get favoritosSink => _favoritosStreamController.sink.add;
  Stream<List<Product>> get favoritosStream => _favoritosStreamController.stream;

  void disposeStream() {
    _favoritosStreamController?.close();
  }
  // FAVORITES STREAM

  Future<List<Product>> getFavorites() async {

    final url = Uri.http(authority, 'api/users/${prefs.idUsuario}/favorites', {
      'api_key' : apiKey,
    });

    final resp = await http.get(url);

    try {
      final favoritos = favoritesFromJson(resp.body);
      // STREAM
      _favoritos = [];
      _favoritos.addAll(favoritos.data);
      favoritosSink(_favoritos);
      // STREAM
      return favoritos.data;
    } catch (e) {
      print(e.toString());
      return null;
    }

  }

  Future<bool> addToFavorite(String productId) async {

    final url = Uri.http(authority, 'api/favorites');

    final resp = await http.post(url, body: {
      'api_key'   : apiKey,
      'user_id'   : prefs.idUsuario.toString(),
      'product_id': productId
    });

    if (resp.statusCode == 201) {
      print('agregado a favoritos');
      return true;
    } else {
      print('no se pudo agregar a favoritos');
      return false;
    }

  }

  Future<bool> deleteFavorite(String productId) async {

    final url = Uri.http(authority, 'api/users/${prefs.idUsuario}/products/$productId', {
      'api_key'   : apiKey,
      'user_id'   : prefs.idUsuario.toString(),
      'product_id': productId
    });

    final resp = await http.delete(url);

    if (resp.statusCode == 200) {
      print('eliminado de favoritos');
      return true;
    } else {
      print('no se pudo eliminar de favoritos');
      return false;
    }

  }

}