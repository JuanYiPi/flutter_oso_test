
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

  Categoria({
    this.id,
    this.orden,
    this.descripcion,
  });

  Categoria.fromJsonMap(Map<String, dynamic> json ) {
    id            = json['Id'];
    orden         = json['Orden'];
    descripcion   = json['Descripcion'];
  }
}
