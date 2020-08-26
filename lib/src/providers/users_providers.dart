import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:flutter_oso_test/src/models/error_user_model.dart';
import 'package:flutter_oso_test/src/models/list_users_model.dart';
import 'package:flutter_oso_test/src/models/user_model.dart';


class UsersProviders {

  String authority = '192.168.0.2:8001';

  static Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  Future<List<User>> getAllUsers() async {

    final url = Uri.http(authority, 'api/users');
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    try {
      final allUsers = new ListUsers.fromJsonList(decodedData['data']);
      print(decodedData['data']);
      return allUsers.items;
    } catch (err) {
      print(err.toString());
    }

    return null;
  }

  Future <User> getUserById(String idUser) async {

    final url = Uri.http(authority, 'api/users/$idUser');
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    try {
      final user = new User.fromJson(decodedData['data']);
      print(decodedData['data']);
      return user;
    } catch (err) {
      print(err.toString());
    }

    return null;
  }

  Future<dynamic> addNewUser({String nombre, String correo, String clave, String claveConfirmation}) async {

    final url = Uri.http(authority, 'api/users',{
      'name'                  : nombre,
      'email'                 : correo,
      'password'              : clave,
      'password_confirmation' : claveConfirmation
    });

    final resp = await http.post(url);
    final decodedData = json.decode(resp.body);
    
    try {
      final user = new User.fromJson(decodedData['data']);
      print(decodedData['data']);
      return user;
    } catch (_) {

      try {
        final error = ErrorUser.fromJson(decodedData['error']);
        print(decodedData['error']);
        return error;
      } catch (error) {
        print(error.toString());
        return null;
      }

    }
  }

  Future<dynamic> updateUser({String id, String name, String email}) async {

    final Map <String, dynamic> body = {
      'name'    : name,
      'email'   : email,
    };

    final url = Uri.http(authority, 'api/users/$id');
    final resp = await http.put(url, body: body, headers: UsersProviders.headers);
    final decodedData = json.decode(resp.body);

    try {
      final updatedUser = new User.fromJson(decodedData['data']);
      return updatedUser;
    } catch (_) {

      try {
        final error = ErrorUser.fromJson(decodedData['error']);
        print(decodedData['error']);
        return error;
      } catch (error) {
        print(error.toString());
        return null;
      }
    }
  }

  Future deleteUserById(String idUser) async {

    try {
      final url = Uri.http(authority, 'api/users/$idUser');
      var response = await http.delete(url);
      print(response.body);
      return jsonDecode(response.body);
    } catch (err) {
      print('error: ${err.toString()}');
    }
    
    return null;

  }
}