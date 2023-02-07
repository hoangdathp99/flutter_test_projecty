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

  void handleSearchText(value) {
    setState(() {
      searchText = value;
    });
  }
  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    searchNode.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      body: Consumer<AppStateModel>(builder: (context, value, child) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: ((value) {
                    handleSearchText(value);
                  }),
                  focusNode: searchNode,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        top: 10, right: 15, bottom: 10, left: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusColor: Colors.transparent,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 1),
                    ),
                    hintText: 'Search',
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: (() {
                  searchNode.unfocus();
                  Provider.of<AppStateModel>(context, listen: false)
                      .getSearchData(context, '?title=$searchText');
                }),
                child: const Text("Search")),
            Expanded(
                child: value.loadingSearch == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : value.loadingSearch == false ? ProductList(listProduct: value.ProductSearch) : Container())
          ],
        );
      }),
    );
  }
}
