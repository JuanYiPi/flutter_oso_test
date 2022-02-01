
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
  int favorite;

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
    this.favorite
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
    favorite         = json["Favorite"];
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    categoryId      : json["category_id"],
    idProductoCodigo: json["IdProductoCodigo"],
    idProductoPres  : json["IdProductoPres"],
    idProductoDesc  : json["IdProductoDesc"],
    id              : json["id"],
    codigo          : json["Codigo"],
    descripcion     : json["Descripcion"],
    unidad          : json["Unidad"],
    stock           : json["Stock"],
    precio          : json['Precio'] != null ? json['Precio'] /1 : 0.0,
    imagen          : json["Imagen"] == null ? null : json["Imagen"],
    favorite        : json["Favorite"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "IdProductoCodigo": idProductoCodigo,
    "IdProductoPres": idProductoPres,
    "IdProductoDesc": idProductoDesc,
    "id": id,
    "Codigo": codigo,
    "Descripcion": descripcion,
    "Unidad": unidad,
    "Stock": stock,
    "Precio": precio,
    "Imagen": imagen == null ? null : imagen,
    "Favorite": favorite,
  };

  String getImg() {
    final String uncodedPath = DotEnv().env['IMG_API_PATH'];
    
    if (imagen == null) {
      return null;
    } else {
      final url = 'https://$uncodedPath/img/products/small/$imagen';
      return url;
    }
  }

  String getFullImg() {
    final String uncodedPath = DotEnv().env['IMG_API_PATH'];
    
    if (imagen == null) {
      return null;
    } else {
      final url = 'https://$uncodedPath/img/products/$imagen';
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
