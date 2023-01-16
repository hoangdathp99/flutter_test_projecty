import 'package:flutter/material.dart';
import 'package:flutter_application_1/navigation/routePaths.dart';
import 'package:flutter_application_1/ui/TestHook/testHook.dart';
import 'package:flutter_application_1/ui/bottomNavbar/main_page.dart';
import 'package:flutter_application_1/ui/login/login_page.dart';
import 'package:flutter_application_1/ui/pageThird/pageThird.dart';

class RouterApp {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.start:
        return MaterialPageRoute(
            builder: (_) => const MyHomePage(
                  title: "test41",
                ));

      case RoutePaths.secondScreen:
        // you can do things like pass arguments to screens
        return MaterialPageRoute(builder: (_) => const MyHomePage(
                  title: "second",
                ));
      case RoutePaths.test:
        // you can do things like pass arguments to screens
        return MaterialPageRoute(builder: (_) => const MyHomePage(
                  title: "third",
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
