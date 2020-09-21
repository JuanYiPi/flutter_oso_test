import 'package:flutter_oso_test/src/models/favorites_response.dart';
import 'package:flutter_oso_test/src/models/product_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';

class FavoritesProvider {

  final prefs = new UserPreferences();

  String authority = DotEnv().env['OSO_BASE_URL'];
  String apiKey    = DotEnv().env['OSO_API_KEY'];

  Future<List<Product>> getFavorites() async {

    final url = Uri.http(authority, 'api/users/${prefs.idUsuario}/favorites', {
      'api_key' : apiKey,
    });

    final resp = await http.get(url);

    try {
      final favoritos = favoritesFromJson(resp.body);
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
      return true;
    } else {
      return false;
    }
    
  }

}