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

import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_application_1/model/category.dart';
import 'package:flutter_application_1/model/product.dart';
import 'package:flutter_application_1/services/http_service.dart';

class AppStateModel extends foundation.ChangeNotifier {
  // All the available products.
  List<ProductType> _ProductType = [ProductType(id: 0,category: Category(id: 0,image: "",name: ""),description: "",images: [],price: 0,title: "")];
  bool loading = true;
  // Loads the list of available products from the repo.
  
  void getTinWinData(context) async {
    loading = true;
    Iterable item = await fetchData("https://api.escuelajs.co/api/v1/products");
    _ProductType = item.map((e) => ProductType.fromJson(e)).toList();
    loading = false; 
    notifyListeners();
  }

  List<ProductType> get Product  => _ProductType;
  
}
