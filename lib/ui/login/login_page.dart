import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/navigation/routePaths.dart';
import 'package:flutter_application_1/services/http_service.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  String token = '';
  LoginRes _loginRes = LoginRes(accessToken: '', refreshToken: '');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign-in Screen"),
        ),
        body: Form(
            child: Scrollbar(
                child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill email';
                  }
                  return null;
                },
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: 'Your email',
                  labelText: 'Email',
                ),
                onChanged: (value) => {email = value},
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill password';
                  }
                  return null;
                },
                decoration:
                    const InputDecoration(filled: true, labelText: 'Password'),
                obscureText: true,
                onChanged: (value) => {password = value},
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  Login(email, password, context);
                },
                child: const Text('Sign in'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutePaths.signUp);
                },
                child: const Text('Sign up'),
              )
            ],
          ),
        ))));
  }

  void Login(String email, String password, context) async {
    LoginType loginReq = LoginType(
      email: email,
      password: password,
    );
    var res = await post('https://api.escuelajs.co/api/v1/auth/login',
        jsonEncode(loginReq.toJson()));
    _loginRes = LoginRes.fromJson(res);
    print(_loginRes.accessToken);
    if (_loginRes.accessToken != '') {
      await saveData(_loginRes.accessToken);
      Navigator.pushReplacementNamed(context, RoutePaths.home);
    }
  }
}

class LoginType {
  final String email;
  final String password;
  LoginType({this.email = '', this.password = ''});
  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

class LoginRes {
  final String accessToken;
  final String refreshToken;
  LoginRes({required this.accessToken, required this.refreshToken});
  factory LoginRes.fromJson(Map<String, dynamic> json) {
    return LoginRes(
        accessToken: json['access_token'], refreshToken: json['refresh_token']);
  }
}
