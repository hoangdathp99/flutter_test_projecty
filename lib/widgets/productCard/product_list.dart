import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/product.dart';
import 'package:flutter_application_1/navigation/routePaths.dart';
import 'package:flutter_application_1/ui/detailPage/detail_page.dart';
import 'package:flutter_application_1/widgets/productCard/product_card.dart';

class ProductList extends StatelessWidget {
  final List<ProductType> listProduct;
  const ProductList({super.key, required this.listProduct});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFf4f4f4)),
      child: GridView.builder(
        itemCount: listProduct.length,
        padding:
            const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
        itemBuilder: (context, index) => InkWell(
            onTap: () {
              // value.controller.jumpToPage(1);
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    settings: RouteSettings(arguments: listProduct[index]),
                    transitionDuration: const Duration(milliseconds: 300),
                    pageBuilder: (_, __, ___) => const DetailPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, page) {
                      var begin = 0.0;
                      var end = 1.0;
                      var curve = Curves.fastLinearToSlowEaseIn;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      return ScaleTransition(
                        alignment: const Alignment(0, 0),
                        scale: animation.drive(tween),
                        child: page,
                      );
                    },
                  ));
              // arguments: listProduct[index],);
              // value.loadProducts();
            },
            child: ProductCard(product: listProduct[index])),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
      ),
    );
  }
}
