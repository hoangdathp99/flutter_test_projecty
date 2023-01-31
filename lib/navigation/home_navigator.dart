import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/detailPage/detail_page.dart';
import 'package:flutter_application_1/ui/home_page.dart/home_screen.dart';

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({super.key});
  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
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
                  return const HomeScreen(title: 'home');
                case 'detail':
                  return const DetailPage();
                default:
                  return const HomeScreen(title: 'home');
              }
            });
      },
    );
  }
}
