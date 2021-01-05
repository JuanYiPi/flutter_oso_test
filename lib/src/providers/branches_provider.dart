import 'package:flutter_oso_test/src/models/branches_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';

class BranchesProvider {

  String authority = DotEnv().env['OSO_BASE_URL'];
  String apiKey    = DotEnv().env['OSO_API_KEY'];

  final prefs = UserPreferences();

  static Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  Future<Branches> getBranches() async {

    final url = Uri.https(authority, 'api/branch', {
      'api_key'               : apiKey,
    });

    final resp = await http.get(url);

    try{
      final branches = branchesFromJson(resp.body);
      return branches;
    } catch(err) {
      print(err.toString());
    }
    
    return null;
  }
}