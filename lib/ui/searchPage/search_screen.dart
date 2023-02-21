import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/app_state_model.dart';
import 'package:flutter_application_1/model/product.dart';
import 'package:flutter_application_1/services/http_service.dart';
import 'package:flutter_application_1/widgets/productCard/product_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../widgets/searchWidget/searchInputFilter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = "";
  FocusNode searchNode = FocusNode();
  Timer? _debounce;
  // ignore: prefer_typing_uninitialized_variables
  var provider;
  void handleSearchText(value) {
    setState(() {
      searchText = value;
    });
  }

  void onSearch() {
    Params param = Params(title: searchText);
    Provider.of<AppStateModel>(context, listen: false)
        .getSearchData(context, param.toJson());
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = Provider.of<AppStateModel>(context, listen: false);
    });
  }

  @override
  void dispose() {
    provider.resetSearchData();
    _debounce?.cancel();
    // Clean up the focus node when the Form is disposed.
    searchNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFFf4f4f4),
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFFf4f4f4)),
        child: Consumer<AppStateModel>(builder: (context, value, child) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 10, left: 10, right: 10),
                child: Hero(
                  tag: "search",
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Container(
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
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xFFf4f4f4)),
                        child: SearchInput(
                            handleSearchText: handleSearchText,
                            onSearch: onSearch)),
                  ),
                ),
              ),
              Expanded(
                  child: value.loadingSearch == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : value.loadingSearch == false
                          ? ProductList(listProduct: value.ProductSearch)
                          : Container())
            ],
          );
        }),
      ),
    );
  }
}

class Params {
  final String title;

  Params({this.title = ''});
  Map<String, String> toJson() => {'title': title};
}
