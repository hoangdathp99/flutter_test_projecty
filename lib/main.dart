import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/model/app_state_model.dart';
import 'package:flutter_application_1/navigation/action.dart';
import 'package:flutter_application_1/navigation/app_router.dart';
import 'package:flutter_application_1/navigation/routePaths.dart';
import 'package:flutter_application_1/ui/bottomNavbar/main_page.dart';
import 'package:flutter_application_1/ui/home_page.dart/home_screen.dart';
import 'package:flutter_application_1/ui/login/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

// ignore: constant_identifier_names
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppStateModel()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const LoginScreen(),
          navigatorKey: navigatorKey,
          initialRoute: RoutePaths.start,
          onGenerateRoute: RouterApp.generateRoute,
        ));
  }
}
