import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_oso_test/src/models/directions_model.dart';
import 'package:flutter_oso_test/src/providers/user_preferences.dart';
import 'package:flutter_oso_test/src/providers/users_providers.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_oso_test/src/models/direction_model.dart';

class DirectionsProvider {

  static final DirectionsProvider _instancia = new DirectionsProvider._internal();

  factory DirectionsProvider() {
    return _instancia;
  }

  DirectionsProvider._internal();

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
    print("getAllDirections");
    return null;
  }

  Future<Direction> getDirectionById(String id) async {
    final url = Uri.http(authority, 'api/directions/$id', {
      'api_key': apiKey
    });

    final response = await http.get(url);

    try {
      final decodedData = json.decode(response.body);
      final direction = Direction.fromJsonMap(decodedData['data']);
      return direction;
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
      getAllDirections();
      return direction;
    } catch (err) {

      print(err);
      return err.toString();

    }
  }

  Future<bool> deleteDirections(String id) async {
    final url = Uri.http(authority, 'api/directions/$id', {'api_key': apiKey});

    final response = await http.delete(url);
    if (response.statusCode == 200) {
      getAllDirections();
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> updateDirection({@required Direction direccion}) async {

    final Map<String, dynamic> body = {
      'api_key' : apiKey,
      if (direccion.receive != null) 'receive'            : direccion.receive,
      if (direccion.receivePhone != null) 'receive_phone' : direccion.receivePhone,
      if (direccion.street != null) 'street'              : direccion.street,
      if (direccion.numberExt != null) 'number_ext'       : direccion.numberExt,
      if (direccion.numberInt != null) 'number_int'       : direccion.numberInt,
      if (direccion.zip != null) 'zip'                    : direccion.zip.toString(),
      if (direccion.colony != null) 'colony'              : direccion.colony,
      if (direccion.city != null) 'city'                  : direccion.city,
      if (direccion.state != null) 'state'                : direccion.state,
      if (direccion.country != null) 'country'            : direccion.country,
      if (direccion.reference != null) 'reference'        : direccion.reference,
      if (direccion.type != null) 'type'                  : direccion.type.toString(),
    };

    final url = Uri.http(authority, 'api/directions/${direccion.id}');

    final resp = await http.put(url, body: body, headers: UsersProviders.headers);
    final decodedData = json.decode(resp.body);

    try{
      final updateDirection = new Direction.fromJsonMap(decodedData['data']);
      return updateDirection;
    } catch(error) {
      print(error.toString());
      return null;
    }
  }

}