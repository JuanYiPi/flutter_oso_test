import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_oso_test/src/models/categories_model.dart';


class CategoriasProvider {

  static String authority = '192.168.0.2:8001';

  Future<List<Categoria>> getAllCategorias() async {

    final url = Uri.http(authority, 'api/categories');
    try {
      final resp = await http.get(url);
      final decodedData = json.decode(resp.body);
      final allCategories = new Categorias.fromJsonList(decodedData['data']);
      return allCategories.items;
    } catch (err) {
      print(err.toString());
    }
    return null;
  }
}