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
        color: Colors.white,
      ),
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
