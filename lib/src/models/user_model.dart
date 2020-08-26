class User {
  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.verified,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String email;
  String emailVerifiedAt;
  String verified;
  String role;
  String createdAt;
  String updatedAt;

  User.fromJson(Map<String, dynamic> json) {
    id                = json['id'];
    name              = json['name'];
    email             = json['email'];
    emailVerifiedAt   = json['email_verified_at'];
    verified          = json['verified'];
    role              = json['role'];
    createdAt         = json['created_at'];
    updatedAt         = json['updated_at'];
  }
}
