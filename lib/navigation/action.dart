import 'package:flutter/widgets.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void pushPage(routeName) {
  // Navigator.pushNamed(context, name);
  navigatorKey.currentState?.pushNamed(routeName);
}

void goBack() {
  if (navigatorKey.currentState?.canPop() == true) {
    navigatorKey.currentState?.pop();
  }
}
