import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/navigation/action.dart';
import 'package:flutter_application_1/navigation/routePaths.dart';
import 'package:flutter_application_1/ui/login/login_page.dart';
import 'package:flutter_application_1/utils/utils.dart';

var dio = Dio();
configDio() {
  dio.interceptors
      .add(QueuedInterceptorsWrapper(onRequest: (options, handler) async {
    options.connectTimeout = 3000;
    options.receiveTimeout = 3000;

    String? accessToken = await loadData('faketoken');
    String? refreshToken = await loadData('refreshToken');

    if (accessToken == null || refreshToken == null) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil(RoutePaths.login, (route) => false);
      return;
    }

    options.headers['Authorization'] = "Bearer $accessToken";
    return handler.next(options);
  }, onResponse: (Response response, handler) {
    // Do something with response data
    return handler.next(response);
  }, onError: (DioError error, handler) async {
    String? refreshToken = await loadData('refreshToken');
    // Ghi log những lỗi gửi về Sentry hoặc Firebase crashlytics
    if (error.response?.statusCode == 401) {
      RequestOptions options = error.response!.requestOptions;
      try {
        var dio = Dio();
        var res = await dio.post(
            "https://api.escuelajs.co/api/v1/auth/refresh-token",
            data: jsonEncode({"refreshToken": refreshToken}));
        print(res.statusCode);
        LoginRes.fromJson(res.data);
        if (res.statusCode == 201) {
          await saveData("token", LoginRes.fromJson(res.data).accessToken);
          await saveData(
              "refreshToken", LoginRes.fromJson(res.data).refreshToken);
          await saveData("faketoken", LoginRes.fromJson(res.data).accessToken);
          options.headers["Authorization"] =
              "Bearer ${LoginRes.fromJson(res.data).accessToken}";
          final opts = Options(
              method: error.requestOptions.method,
              headers: error.requestOptions.headers);
          final cloneReq = await dio.request(error.requestOptions.path,
              options: opts,
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters);
          return handler.resolve(cloneReq);
        } else if (res.statusCode == 401 || res.statusCode == 403) {
          navigatorKey.currentState
              ?.pushNamedAndRemoveUntil(RoutePaths.login, (route) => false);
        }
      } on DioError catch (e) {
        return;
      }
    }
    return handler.next(error);
  }));
  return dio;
}
