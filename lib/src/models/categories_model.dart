
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Categorias {

  List<Categoria> items = new List();

  Categorias();

  Categorias.fromJsonList(List<dynamic> jsonList) {

    if (jsonList == null) return;

    for (var item in jsonList) {

      final category = new Categoria.fromJsonMap(item);
      items.add(category);
      
    }

  }

}


class Categoria {
  int id;
  int orden;
  String descripcion;
  String imagen;

  Categoria({
    this.id,
    this.orden,
    this.descripcion,
    this.imagen
  });

  Categoria.fromJsonMap(Map<String, dynamic> json ) {
    id            = json['Id'];
    orden         = json['Orden'];
    descripcion   = json['Descripcion'];
    imagen        = json['Imagen'];
  }

  String getImg() {

    final String uncodedPath = DotEnv().env['IMG_API_PATH_DEV'];

    if (imagen == null) {
      return null;
    } else {
      final url = 'http://$uncodedPath/img/categories/$imagen';
      // final url = 'http://imposo.ddns.net:81/quickstart/img/categories/$imagen';
      return url;
    }
  }
}
