import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/app_state_model.dart';
import 'package:flutter_application_1/model/product.dart';
import 'package:flutter_application_1/services/http_service.dart';
import 'package:flutter_application_1/widgets/productCard/product_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = "";
  FocusNode searchNode = FocusNode();
  Timer? _debounce;
  bool isSubmit = false;
  List<ProductType> productSearchResult = [];
  final TextEditingController _controller = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var provider;
  void handleSearchText(value) {
    setState(() {
      searchText = value;
    });
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
                    child: TypeAheadField(
                        loadingBuilder: (context) => Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator()),
                        textFieldConfiguration: TextFieldConfiguration(
                            controller: _controller,
                            focusNode: searchNode,
                            textAlignVertical: TextAlignVertical.center,
                            onChanged: (value) {
                              handleSearchText(value);
                              setState(() {
                                isSubmit = false;
                              });
                            },
                            onSubmitted: (value) {
                              Params param = Params(title: value);
                              setState(() {
                                isSubmit = true;
                                provider.getSearchData(context, param.toJson());
                              });
                            },
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 10, right: 15, bottom: 10, left: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.transparent),
                                ),
                                focusColor: const Color(0xFFf4f4f4),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.transparent),
                                ),
                                hintText: 'Search',
                                hintStyle: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),
                                fillColor: const Color(0xFFf4f4f4),
                                suffixIcon: InkWell(
                                  onTap: (() {
                                    searchNode.unfocus();
                                    Params param = Params(title: searchText);
                                    setState(() {
                                      isSubmit = true;
                                    });
                                    provider.getSearchData(
                                        context, param.toJson());
                                  }),
                                  child: const Icon(
                                    Icons.search,
                                    color: Colors.black54,
                                  ),
                                ))),
                        suggestionsCallback: (value) async {
                          if (_controller.text != "") {
                            Params param = Params(title: value);
                            return await getSuggest(param.toJson());
                          } else {
                            return const Iterable.empty();
                          }
                        },
                        itemBuilder: (context, dynamic suggestion) {
                          return Container(
                            decoration: const BoxDecoration(
                                border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.black54),
                            )),
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            child: Text(suggestion.title),
                          );
                        },
                        onSuggestionSelected: (dynamic suggestion) {
                          _controller.text = suggestion.title;
                          Params param = Params(title: suggestion.title);
                          Provider.of<AppStateModel>(context, listen: false)
                              .getSearchData(context, param.toJson());
                        }),
                  ),
                ),
              ),
              Expanded(
                  child: isSubmit == true && value.loadingSearch == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : isSubmit == true && value.loadingSearch == false
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

Future<List<ProductType>> getSuggest(param) async {
  Iterable item =
      await fetchData("api.escuelajs.co", "/api/v1/products/", param);
  List<ProductType> tempProduct =
      item.map((e) => ProductType.fromJson(e)).toList();
  return tempProduct;
}
