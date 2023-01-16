import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/ui/bottomNavbar/main_page.dart';

class SecondScreenDetail extends StatefulWidget {
  const SecondScreenDetail({super.key});

  @override
  State<SecondScreenDetail> createState() => _SecondScreenDetailState();
}

class _SecondScreenDetailState extends State<SecondScreenDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(title: const Text("detailSecondPage")),
      body: Center(
          child: ElevatedButton(
        child: const Text('detailSecondPage'),
        onPressed: () {
          // PersistentNavBarNavigator.pushNewScreen(context,
          //     screen: const MyHomePage(title: "Home", indexTab: 1),
          //     withNavBar: true);
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => const MyHomePage(
          //               title: "Home",
          //               indexTab: 1,
          //             )),
          //     (Route<dynamic> route) => false);
          Navigator.of(context).popUntil((route) {
            if (Navigator.of(context).canPop()) {
              return route.settings.name == "/";
            }
            // else {
            return true;
            // }
          });
        },
      )),
    ));
  }
}
