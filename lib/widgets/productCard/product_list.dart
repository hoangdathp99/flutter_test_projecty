import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/product.dart';
import 'package:flutter_application_1/navigation/routePaths.dart';
import 'package:flutter_application_1/widgets/productCard/product_card.dart';

class ProductList extends StatelessWidget {
  final List<Product> listProduct;
  const ProductList({super.key, required this.listProduct});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: listProduct.length,
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) => InkWell(
          onTap: () {
            // value.controller.jumpToPage(1);
            Navigator.pushNamed(context, RoutePaths.detail);
            // value.loadProducts();
          },
          child: ProductCard(product: listProduct[index])),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20),
    );
  }
}
