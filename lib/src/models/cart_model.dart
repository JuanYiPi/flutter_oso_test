class Cart {
  int id;
  String fechaPedido;
  String fechaPago;
  String fechaSalida;
  String fechaEntrega;
  String estado;
  int userId;
  double gastos;
  int descuento;
  double total;
  String metodoPago;
  String referenciaPago;
  String metodoEntrega;
  int directionId;
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
    this.directionId,
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
    gastos          = json['Gastos'] != null?json['Gastos']/1:0.0;
    descuento       = json['Descuento'];
    total           = json['Total'] != null?json['Total']/1:0.0;
    metodoPago      = json['MetodoPago'];
    referenciaPago  = json['ReferenciaPago'];
    metodoEntrega   = json['MetodoEntrega'];
    directionId     = json['direction_id'];
    createdAt       = json['createdAt'];
    updatedAt       = json['updatedAt'];
  }

  List<String> get getTotal {
    final a = this.total.toString();
    final b = a.split('.');
    if (b[1].length == 1){
      final d = '${b[1]}0';
      final list = [b[0],d];
      return list;
    } else {
      return b;
    }
  }
}
