import 'dart:convert';

import 'package:client/core/snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrorResponse {
  int status;
  String errorMessage;

  ErrorResponse({
    required this.status,
    required this.errorMessage,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'errorMessage': errorMessage,
    };
  }

  factory ErrorResponse.fromMap(Map<String, dynamic> map) {
    return ErrorResponse(
      status: map['status']?.toInt() ?? 0,
      errorMessage: map['errorMessage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorResponse.fromJson(String source) =>
      ErrorResponse.fromMap(json.decode(source));
}

class ApiErrorHandler {
  ApiErrorHandler() {}

  void handleError(error) {
    if (error is DioException) {
      final res = error.response;
      print("res ${res}");
      final decodedString = jsonDecode(res.toString());
      final res2 = ErrorResponse.fromMap(decodedString);

      print("API ERROR HANDLER => ${res2.errorMessage}");
      scaffoldMessenger.showSnackBar(text: res2.errorMessage);
    }
  }
}
