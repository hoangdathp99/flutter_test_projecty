import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/app_state_model.dart';
import 'package:flutter_application_1/model/product.dart';
import 'package:flutter_application_1/navigation/action.dart';
import 'package:flutter_application_1/navigation/routePaths.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Product;
    String capitalize(String str) {
      return str
          .split(' ')
          .map((word) => word.substring(0, 1).toUpperCase() + word.substring(1))
          .join(' ');
    }

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
          title: Text(args.name),
        ),
        body: SingleChildScrollView(
          child: Consumer<AppStateModel>(
            builder: (context, value, child) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(args.imageUrl),
                            fit: BoxFit.cover)),
                    height: 300,
                    width: double.infinity,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      args.name != ""
                          ? Text(args.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20))
                          : Container(),
                      // ignore: unrelated_type_equality_checks
                      args.price != ""
                          ? Text(
                              '\$${args.price.toString()}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            )
                          : Container()
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                  // ignore: unrelated_type_equality_checks
                    child: args.category != ""
                        ? Text(
                            capitalize(args.category.name),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                            textAlign: TextAlign.left,
                          )
                        : Container(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(args.description),
                  )
                ]),
              );
            },
          ),
        ));
  }
}
