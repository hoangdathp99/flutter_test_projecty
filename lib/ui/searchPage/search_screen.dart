import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/model/app_state_model.dart';
import 'package:flutter_application_1/model/product.dart';
import 'package:flutter_application_1/widgets/productCard/product_list.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = "";
  FocusNode searchNode = FocusNode();
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
    // Clean up the focus node when the Form is disposed.
    searchNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFFf4f4f4)),
        child: Consumer<AppStateModel>(builder: (context, value, child) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: RawAutocomplete(
                    textEditingController: _controller,
                    focusNode: searchNode,
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<ProductType>.empty();
                      } else {
                        List<ProductType> matches = <ProductType>[];
                        matches.addAll(value.Product);
                        matches.retainWhere((s) {
                          return s.title
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                        return matches;
                      }
                    },
                    onSelected: (ProductType selection) {
                      handleSearchText(selection.title);
                      _controller.text = selection.title;
                      Params param = Params(title: searchText);
                      searchNode.unfocus();
                      Provider.of<AppStateModel>(context, listen: false)
                          .getSearchData(context, param.toJson());
                    },
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController textEditingController,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted) {
                      return TextField(
                          textAlignVertical: TextAlignVertical.center,
                          onChanged: ((value) {
                            handleSearchText(value);
                            setState(() {
                              // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                              textEditingController.notifyListeners();
                            });
                          }),
                          focusNode: searchNode,
                          enableSuggestions: true,
                          controller: textEditingController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                top: 10, right: 15, bottom: 10, left: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            focusColor: Colors.transparent,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(width: 1),
                            ),
                            hintText: 'Search',
                            fillColor: Colors.white,
                          ),
                          onSubmitted: (searchText) {
                            Params param = Params(title: searchText);
                            searchNode.unfocus();
                            Provider.of<AppStateModel>(context, listen: false)
                                .getSearchData(context, param.toJson());
                          });
                    },
                    optionsViewBuilder: (BuildContext context,
                        void Function(ProductType) onSelected,
                        Iterable<ProductType> options) {
                      return Material(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(right: 15),
                            child: SingleChildScrollView(
                                child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFf4f4f4),
                              ),
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                children: options.map((opt) {
                                  return InkWell(
                                      onTap: () {
                                        onSelected(opt);
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                              width: 1, color: Colors.black54),
                                        )),
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(10),
                                        child: Text(opt.title),
                                      ));
                                }).toList(),
                              ),
                            ))),
                      );
                    },
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: (() {
                    Params param = Params(title: searchText);
                    searchNode.unfocus();
                    Provider.of<AppStateModel>(context, listen: false)
                        .getSearchData(context, param.toJson());
                  }),
                  child: const Text("Search")),
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
