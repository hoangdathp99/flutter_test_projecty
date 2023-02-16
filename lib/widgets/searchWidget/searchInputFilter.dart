import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/product.dart';
import 'package:flutter_application_1/services/http_service.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key, required this.onSearch, required this.handleSearchText,this.searchText = ""});
  final Function handleSearchText;
  final Function onSearch; 
  final String searchText;
  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _controller = TextEditingController();
  FocusNode searchNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
        loadingBuilder: (context) => Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: const CircularProgressIndicator()),
        textFieldConfiguration: TextFieldConfiguration(
            controller: _controller,
            focusNode: searchNode,
            textAlignVertical: TextAlignVertical.center,
            
            onChanged: (value) {
              widget.handleSearchText(value);
            },
            onSubmitted: (value) {
              widget.onSearch();
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    top: 10, right: 15, bottom: 10, left: 15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide:
                      const BorderSide(width: 1, color: Colors.transparent),
                ),
                focusColor: const Color(0xFFf4f4f4),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide:
                      const BorderSide(width: 1, color: Colors.transparent),
                ),
                hintText: widget.searchText != '' ? widget.searchText : 'Search',
                hintStyle: const TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w500),
                fillColor: const Color(0xFFf4f4f4),
                suffixIcon: InkWell(
                  onTap: (() {
                    searchNode.unfocus();
                    widget.onSearch();
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
              bottom: BorderSide(width: 1, color: Colors.black54),
            )),
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Text(suggestion.title),
          );
        },
        onSuggestionSelected: (dynamic suggestion) {
          _controller.text = suggestion.title;
          widget.handleSearchText(suggestion.title);
          widget.onSearch();
        });
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
