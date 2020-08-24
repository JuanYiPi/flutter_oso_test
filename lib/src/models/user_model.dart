class User {
  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.verified,
    this.admin,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String email;
  String emailVerifiedAt;
  String verified;
  String admin;
  String createdAt;
  String updatedAt;

  User.fromJson(Map<String, dynamic> json) {
    id                = json['id'];
    name              = json['name'];
    email             = json['email'];
    emailVerifiedAt   = json['email_verified_at'];
    verified          = json['verified'];
    admin             = json['admin'];
    createdAt         = json['created_at'];
    updatedAt         = json['updated_at'];
  }
}
