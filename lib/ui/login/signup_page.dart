import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/navigation/routePaths.dart';
import 'package:flutter_application_1/services/http_service.dart';
import 'package:flutter_application_1/ui/login/login_page.dart';

////// TODO make login screen
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email = '';
  String password = '';
  String passwordConfirm = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign-up'),
        ),
        body: Form(
            key: _formKey,
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
                          onChanged: (value) => {
                            setState(() {
                              email = value;
                            })
                          },
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
                          decoration: const InputDecoration(
                            filled: true,
                            labelText: 'Password',
                          ),
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) => {
                            setState(
                              () {
                                password = value;
                              },
                            )
                          },
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value != password ||
                                value == null ||
                                value.isEmpty) {
                              return 'Wrong confirm';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              filled: true, labelText: 'Confirm password'),
                          obscureText: true,
                          onChanged: (value) => {
                            setState(
                              () {
                                passwordConfirm = value;
                              },
                            )
                          },
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Navigator.pushReplacementNamed(
                            //     context, RoutePaths.home);
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                              createUser(email, password, context);
                            }
                          },
                          child: const Text('Sign up'),
                        ),
                      ],
                    )))));
  }

  void createUser(String email, String password, context) async {
    Body body = Body(
        name: email,
        password: password,
        avatar: "https://api.lorem.space/image/face?w=640&h=480&r=867",
        email: email,
        role: "admin");
    // print(body.toJson());
    var res = await post(
        'https://api.escuelajs.co/api/v1/users/', jsonEncode(body.toJson()));
    if (res != '') {
      // Navigator.popUntil(context, ModalRoute.withName(RoutePaths.login));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false);
    }
  }
}

class Body {
  final String email;
  final String password;
  final String name;
  final String avatar;
  final String role;

  Body(
      {this.name = '',
      this.password = '',
      this.email = '',
      this.avatar = '',
      this.role = ''});
  Map<String, dynamic> toJson() =>
      {'name': name, 'email': email, 'password': password, 'avatar': avatar};
}
