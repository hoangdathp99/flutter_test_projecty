import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/app_state_model.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/services/token_http_services.dart';
import 'package:flutter_application_1/ui/login/login_page.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:provider/provider.dart';

class PageThird extends StatefulWidget {
  const PageThird({super.key});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<PageThird> createState() => _PageThirdState();
}

class _PageThirdState extends State<PageThird> {
  bool removeSuccess = false;
  User user =
      User(id: 1, email: "", password: "", name: "", avatar: "", role: "");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppStateModel>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Profile"),
        ),
        // body: Center(child: Consumer<AppStateModel>(
        //   builder: (context, value, child) {
        //     return Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           ElevatedButton(
        //             onPressed: () async {
        //               removeSuccess = await removeData();
        //               if (removeSuccess == true) {
        //                 // removeSuccess = false;
        //                 // ignore: use_build_context_synchronously
        //                 Navigator.pushAndRemoveUntil(
        //                     context,
        //                     MaterialPageRoute(
        //                         builder: (_) => const LoginScreen()),
        //                     (route) => false);
        //               }
        //             },
        //             child: const Text('Logout'),
        //           ),
        //         ]);
        //   },
        // ))
        body: Stack(
          children: [
            ListView(
              children: [
                Container(
                  height: 250,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.white70],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.5, 0.9],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.blue.shade300,
                            minRadius: 35.0,
                            child: const Icon(Icons.call, size: 30.0),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white70,
                            minRadius: 60.0,
                            child: CircleAvatar(
                                radius: 50.0,
                                backgroundImage: NetworkImage(user.avatar)),
                          ),
                          const CircleAvatar(
                            backgroundColor: Colors.white30,
                            minRadius: 35.0,
                            child: Icon(Icons.message, size: 30.0),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Flutter Developer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () async {
                  removeSuccess = await removeData();
                  if (removeSuccess == true) {
                    removeSuccess = false;
                    provider.logOut();
                    // ignore: use_build_context_synchronously
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (_) => LoginScreen()));
                  }
                },
                style: ElevatedButton.styleFrom(fixedSize: Size(200, 20)),
                child: const Text('Logout'),
              ),
            ),
          ],
        ));
  }

  void getProfile() async {
    var res = await get("https://api.escuelajs.co/api/v1/auth/profile", "");
    setState(() {
      user = User.fromJson(res);
      // print(user.name);
    });
    // print(res);
  }
}
