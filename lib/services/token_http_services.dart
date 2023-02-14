// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names, unnecessary_new

import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter_application_1/services/dio_helper.dart';

class ErrorResPonse {
  final int? statusCode;
  final String? message;
  final String? error;
  ErrorResPonse({
    this.statusCode,
    this.message,
    this.error,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusCode': statusCode,
      'message': message,
      'error': error,
    };
  }

  factory ErrorResPonse.fromMap(Map<String, dynamic> map) {
    return ErrorResPonse(
      statusCode: map['statusCode'],
      message: map['message'],
      error: map['error'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorResPonse.fromJson(Map<String, dynamic> source) =>
      ErrorResPonse.fromMap(source);
}

Future<dynamic> GET(String url, Map<String, String> param) async {
  try {
    Response response = await configDio().get(url, queryParameters: param);
    return response;
  } on DioError catch (e) {
    // print(e.response!.statusCode);
    if (e.response != null) {
      print(e.response!.data);
      return ErrorResPonse.fromJson(e.response!.data);
    } else {
      return e.response;
    }
  }
}

// Future<dynamic> POST(String url, body, token) async {
//   try {
//     final response = await http.post(
//       Uri.parse(url),
//       body: jsonEncode(body),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         "Authorization": "Bearer $token"
//       },
//     );
//     return response;
//   } catch (e) {
//     throw Exception(e);
//   }
// }

