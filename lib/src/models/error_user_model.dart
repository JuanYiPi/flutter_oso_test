class ErrorUser {
  ErrorUser({
    this.name,
    this.email,
    this.password,
  });

  dynamic name;
  dynamic email;
  dynamic password;

  ErrorUser.fromJson(Map<String, dynamic> json) {
    name     = json['name'];
    email    = json['email'];
    password = json['password'];
  }
}
