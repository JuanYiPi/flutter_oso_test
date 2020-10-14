// To parse this JSON data, do
//
//     final commentList = commentListFromJson(jsonString);

import 'dart:convert';

CommentList commentListFromJson(String str) => CommentList.fromJson(json.decode(str));

String commentListToJson(CommentList data) => json.encode(data.toJson());

class CommentList {

  List<Comment> data;

  CommentList({
    this.data,
  });

  factory CommentList.fromJson(Map<String, dynamic> json) => CommentList(
    data: List<Comment>.from(json["data"].map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Comment {

  int id;
  int userId;
  int productId;
  String coment;
  int rating;
  DateTime createdAt;
  DateTime updatedAt;

  Comment({
    this.id,
    this.userId,
    this.productId,
    this.coment,
    this.rating,
    this.createdAt,
    this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    coment: json["coment"],
    rating: json["rating"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "coment": coment,
    "rating": rating,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
