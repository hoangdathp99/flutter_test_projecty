import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/bottomNavbar/main_page.dart';
import 'package:flutter_application_1/ui/detailPage/detail_page.dart';
import 'package:flutter_application_1/ui/home_page.dart/home_screen.dart';
import 'package:flutter_application_1/ui/login/login_page.dart';
import 'package:flutter_application_1/ui/pageThird/pageThird.dart';

class SecondNavigator extends StatefulWidget {
  const SecondNavigator({super.key});
  @override
  State<SecondNavigator> createState() => _SecondNavigatorState();
}

class _SecondNavigatorState extends State<SecondNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return const SecondScreen();
                case 'detail':
                  return const DetailPage(title: "detail",);
                default:
                  return const SecondScreen();
              }
            });
      },
    );
  }
}