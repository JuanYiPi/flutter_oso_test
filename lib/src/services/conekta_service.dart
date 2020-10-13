import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_oso_test/src/models/oxxo_pay_model.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';
import 'package:http/http.dart' as http;

class ConektaService {

  final prefs = UserPreferences();

  String authority = DotEnv().env['OSO_BASE_URL'];
  String apiKey    = DotEnv().env['OSO_API_KEY'];

  Future<Data> payWithOxxo() async { 

    final url = Uri.https(authority, 'api/conekta', {
      'api_key': apiKey,
      'cart_id': prefs.idActiveCart.toString()
    });

    final resp = await http.get(url);

    try {
      final response = oxxoPayFromJson(resp.body);
      return response.data;
    } catch (err) {
      print (err.toString());
      return null;
    }

  }
}