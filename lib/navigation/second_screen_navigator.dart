import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/detailPage/detail_page.dart';
import 'package:flutter_application_1/ui/second_page/second_page.dart';

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
                  return const DetailPage(
                    title: "detail",
                  );
                default:
                  return const SecondScreen();
              }
            });
      },
    );
  }
}
