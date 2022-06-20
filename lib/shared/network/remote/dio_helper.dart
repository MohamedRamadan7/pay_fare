import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://payfare.azurewebsites.net/',
      receiveDataWhenStatusError: true,
    ),
  );

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://payfare.azurewebsites.net/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    // String lang = 'en',
    // String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      // 'lang': lang,
      // 'Authorization': token ?? '',
    };

    return await dio.get(
      url,
      queryParameters: query ?? null,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
    };

    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
    };

    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
