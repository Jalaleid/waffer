// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';

import '../../components/constants.dart';

class DioHelper {
  static Dio? dio;
  final dii = Dio();
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: BaseURL!,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'X-Auth-Token': token ?? '',
    };
    return dio!.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'X-Auth-Token': token ?? '',
    };
    return await dio!.get(
      url,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'X-Auth-Token': token
    };
    print(token);
    return dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
