import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/bottomNavbar/main_page.dart';
import 'package:flutter_application_1/ui/detailPage/detail_page.dart';
import 'package:flutter_application_1/ui/home_page.dart/home_screen.dart';
import 'package:flutter_application_1/ui/login/login_page.dart';
import 'package:flutter_application_1/ui/pageThird/pageThird.dart';

class ThirdNavigator extends StatefulWidget {
  const ThirdNavigator({super.key});
  @override
  State<ThirdNavigator> createState() => _ThirdNavigatorState();
}

class _ThirdNavigatorState extends State<ThirdNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            // settings: settings,
            builder: (BuildContext context) {
          switch (settings.name) {
            case '/':
              return const PageThird(title: 'Third');
            case 'second':
              return const DetailPage();
            default:
              return const PageThird(title: 'Third');
          }
        });
      },
    );
  }
}
