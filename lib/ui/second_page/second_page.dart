import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/model/app_state_model.dart';
import 'package:provider/provider.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppStateModel>(context, listen: false).getTinWinData(context);
    });
    print("initState Called2");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Second Page"),
        ),
        body: Consumer<AppStateModel>(
          builder: (context, value, child) {
            // print(value.productName);
            // return SingleChildScrollView(
            return !value.loading
                // ? ProductList(listProduct: value.availableProducts)
                ? Center(
                    child: Text(value.Product[0].title != null ? value.Product[0].title.toString() : ""),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ));
  }
}
