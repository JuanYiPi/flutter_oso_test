
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
    createdAt        = json['created_at'];
    updatedAt        = json['updated_at'];
  }
}
