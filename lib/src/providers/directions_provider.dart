import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_oso_test/src/models/directions_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_oso_test/src/models/direction_model.dart';

class DirectionsProvider {

  String authority = DotEnv().env['OSO_BASE_URL'];
  String apiKey    = DotEnv().env['OSO_API_KEY'];

  Future<List<Direction>> getAllDirection() async {

    final url = Uri.http(authority, 'api/directions', {
      'api_key' : apiKey,
      'user_id' : '15',
    });
    try {
      final resp = await http.get(url);
      final decodedData = json.decode(resp.body);
      final allDirections = new Directions.fromJsonList(decodedData['data']);
      return allDirections.items;
    } catch (err) {
      print(err.toString());
    }
    return null;
  }

  Future<dynamic> addNewDirection(Direction direction) async {

    final url = Uri.http(authority, 'api/directions',{
      'api_key'       : apiKey,
      'user_id'       : direction.userId.toString(),
      'receive'       : direction.receive,
      'receive_phone' : direction.receivePhone,
      'street'        : direction.street,
      'number_ext'    : direction.numberExt,
      'number_int'    : direction.numberInt,
      'zip'           : direction.zip.toString(),
      'colony'        : direction.colony,
      'city'          : direction.city,
      'state'         : direction.state,
      'country'       : direction.country,
      'reference'     : direction.reference,
      'type'          : direction.type.toString(),
    });

    final resp = await http.post(url);
    final decodedData = json.decode(resp.body);

    try {
      final direction = new Direction.fromJsonMap(decodedData['data']);
      print(decodedData['error']);
      return direction;
    } catch (err) {

      print(err);
      return err.toString();

    }
  }

}