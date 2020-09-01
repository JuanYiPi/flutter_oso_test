
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
    if (imagen == null) {
      return 'http://192.168.0.2:8001/img/categories/${imagen}wwww';
    } else {
      final url = 'http://192.168.0.2:8001/img/categories/$imagen';
      return url;
    }
  }
}
