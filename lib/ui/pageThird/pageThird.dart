// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/app_state_model.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/navigation/routePaths.dart';
import 'package:flutter_application_1/services/dio_helper.dart';
import 'package:flutter_application_1/services/http_service.dart';
import 'package:flutter_application_1/services/token_http_services.dart';
import 'package:flutter_application_1/ui/login/login_page.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:http/http.dart' as http;

import '../../model/avatar.dart';

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
  bool avaLoading = false;
  final ImagePicker _picker = ImagePicker();
  Avatar _imageFile = Avatar(filename: "", location: "", originalname: "");
  User user =
      User(id: 1, email: "", password: "", name: "", avatar: "", role: "");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  // void _setImageFileListFromFile(XFile? value) {
  //   _imageFileList = value == null ? null : <XFile>[value];
  // }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppStateModel>(context, listen: true);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Container(
            decoration: const BoxDecoration(
                // gradient: LinearGradient(
                //   colors: [Colors.blue, Colors.white70],
                //   begin: Alignment.centerLeft,
                //   end: Alignment.centerRight,
                //   stops: [0.5, 0.9],
                // ),
                color: Color(0xfff4f4f4)),
            child: AppBar(
              backgroundColor: Colors.transparent,
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title:
                  const Text("Profile", style: TextStyle(color: Colors.black)),
              elevation: 0,
            ),
          ),
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
        body: Container(
          decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [Colors.blue, Colors.white70],
              //   begin: Alignment.centerLeft,
              //   end: Alignment.centerRight,
              //   stops: [0.5, 0.9],
              // ),
              color: Color(0xfff4f4f4)),
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 10),
                                      blurRadius: 10,
                                      spreadRadius: 5.0,
                                    ),
                                  ],
                                  // color: Colors.amber),
                                ),
                                child: const CircleAvatar(
                                  backgroundColor: Color(0xfff4f4f4),
                                  minRadius: 35.0,
                                  child: Icon(Icons.call, size: 30.0),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 10),
                                      blurRadius: 10,
                                      spreadRadius: 5.0,
                                    ),
                                  ],
                                  // color: Colors.amber),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white30,
                                  minRadius: 60.0,
                                  child: avaLoading ? const CircularProgressIndicator() : GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SizedBox(
                                              height: 200,
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    ElevatedButton(
                                                        onPressed: () async {
                                                          final image =
                                                              await _picker
                                                                  .pickImage(
                                                            source: ImageSource
                                                                .gallery,
                                                          );
                                                          if(image != null) {
                                                            updateAvatar(image);
                                                          }
                                                          // ignore: use_build_context_synchronously
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: const Text(
                                                          "Choose image in gallery",
                                                        )),
                                                    ElevatedButton(
                                                        onPressed: () async {
                                                          final image =
                                                              await _picker
                                                                  .pickImage(
                                                            source: ImageSource
                                                                .camera,
                                                          );
                                                          if(image != null) {
                                                            updateAvatar(image);
                                                          }
                                                          // ignore: use_build_context_synchronously
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: const Text(
                                                          "Choose image in camera",
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: CircleAvatar(
                                        radius: 50.0,
                                        backgroundImage: NetworkImage(
                                            _imageFile.location != ""
                                                ? _imageFile.location
                                                : user.avatar)),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 10),
                                      blurRadius: 10,
                                      spreadRadius: 5.0,
                                    ),
                                  ],
                                  // color: Colors.amber),
                                ),
                                child: const CircleAvatar(
                                  backgroundColor: Color(0xfff4f4f4),
                                  minRadius: 35.0,
                                  child: Icon(Icons.message, size: 30.0),
                                ),
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
                              color: Colors.black26,
                            ),
                          ),
                          Text(
                            user.role,
                            style: const TextStyle(
                              color: Colors.black38,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  // width: double.infinity,
                  child: TextButton(
                    onPressed: () async {
                      // String refreshToken = await loadData("refreshToken");
                      removeSuccess = await removeData("token");
                      await removeData("faketoken");

                      if (removeSuccess == true) {
                        removeSuccess = false;
                        provider.logOut();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context, rootNavigator: true)
                            .pushNamedAndRemoveUntil(
                                RoutePaths.login, (route) => false);
                      }
                      // }POST("https://api.escuelajs.co/api/v1/auth/refresh-token",
                      // POST("https://api.escuelajs.co/api/v1/auth/refresh-token",
                      //     {"refreshToken": refreshToken}, refreshToken);
                    },
                    style: TextButton.styleFrom(
                        // fixedSize: const Size(200, 20),
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.transparent,
                        elevation: 0),
                    child: const Text('Logout'),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void getProfile() async {
    String token = await loadData("token");
    // Response? res;

    if (token != '') {
      var res =
          await GET("https://api.escuelajs.co/api/v1/auth/profile?", {"": ""});
      if (res != null) {
        if (res.statusCode == 200) {
          setState(() {
            user = User.fromJson(res.data);
            // print(user.name);
          });
        }
        print(res);
      }
    }
  }

  Future<void> updateAvatar(XFile param) async {
    setState(() {
      avaLoading = true;
    });
    try {
      final dio = Dio();

      dio.options.headers = {
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      final file =
          await MultipartFile.fromFile(param.path, filename: param.name);

      final formData = FormData.fromMap(
          {'file': file}); // 'file' - this is an api key, can be different

      final response = await dio.post(
        // or dio.post
        "https://api.escuelajs.co/api/v1/files/upload",
        data: formData,
      );
      setState(() {
        _imageFile = Avatar.fromJson(response.data);
        avaLoading = false;
      });
    } catch (err) {
      print('uploading error: $err');
    }
  }
}
