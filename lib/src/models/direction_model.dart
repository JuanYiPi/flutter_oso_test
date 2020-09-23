class Direction {
  int id;
  int type;
  int userId;
  String receive;
  String receivePhone;
  String street;
  String numberExt;
  String numberInt;
  int zip;
  String colony;
  String city;
  String state;
  String country;
  String reference;
  String selection;
  String createdAt;
  String updatedAt;

  Direction({
    this.id,
    this.type,
    this.userId,
    this.receive,
    this.receivePhone,
    this.street,
    this.numberExt,
    this.numberInt,
    this.zip,
    this.colony,
    this.city,
    this.state,
    this.country,
    this.reference,
    this.selection,
    this.createdAt,
    this.updatedAt,
  });

  Direction.empty();

  Direction.fromJsonMap(Map<String, dynamic> json){
    id            = json['id'];
    type          = json['type'] is String ? int.parse(json['type']) : json['type'] ;
    userId        = json['user_id'];
    receive       = json['receive'];
    receivePhone  = json['receive_phone'];
    street        = json['street'];
    numberExt     = json['number_ext'];
    numberInt     = json['number_int'];
    zip           = json['zip'] is String ? int.parse(json['zip']) : json['zip'];
    colony        = json['colony'];
    city          = json['city'];
    state         = json['state'];
    country       = json['country'];
    reference     = json['reference'];
    selection     = json['selection'];
    createdAt     = json['created_at'];
    updatedAt     = json['updated_at'];
  }
}
