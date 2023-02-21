import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/app_state_model.dart';
import 'package:flutter_application_1/navigation/routePaths.dart';
import 'package:flutter_application_1/ui/searchPage/search_screen.dart';
import 'package:flutter_application_1/widgets/productCard/product_list.dart';
import 'package:flutter_application_1/widgets/searchWidget/searchTrigger.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title, this.setIndex});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final PageController? setIndex;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int num = 0;
  String searchResult = "";
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppStateModel>(context, listen: false).getTinWinData(context);
    });
    print("initState Called");
  }

  @override
  Widget build(BuildContext context) {
    // this.mounted;
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
        toolbarHeight: 90,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            capitalize(widget.title),
            style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 25),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    settings: RouteSettings(arguments: searchResult),
                    transitionDuration: const Duration(milliseconds: 300),
                    pageBuilder: (_, __, ___) => SearchScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, page) {
                      var begin = 0.0;
                      var end = 1.0;
                      var curve = Curves.fastLinearToSlowEaseIn;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      return ScaleTransition(
                        alignment: Alignment(1, -1),
                        scale: animation.drive(tween),
                        child: page,
                        filterQuality: FilterQuality.none,
                      );
                    },
                  ));
            },
            child: SearchTrigger(),
          ),
        ]),
      ),
      body: Consumer<AppStateModel>(
        builder: (context, value, child) {
          // return SingleChildScrollView(
          return !value.loading
              ? ProductList(listProduct: value.Product)
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
