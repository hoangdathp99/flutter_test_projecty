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

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;

import 'product.dart';
import 'product_repository.dart';

class AppStateModel extends foundation.ChangeNotifier {
  // All the available products.
  List<Product> _availableProducts = [];
  PageController _controller = PageController(initialPage: 0);
  // Loads the list of available products from the repo.
  void loadProducts() {
    _availableProducts = ProductsRepository.loadProducts(Category.all);
    notifyListeners();
  }

  PageController get controller => _controller;
  List<Product> get availableProducts => _availableProducts;
  String get productName =>
      _availableProducts.isNotEmpty ? _availableProducts[0].toString() : "";
}