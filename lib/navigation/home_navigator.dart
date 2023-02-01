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
        return PageRouteBuilder<SlideTransition>(
          settings: settings,
          pageBuilder: (BuildContext context, animation, secondaryAnimation) {
            switch (settings.name) {
              case '/':
                return const HomeScreen(title: 'home');
              case 'detail':
                return const DetailPage();
              default:
                return const HomeScreen(title: 'home');
            }
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var tween =
                Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero);
            var curveTween = CurveTween(curve: Curves.ease);

            return SlideTransition(
              position: animation.drive(curveTween).drive(tween),
              child: child,
            );
          },
        );
      },
    );
  }
}
