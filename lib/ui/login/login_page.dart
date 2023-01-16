import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/navigation/action.dart';
import 'package:flutter_application_1/navigation/routePaths.dart';

////// TODO make login screen
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: 'Your email',
                  labelText: 'Email',
                ),
                onChanged: (value) => print(value),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(filled: true, labelText: 'Password'),
                obscureText: true,
                onChanged: (value) => print(value),
              ),
              const SizedBox(
                height: 24,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, RoutePaths.home);
                },
                child: const Text('Sign in'),
              )
            ],
          ),
        ))));
  }
}
