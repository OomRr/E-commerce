import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioHelper {
  static Dio dio = Dio(
    BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        ),
  );

  /* static Future<Response> getDate(
      {required String query}) async {
    return await dio.get(
        'https://newsapi.org/v2/$query&apikey=7cfeee815042464cb7855fb97e35ba72');
  }*/
  static Future<Response> getDate({
    required String url,
    required Map<String, dynamic> query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers={
      'lang': lang,
      'Authorization': token??'',
      'Content-Type': 'application/json',
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers={
      'lang': lang,
      'Authorization': token??'',
      'Content-Type': 'application/json',
    };
     return await dio.post(url, queryParameters: query, data: data);
  }

}
