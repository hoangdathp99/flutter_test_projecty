import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/product.dart';
import 'package:flutter_application_1/utils/utils.dart';
class ProductCard extends StatelessWidget {
  final ProductType product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFf4f4f4),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            const BoxShadow(
              color: Color(0xFFcfcfcf),
              offset: Offset(10, 10),
              blurRadius: 20,
              spreadRadius: 6,
            ),
            const BoxShadow(
              color: Color(0xFFffffff),
              offset: Offset(-10, -10),
              blurRadius: 20,
              spreadRadius: 6,
            ),
          ]),
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(product.images[0]), fit: BoxFit.contain),
          ),
          height: 160,
        ),
        // const SizedBox(height: 10),
        Column(children: [
          SizedBox(
            height: 45,
            child: Text(
              capitalize(product.title),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  ),
              textAlign: TextAlign.center,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text('\$${product.price.toString()}',style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
          const SizedBox(
            height: 15,
          )
        ])
      ]),
    );
  }
}
