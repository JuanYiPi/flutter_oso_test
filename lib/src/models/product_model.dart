class Product {
  int cantidadCompra = 1;
  int categoryId;
  int idProductoCodigo;
  int idProductoPres;
  int idProductoDesc;
  int id;
  String codigo;
  String descripcion;
  String unidad;
  int stock;
  double precio;
  String imagen;

  Product({
    this.categoryId,
    this.idProductoCodigo,
    this.idProductoPres,
    this.idProductoDesc,
    this.id,
    this.codigo,
    this.descripcion,
    this.unidad,
    this.stock,
    this.precio,
    this.imagen,
  });

  Product.fromJsonMap(Map<String, dynamic> json ) {
    categoryId       = json['category_id'];
    idProductoCodigo = json['IdProductoCodigo'];
    idProductoPres   = json['IdProductoPres'];
    idProductoDesc   = json['IdProductoDesc'];
    id               = json['id'];
    codigo           = json['Codigo'];
    descripcion      = json['Descripcion'];
    unidad           = json['Unidad'];
    stock            = json['Stock'];
    precio           = json['Precio'] != null ? json['Precio'] /1 : 0.0;
    imagen           = json['Imagen'];
  }

  String getImg() {
    
    if (imagen == null) {
      return null;
    } else {
      // final url = 'http://imposo.ddns.net:81/quickstart/img/products/$imagen';
      final url = 'http://192.168.0.2:8001/img/products/$imagen';
      return url;
    }
  }

  List<String> getPrice() {
    final a = precio.toString();
    final b = a.split('.');
    final d = '${b[1]}0';
    final list = [b[0],d];
    return list;
  }  
}