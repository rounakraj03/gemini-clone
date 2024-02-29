import 'dart:convert';

class LoginSignUpRequest {
  String email;
  String password;

  LoginSignUpRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory LoginSignUpRequest.fromMap(Map<String, dynamic> map) {
    return LoginSignUpRequest(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginSignUpRequest.fromJson(String source) =>
      LoginSignUpRequest.fromMap(json.decode(source));
}
