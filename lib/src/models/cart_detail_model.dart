
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CartDetail {
  int id;
  int cartId;
  int productId;
  int idProductoCodigo;
  int idProductoDesc;
  int idProductoPres;
  int cantidad;
  double precio;
  int descuento;
  double total;
  String codigo;
  String descripcion;
  String imagen;
  String createdAt;
  String updatedAt;

  CartDetail({
    this.id,
    this.cartId,
    this.productId,
    this.idProductoCodigo,
    this.idProductoDesc,
    this.idProductoPres,
    this.cantidad,
    this.precio,
    this.descuento,
    this.total,
    this.codigo,
    this.descripcion,
    this.imagen,
    this.createdAt,
    this.updatedAt,
  });

  CartDetail.fromJsonMap(Map<String, dynamic> json) {
    id               = json['id'];
    cartId           = json['cart_id'];
    productId        = json['product_id'];
    idProductoCodigo = json['IdProductoCodigo'];
    idProductoDesc   = json['IdProductoDesc'];
    idProductoPres   = json['IdProductoPres'];
    cantidad         = json['Cantidad'];
    precio           = json['Precio'] / 1;
    descuento        = json['Descuento'];
    total            = json['Total'] / 1;
    codigo           = json['Codigo'];
    descripcion      = json['Descripcion'];
    imagen           = json['Imagen'];
    createdAt        = json['created_at'];
    updatedAt        = json['updated_at'];
  }

  String getImg() {

    final String uncodedPath = DotEnv().env['IMG_API_PATH_DEV'];

    if (imagen == null) {
      // return 'http://imposo.ddns.net:81/quickstart/img/products/${imagen}wwww';
      // return 'http://192.168.0.2:8001/img/products/${imagen}wwww';
      return null;
    } else {
      // final url = 'http://imposo.ddns.net:81/quickstart/img/products/$imagen';
      // final url = 'http://192.168.0.2:8001/img/products/$imagen';
      final url = 'http://$uncodedPath/img/products/$imagen';
      return url;
    }
  }
}
