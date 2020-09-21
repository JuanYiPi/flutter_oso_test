// To parse this JSON data, do
//
//     final favoritesList = favoritesListFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_oso_test/src/models/product_model.dart';

FavoritesResponse favoritesFromJson(String str) => FavoritesResponse.fromJson(json.decode(str));

String favoritesToJson(FavoritesResponse data) => json.encode(data.toJson());

class FavoritesResponse {
  
  FavoritesResponse({
    this.data,
  });

  List<Product> data;

  factory FavoritesResponse.fromJson(Map<String, dynamic> json) => FavoritesResponse(
    data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
