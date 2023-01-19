import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/product.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Column(children: [
        Image.network(product.imageUrl),
        Text(product.name),
        Text('\$${product.price.toString()}'),
        const SizedBox(
          height: 20,
        )
      ]),
    );
  }
}
