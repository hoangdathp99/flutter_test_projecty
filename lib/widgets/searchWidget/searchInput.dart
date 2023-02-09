import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color(0xFFf4f4f4),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            const BoxShadow(
              color: Color(0xFFc5c5c5),
              offset: Offset(5, 5),
              blurRadius: 20,
              spreadRadius: 5,
            ),
            const BoxShadow(
              color: Color(0xFFffffff),
              offset: Offset(-5, -5),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ]),
      height: 40,
      width: MediaQuery.of(context).size.width / 2,
      padding: const EdgeInsets.only(top: 10, right: 15, bottom: 10, left: 15),
      child: const Text(
        "Search",
        style: TextStyle(color: Colors.black54, fontSize: 16),
      ),
    );
  }
}
