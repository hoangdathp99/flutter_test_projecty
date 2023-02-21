// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/model/app_state_model.dart';
import 'package:flutter_application_1/model/filter.dart';
import 'package:flutter_application_1/widgets/productCard/product_list.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:provider/provider.dart';
import '../../widgets/searchWidget/searchInputFilter.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int data1 = 0;
  String searchText = "";
  bool isSubmit = true;
  int? minPrice = null;
  int? maxPrice = null;
  FocusNode minFocus =  FocusNode();
  FocusNode maxFocus =  FocusNode();
  var provider;
  final _formKey = GlobalKey<FormState>();
  Filter filter = Filter();
  void handleSearchText(value) {
    setState(() {
      searchText = value;
    });
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = Provider.of<AppStateModel>(context, listen: false);
      Provider.of<AppStateModel>(context, listen: false)
          .getSearchData(context, {"": ""});
    });

    print("initState Called2");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Second Page"),
        ),
        body: Consumer<AppStateModel>(
          builder: (context, value, child) {
            // print(value.productName);
            // return SingleChildScrollView(
            return Container(
              color: Color(0xFFf4f4f4),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Expanded(
                  flex: 1,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                          child: ElevatedButton(
                              onPressed: () {
                                if (provider.Filters != null) {
                                  setState(() {
                                    minPrice = provider.Filters.minPrice;
                                    maxPrice = provider.Filters.maxPrice;
                                  });
                                } else {
                                  minPrice = null;
                                  maxPrice = null;
                                }
                                showModalSideSheet(
                                    barrierDismissible: true,
                                    context: context,
                                    // ignoreAppBar: false,
                                    withCloseControll: false,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    body: ListView.builder(
                                      itemCount: 1,
                                      itemBuilder: (context, index) =>
                                          Container(
                                        decoration: BoxDecoration(),
                                        padding: EdgeInsets.only(
                                            top: 20,
                                            left: 10,
                                            right: 10,
                                            bottom: 20),
                                        child: Form(
                                          key: _formKey,
                                          child: Scrollbar(
                                              child: SingleChildScrollView(
                                                  child: Column(children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Color(0xFFcfcfcf),
                                                      offset: Offset(5, 5),
                                                      blurRadius: 20,
                                                      spreadRadius: 6,
                                                    ),
                                                    BoxShadow(
                                                      color: Color(0xFFf4f4f4),
                                                      offset: Offset(-5, -5),
                                                      blurRadius: 20,
                                                      spreadRadius: 6,
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color:
                                                      const Color(0xFFf4f4f4)),
                                              child: SearchInput(
                                                onSearch: () {},
                                                handleSearchText:
                                                    handleSearchText,
                                                searchText: searchText,
                                              ),
                                            ),
                                            SizedBox(height: 24),
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
                                                      validator: (value) {
                                                        if (value == "" &&
                                                            (maxPrice !=
                                                                null)) {
                                                          return "Please enter min price";
                                                        }
                                                      },
                                                      initialValue:
                                                          minPrice?.toString(),
                                                      focusNode: minFocus,
                                                      decoration:
                                                          InputDecoration(
                                                        helperText: " ",
                                                        filled: true,
                                                        label: Text("vnd"),
                                                        labelStyle: TextStyle(color: minFocus.hasFocus ? Colors.black54 : Colors.black54),
                                                        hintText: "Min price",
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .always,
                                                        floatingLabelStyle: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline),
                                                        focusColor: const Color(
                                                            0xFFf4f4f4),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .transparent),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .transparent),
                                                        ),
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        if (value != "") {
                                                          minPrice =
                                                              int.parse(value);
                                                        } else {
                                                          minPrice = null;
                                                        }
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
                                                      validator: (value) {
                                                        if (value == "" &&
                                                            minPrice != null) {
                                                          return "Please enter min price";
                                                        }
                                                      },
                                                      initialValue:
                                                          maxPrice?.toString(),
                                                      decoration:
                                                          InputDecoration(
                                                        helperText: " ",
                                                        filled: true,
                                                        label: Text("vnd"),
                                                        labelStyle: TextStyle(color: Colors.black54),
                                                        hintText: "Max price",
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .always,
                                                        floatingLabelStyle: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline),
                                                        focusColor: const Color(
                                                            0xFFf4f4f4),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .transparent),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .transparent),
                                                        ),
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                            searchText = "";
                                                          },
                                                        );
                                                      },
                                                      child: Text("reset")),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          Filter filter = Filter(
                                                              minPrice:
                                                                  minPrice,
                                                              maxPrice:
                                                                  maxPrice,
                                                              searchText:
                                                                  searchText);
                                                          Provider.of<AppStateModel>(
                                                                  context,
                                                                  listen: false)
                                                              .setFilter(
                                                                  filter);
                                                          Provider.of<AppStateModel>(
                                                                  context,
                                                                  listen: false)
                                                              .getSearchData(
                                                                  context,
                                                                  filter
                                                                      .toJson());
                                                          Navigator.pop(
                                                              context);
                                                        }
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
                        ),
                        Expanded(
                            child: value.loadingSearch == true
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : value.loadingSearch == false
                                    ? ProductList(
                                        listProduct: value.ProductSearch)
                                    : Container()),
                      ]),
                ),
              ]),
            );
          },
        ));
  }
}
