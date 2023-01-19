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

import 'product.dart';

class ProductsRepository {
  static const _allProducts = <Product>[
    Product(
      category: Category.accessories,
      id: 0,
      description: 'Prepare any meal you want.',
      isFeatured: true,
      name: 'Red Shirt',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      category: Category.accessories,
      id: 1,
      isFeatured: true,
      name: 'Trousers',
      description: 'Prepare any meal you want.',
      price: 19.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      category: Category.accessories,
      id: 2,
      isFeatured: true,
      name: 'Yellow Scarf',
      description: 'Prepare any meal you want.',
      price: 39.99,
      imageUrl:
          'https://cdn.alongwalker.co/info/wp-content/uploads/2022/11/11190447/image-400-hinh-anh-anime-nam-nu-sieu-cute-cuc-ngau-dep-nhat-574757ab56022035d4726e6d8942bed2.jpg',
    ),
    Product(
      category: Category.accessories,
      id: 3,
      isFeatured: true,
      description: 'Prepare any meal you want.',
      name: 'A Pan',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
  static late PageController controller;
  static List<Product> loadProducts(Category category) {
    if (category == Category.all) {
      return _allProducts;
    } else {
      return _allProducts.where((p) => p.category == category).toList();
    }
  }

  static setController(controller) {
    return controller;
  }
}
