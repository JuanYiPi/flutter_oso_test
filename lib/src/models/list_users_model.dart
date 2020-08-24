import 'package:flutter_oso_test/src/models/user_model.dart';

class ListUsers {
  List<User> items = new List();

  ListUsers();

  ListUsers.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final user = new User.fromJson(item);
      items.add(user);     
    }
  }
}