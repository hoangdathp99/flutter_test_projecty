import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('detailPage'),
        // onPressed: () {
        //   // Navigator.pushAndRemoveUntil(
        //   //     context,
        //   //     MaterialPageRoute(
        //   //         builder: (context) => const MyHomePage(
        //   //               title: "Home",
        //   //               indexTab: 1,
        //   //             )),
        //   //     (Route<dynamic> route) => false);
        // },
      ),
    );
  }
}
