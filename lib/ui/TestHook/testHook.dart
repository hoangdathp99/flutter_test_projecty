import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MyWidget extends HookWidget {
 const MyWidget( {Key? key})
      : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    final counter = useState(0);
    useEffect((){
      print("first");
    },[counter.value]);
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("test"),
        ),
        body: Center(
          
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      counter.value++;
                    },
                    child: const Text('load product'),
                  ),
                 
                      Text(counter.value.toString())
                      
                ])
          
        ));
  }
}