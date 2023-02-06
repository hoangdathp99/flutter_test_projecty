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

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_application_1/model/test_model.dart';
import 'package:http/http.dart' as http;

import 'product.dart';
import 'product_repository.dart';

class AppStateModel extends foundation.ChangeNotifier {
  // All the available products.
  List<Product> _availableProducts = [];
  PostModel _postModel =
      PostModel(id: "0", userId: "0", title: "title", body: "body");
  PageController _controller = PageController(initialPage: 0);
  bool loading = true;
  // Loads the list of available products from the repo.
  void loadProducts() async {
    await Future.delayed(const Duration(seconds: 3));
    _availableProducts = ProductsRepository.loadProducts(Category.all);
    loading = false;
    notifyListeners();
  }

  Future<PostModel> getTinWinProductData(context) async {
    // ignore: unused_local_variable
    final res = await http.get(
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        Uri.parse("https://jsonplaceholder.typicode.com/posts/1"));
    if (res.statusCode == 200) {
      final item = jsonDecode(res.body);
      return PostModel.fromJson(item);
      // print(PostModel.fromJson(item));
      // print(item);
      // return result;
    } else {
      throw Exception('Failed to load post');
    }
  }

  void getTinWinData(context) async {
    loading = true;
    _postModel = await getTinWinProductData(context);
    loading = false;
    notifyListeners();
  }

  PageController get controller => _controller;
  List<Product> get availableProducts => _availableProducts;
  PostModel get postModel => _postModel;
  String get productName =>
      _availableProducts.isNotEmpty ? _availableProducts[0].toString() : "";
}
