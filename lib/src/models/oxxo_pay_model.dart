// To parse this JSON data, do
//
//     final oxxoPay = oxxoPayFromJson(jsonString);

import 'dart:convert';

OxxoPay oxxoPayFromJson(String str) => OxxoPay.fromJson(json.decode(str));

String oxxoPayToJson(OxxoPay data) => json.encode(data.toJson());

class OxxoPay {
  OxxoPay({
    this.data,
  });

  Data data;

  factory OxxoPay.fromJson(Map<String, dynamic> json) => OxxoPay(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {

  String id;
  bool livemode;
  int createdAt;
  String currency;
  PaymentMethod paymentMethod;
  String object;
  String description;
  String status;
  double amount;
  int fee;
  String customerId;
  String orderId;

  Data({
    this.id,
    this.livemode,
    this.createdAt,
    this.currency,
    this.paymentMethod,
    this.object,
    this.description,
    this.status,
    this.amount,
    this.fee,
    this.customerId,
    this.orderId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    livemode: json["livemode"],
    createdAt: json["created_at"],
    currency: json["currency"],
    paymentMethod: PaymentMethod.fromJson(json["payment_method"]),
    object: json["object"],
    description: json["description"],
    status: json["status"],
    amount: json["amount"] / 100,
    fee: json["fee"],
    customerId: json["customer_id"],
    orderId: json["order_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "livemode": livemode,
    "created_at": createdAt,
    "currency": currency,
    "payment_method": paymentMethod.toJson(),
    "object": object,
    "description": description,
    "status": status,
    "amount": amount,
    "fee": fee,
    "customer_id": customerId,
    "order_id": orderId,
  };

  List<String> get getTotal {
    final a = this.amount.toString();
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

class PaymentMethod {
  PaymentMethod({
    this.serviceName,
    this.barcodeUrl,
    this.object,
    this.type,
    this.expiresAt,
    this.storeName,
    this.reference,
  });

  String serviceName;
  String barcodeUrl;
  String object;
  String type;
  int expiresAt;
  String storeName;
  String reference;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    serviceName: json["service_name"],
    barcodeUrl: json["barcode_url"],
    object: json["object"],
    type: json["type"],
    expiresAt: json["expires_at"],
    storeName: json["store_name"],
    reference: json["reference"],
  );

  Map<String, dynamic> toJson() => {
    "service_name": serviceName,
    "barcode_url": barcodeUrl,
    "object": object,
    "type": type,
    "expires_at": expiresAt,
    "store_name": storeName,
    "reference": reference,
  };
}
