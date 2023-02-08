// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final int id;
  final String email;
  final String password;
  final String name;
  final String avatar;
  final String role;
  User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.avatar,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'avatar': avatar,
      'role': role,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      email: map['email'] as String,
      password: map['password'] as String,
      name: map['name'] as String,
      avatar: map['avatar'] as String,
      role: map['role'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(Map<String, dynamic> source) => User.fromMap(source);
}
