class Cart {
  int id;
  String fechaPedido;
  dynamic fechaPago;
  dynamic fechaSalida;
  dynamic fechaEntrega;
  String estado;
  int userId;
  dynamic gastos;
  int descuento;
  double total;
  String metodoPago;
  dynamic referenciaPago;
  String metodoEntrega;
  String createdAt;
  String updatedAt;

  Cart({
    this.id,
    this.fechaPedido,
    this.fechaPago,
    this.fechaSalida,
    this.fechaEntrega,
    this.estado,
    this.userId,
    this.gastos,
    this.descuento,
    this.total,
    this.metodoPago,
    this.referenciaPago,
    this.metodoEntrega,
    this.createdAt,
    this.updatedAt,
  });

  Cart.fromJsonMap(Map<String, dynamic> json){

    id              = json['id'];
    fechaPedido     = json['FechaPedido'];
    fechaPago       = json['FechaPago'];
    fechaSalida     = json['FechaSalida'];
    fechaEntrega    = json['FechaEntrega'];
    estado          = json['Estado'];
    userId          = json['userId'];
    gastos          = json['Gastos'];
    descuento       = json['Descuento'];
    total           = json['Total'] != null?json['Total']/1:0.0;
    metodoPago      = json['MetodoPago'];
    referenciaPago  = json['ReferenciaPago'];
    metodoEntrega   = json['MetodoEntrega'];
    createdAt       = json['createdAt'];
    updatedAt       = json['updatedAt'];
  }
}
