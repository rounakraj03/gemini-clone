import 'dart:convert';

class LoginSignUpResponse {
  String id;
  String email;
  String password;
  LoginSignUpResponse({
    required this.id,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'email': email,
      'password': password,
    };
  }

  factory LoginSignUpResponse.fromMap(Map<String, dynamic> map) {
    return LoginSignUpResponse(
      id: map['_id'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginSignUpResponse.fromJson(String source) =>
      LoginSignUpResponse.fromMap(json.decode(source));
}
