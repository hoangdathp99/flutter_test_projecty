import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // border: Border.all(color: Color(0xFFBEBEBE)),
          borderRadius: BorderRadius.circular(10),
          color:  const Color(0xFFf4f4f4),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            const BoxShadow(
              color:  Color(0xFFcfcfcf),
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
          ]
          ),
      padding: const EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 0),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          decoration: BoxDecoration(
            // borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            image: DecorationImage(
                image: NetworkImage(product.imageUrl), fit: BoxFit.contain),
          ),
          height: 160,
        ),
        const SizedBox(height: 10),
        Column(children: [
          Text(product.name,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
          Text('\$${product.price.toString()}'),
          const SizedBox(
            height: 20,
          )
        ])
      ]),
    );
  }
}
