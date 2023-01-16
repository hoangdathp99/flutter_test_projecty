import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/app_state_model.dart';
import 'package:flutter_application_1/navigation/action.dart';
import 'package:flutter_application_1/navigation/app_router.dart';
import 'package:flutter_application_1/navigation/routePaths.dart';
import 'package:flutter_application_1/ui/bottomNavbar/bottom_nav_bar.dart';
import 'package:flutter_application_1/ui/login/login_page.dart';
import 'package:provider/provider.dart';

class PageThird extends StatefulWidget {
  const PageThird({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  @override
  State<PageThird> createState() => _PageThirdState();
}

class _PageThirdState extends State<PageThird> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(child: Consumer<AppStateModel>(
          builder: (context, value, child) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, '/', arguments: 2);
                      // pushPage(RoutePaths.test);
                      value.loadProducts();
                    },
                    child: const Text('load product'),
                  ),
                  value.productName != ""
                      ? Text(value.productName)
                      : Container()
                ]);
          },
        )));
  }
}
