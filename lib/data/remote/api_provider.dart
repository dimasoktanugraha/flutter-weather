import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather/common/variables.dart';

import '../cache/shared_prefs.dart';

class ApiProvider{
  late Dio _dio;

  ApiProvider(){
    _dio = Dio(
      BaseOptions(
        validateStatus: (status) {
          return true;
        },
        headers: {
          "Accept": "application/json",
        },
        followRedirects: false,
        baseUrl: Variables.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    _dio.interceptors.add(PrettyDioLogger());
  }

  Map<String, dynamic>? params(Map<String, dynamic> param){
    param["appid"] = Variables.apiKey;
    param["units"] = SharedPrefs().unit;
    return param;
  }

  Future<Response<dynamic>> get<T>(String url, Map<String, dynamic> param) async {
    final Response response = await _dio.get(url, queryParameters: params(param));
    return response;
  }

  Future<Response<dynamic>> post<T>(
      String url, Map<String, dynamic> body) async {
    final Response response = await _dio.post(url, data: body);
    return response;
  }
}