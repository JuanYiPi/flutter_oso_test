import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_oso_test/src/models/directions_model.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_oso_test/src/models/direction_model.dart';

class DirectionsProvider {

  final prefs = new UserPreferences();

  String authority = DotEnv().env['OSO_BASE_URL'];
  String apiKey    = DotEnv().env['OSO_API_KEY'];

  // DIRECTIONS STREAM
  List<Direction> _direcciones = new List();
  final _addressStreamController = StreamController<List<Direction>>.broadcast();
  Function(List<Direction>) get addressSink => _addressStreamController.sink.add;
  Stream<List<Direction>> get addressStream => _addressStreamController.stream;
  // DIRECTIONS STREAM

  void disposeStreams() {
    _addressStreamController?.close();
  }
  //STREAM

  Future<List<Direction>> getAllDirections() async {

    final url = Uri.http(authority, 'api/directions', {
      'api_key' : apiKey,
      'user_id' : prefs.idUsuario.toString(),
    });
    try {
      final resp = await http.get(url);
      final decodedData = json.decode(resp.body);
      final allDirections = new Directions.fromJsonList(decodedData['data']);

      _direcciones = [];
      _direcciones.addAll(allDirections.items);
      addressSink(_direcciones);

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
      getAllDirections();  //STREAM
      return direction;
    } catch (err) {

      print(err);
      return err.toString();

    }
  }

}