// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_application_1/model/category.dart';
import 'package:flutter_application_1/model/filter.dart';
import 'package:flutter_application_1/model/product.dart';
import 'package:flutter_application_1/services/http_service.dart';

class AppStateModel with foundation.ChangeNotifier {
  // All the available products.
  // ignore: non_constant_identifier_names
  List<ProductType> _ProductType = [
    ProductType(
        id: 0,
        category: Category(id: 0, image: "", name: ""),
        description: "",
        images: [],
        price: 0,
        title: "")
  ];
  // ignore: non_constant_identifier_names
  List<ProductType> _ProductSearch = [];
  bool loading = true;
  // ignore: avoid_init_to_null
  bool? loadingSearch = null;
  // ignore: avoid_init_to_null
  bool? loggedIn = null;
  Filter? _filter = Filter();
  // Loads the list of available products from the repo.
  @override
  void dispose() {
    _ProductSearch = [
      ProductType(
          id: 0,
          category: Category(id: 0, image: "", name: ""),
          description: "",
          images: [],
          price: 0,
          title: "")
    ];
    super.dispose();
  }

  void setFilter(Filter filter) {
    _filter = Filter(minPrice: filter.minPrice, maxPrice: filter.maxPrice);
    notifyListeners();
  }

  void resetFilter() {
    _filter = null;
    notifyListeners();
  }

  void logOut() {
    loggedIn = false;
    notifyListeners();
  }

  void logIn() {
    loggedIn = true;
    notifyListeners();
  }

  void getTinWinData(context) async {
    loading = true;
    Iterable item =
        await fetchData("api.escuelajs.co", "/api/v1/products", {"": ""});
    _ProductType = item.map((e) => ProductType.fromJson(e)).toList();
    loading = false;
    notifyListeners();
  }

  Future<List<ProductType>> getSearchData(context, param) async {
      loadingSearch = true;
      notifyListeners();
      Iterable item =
          await fetchData("api.escuelajs.co", "/api/v1/products/", param);
      List<ProductType> tempProduct =
          item.map((e) => ProductType.fromJson(e)).toList();
      _ProductSearch = tempProduct;
      loadingSearch = false;
      notifyListeners();
      return tempProduct;
  }

  void resetSearchData() {
    _ProductSearch = [
      ProductType(
          id: 0,
          category: Category(id: 0, image: "", name: ""),
          description: "",
          images: [],
          price: 0,
          title: "")
    ];
    loadingSearch = null;
  }

  List<ProductType> get Product => _ProductType;
  List<ProductType> get ProductSearch => _ProductSearch;
  Filter? get Filters => _filter;
}
