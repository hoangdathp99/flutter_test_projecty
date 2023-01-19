import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/app_state_model.dart';
import 'package:flutter_application_1/navigation/action.dart';
import 'package:flutter_application_1/navigation/app_router.dart';
import 'package:flutter_application_1/navigation/routePaths.dart';
import 'package:flutter_application_1/ui/bottomNavbar/bottom_nav_bar.dart';
import 'package:flutter_application_1/ui/bottomNavbar/main_page.dart';
import 'package:flutter_application_1/ui/login/login_page.dart';
import 'package:flutter_application_1/ui/pageThird/pageThird.dart';
import 'package:flutter_application_1/widgets/productCard/product_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/model/product.dart';

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
  @override
  initState() {
    super.initState();
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
          title: Text(widget.title),
        ),
        body: Container(child: Consumer<AppStateModel>(
          builder: (context, value, child) {
            // print(value.productName);
            return SingleChildScrollView(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      ...(value.availableProducts as List<Product>).map((product) {
                        return Expanded(flex:40 ,child: ProductCard( product: product));
                      }).toList(),
                  // 
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // value.controller.jumpToPage(1);
                  //     Navigator.pushNamed(context, RoutePaths.detail);
                  //     // value.loadProducts();
                  //   },
                  //   child: const Text('Go detail!'),
                  // ),
                  // value.productName != "" ? Text(value.availableProducts.toString()) : Container()
                ],
              ),
            );
          },
        )));
  }
}
