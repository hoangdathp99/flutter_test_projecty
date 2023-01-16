import 'package:flutter/material.dart';
import 'package:flutter_application_1/navigation/routePaths.dart';
import 'package:flutter_application_1/ui/bottomNavbar/main_page.dart';

class RouterApp {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.start:
        return MaterialPageRoute(
            builder: (_) => const MyHomePage(
                  title: "test41",
                ));

      case RoutePaths.home:
        // you can do things like pass arguments to screens
        return MaterialPageRoute(
            builder: (_) => const MyHomePage(
                  title: "home",
                ));
      case RoutePaths.test:
        // you can do things like pass arguments to screens
        return MaterialPageRoute(
            builder: (_) => const MyHomePage(
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
