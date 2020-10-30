// To parse this JSON data, do
//
//     final verificationCode = verificationCodeFromJson(jsonString);

import 'dart:convert';

VerificationCode verificationCodeFromJson(String str) => VerificationCode.fromJson(json.decode(str));

String verificationCodeToJson(VerificationCode data) => json.encode(data.toJson());

class VerificationCode {
    VerificationCode({
        this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.phone,
        this.role,
        this.verified,
        this.verificationCode,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String name;
    String email;
    DateTime emailVerifiedAt;
    String phone;
    int role;
    String verified;
    int verificationCode;
    DateTime createdAt;
    DateTime updatedAt;

    factory VerificationCode.fromJson(Map<String, dynamic> json) => VerificationCode(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        phone: json["phone"],
        role: json["role"],
        verified: json["verified"],
        verificationCode: json["verification_code"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "phone": phone,
        "role": role,
        "verified": verified,
        "verification_code": verificationCode,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
