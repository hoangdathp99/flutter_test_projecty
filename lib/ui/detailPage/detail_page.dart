import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/app_state_model.dart';
import 'package:flutter_application_1/model/product.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_application_1/widgets/datePicker/datePicker.dart';
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
    final args = ModalRoute.of(context)!.settings.arguments as ProductType;

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
          title: Text(args.title.toString()),
        ),
        body: SingleChildScrollView(
          child: Consumer<AppStateModel>(
            builder: (context, value, child) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  Hero(
                    tag: args.title,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(args.images[0]),
                              fit: BoxFit.cover)),
                      height: 300,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(args.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      // ignore: unrelated_type_equality_checks
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        alignment: Alignment.centerRight,
                        child: Text(
                          '\$${args.price.toString()}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    // ignore: unrelated_type_equality_checks
                    child: args.category.name != ""
                        ? Text(
                            capitalize(args.category.name.toString()),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                            textAlign: TextAlign.left,
                          )
                        : Container(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(args.description),
                  ),
                  const DatePickerWidget(),
                ]),
              );
            },
          ),
        ));
  }
}
