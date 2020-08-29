import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_oso_test/src/providers/user_preferences.dart';
import 'package:flutter_oso_test/src/models/carts_model.dart';
import 'package:flutter_oso_test/src/models/cart_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CartsProvider {

  String authority = DotEnv().env['OSO_BASE_URL'];
  String apiKey    = DotEnv().env['OSO_API_KEY'];
  final prefs      = new UserPreferences();

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

  // Future<Cart> getCompraDetById(Stream idCompra) async {

  //   final url = Uri.http(authority, 'api/carts/$idCompra/details', {
  //     'api_key'               : apiKey,
  //   });
  //   try {
  //     final resp = await http.get(url);
  //     final decodedData = json.decode(resp.body);
  //     final compraDetById = new Cart.fromJsonMap(decodedData['data']);
  //     return 
  //   } catch (err) {
  //     print(err.toString());
  //   }
  //   return null;
  // }

}