import 'package:flutter_oso_test/src/models/direction_model.dart';

class Directions {

  List<Direction> items = new List();

  Directions();

  Directions.fromJsonList(List<dynamic> jsonList) {

    if ( jsonList == null ) return;

    for (var item in jsonList) {

      final direction = new Direction.fromJsonMap(item);
      items.add(direction);

    }
  }
}