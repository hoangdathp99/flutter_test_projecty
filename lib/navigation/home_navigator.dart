import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/detailPage/detail_page.dart';
import 'package:flutter_application_1/ui/home_page.dart/home_screen.dart';
import 'package:flutter_application_1/ui/searchPage/search_screen.dart';

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({super.key});
  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HeroControllerScope(
      controller: MaterialApp.createMaterialHeroController(),
      child: Navigator(
        initialRoute: "/",
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) {
              switch (settings.name) {
                case '/':
                  return const HomeScreen(title: 'home');
                case "search":
                  return const SearchScreen();
                case 'detail':
                  return const DetailPage();
                default:
                  return const HomeScreen(title: 'home');
              }
            },
            // transitionsBuilder: (context, animation, secondaryAnimation, child) {
            //   var tween =
            //       Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero);
            //   var curveTween = CurveTween(curve: Curves.ease);

            //   return SlideTransition(
            //     position: animation.drive(curveTween).drive(tween),
            //     child: child,
            //   );
            // },
          );
        },
      ),
    );
  }
}
