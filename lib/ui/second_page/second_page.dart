// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/model/app_state_model.dart';
import 'package:flutter_application_1/model/filter.dart';
import 'package:flutter_application_1/widgets/productCard/product_list.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:provider/provider.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int data1 = 0;
  bool isSubmit = true;
  int? minPrice;
  int? maxPrice;
  var provider;
  Filter filter = Filter();
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = Provider.of<AppStateModel>(context, listen: false);
      Provider.of<AppStateModel>(context, listen: false)
          .getSearchData(context, {"": ""});
      // minPrice =
      //     Provider.of<AppStateModel>(context, listen: false).Filters.minPrice;
      // maxPrice =
      //     Provider.of<AppStateModel>(context, listen: false).Filters.maxPrice;
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<AppStateModel>(context, listen: false).getTinWinData(context);
    // });

    print("initState Called2");
  }

  @override
  Widget build(BuildContext context) {
    print(minPrice);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Second Page"),
        ),
        body: Consumer<AppStateModel>(
          builder: (context, value, child) {
            // print(value.productName);
            // return SingleChildScrollView(
            return Row(mainAxisSize: MainAxisSize.min, children: [
              Expanded(
                flex: 1,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (provider.Filters != null) {
                              minPrice = provider.Filters.minPrice;
                              maxPrice = provider.Filters.maxPrice;
                            }
                            showModalSideSheet(
                                barrierDismissible: true,
                                context: context,
                                ignoreAppBar: false,
                                withCloseControll: false,
                                width: MediaQuery.of(context).size.width * 0.8,
                                // body: ListView.builder(
                                //   itemCount: 10,
                                //   itemBuilder: (context, index) {
                                //     return GestureDetector(
                                //       onTap: () {
                                //         final data =
                                //             Navigator.pop(context, index);
                                //         setState(() {
                                //           data1 = index;
                                //         });
                                //       },
                                //       child: Container(
                                //         child: Text("I am on $index index"),
                                //       ),
                                //     );
                                //   },
                                // )
                                body: ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (context, index) => Container(
                                    decoration: BoxDecoration(),
                                    padding: EdgeInsets.only(
                                        top: 20,
                                        left: 10,
                                        right: 10,
                                        bottom: 20),
                                    child: Form(
                                      child: Scrollbar(
                                          child: SingleChildScrollView(
                                              child: Column(children: [
                                        Text("Filter by price"),
                                        SizedBox(height: 24),
                                        Row(
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: TextFormField(
                                                  initialValue:
                                                      minPrice?.toString(),
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    label: Text("vnd"),
                                                    hintText: "Min price",
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .always,
                                                    floatingLabelStyle:
                                                        TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline),
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (value) {
                                                    if (value != "") {
                                                      minPrice =
                                                          int.parse(value);
                                                    } else
                                                      minPrice = null;
                                                  },
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              child: Text("-"),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: TextFormField(
                                                  initialValue:
                                                      maxPrice?.toString(),
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    label: Text("vnd"),
                                                    hintText: "Max price",
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .always,
                                                    floatingLabelStyle:
                                                        TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline),
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (value) {
                                                    if (value != "") {
                                                      maxPrice =
                                                          int.parse(value);
                                                    } else
                                                      maxPrice = null;
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 24),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: TextButton(
                                                  onPressed: () {
                                                    provider.resetFilter();
                                                    provider.getSearchData(
                                                        context, {"": ""});
                                                    Navigator.pop(context);
                                                    setState(
                                                      () {
                                                        isSubmit = true;
                                                      },
                                                    );
                                                  },
                                                  child: Text("reset")),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    Filter filter = Filter(
                                                        minPrice: minPrice,
                                                        maxPrice: maxPrice);
                                                    Provider.of<AppStateModel>(
                                                            context,
                                                            listen: false)
                                                        .setFilter(filter);
                                                    Provider.of<AppStateModel>(
                                                            context,
                                                            listen: false)
                                                        .getSearchData(context,
                                                            filter.toJson());
                                                    Navigator.pop(context);
                                                    setState(
                                                      () {
                                                        isSubmit = true;
                                                      },
                                                    );
                                                  },
                                                  child: Text("apply")),
                                            )
                                          ],
                                        )
                                      ]))),
                                    ),
                                  ),
                                ));
                          },
                          child: Icon(Icons.filter_alt_outlined)),
                      Expanded(
                          child: value.loadingSearch == true
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : value.ProductSearch.isNotEmpty
                                  ? ProductList(
                                      listProduct: value.ProductSearch)
                                  : Container()),
                    ]),
              ),
            ]);
          },
        ));
  }
}
