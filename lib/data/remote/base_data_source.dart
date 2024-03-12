import 'dart:io';

import 'package:dio/dio.dart';

import 'base_error.dart';
import 'base_result.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

class BaseDataSource {
  Future<BaseResult<T>> getResult<T>(
      Future<Response<dynamic>> call,
      ResponseConverter<T> converter
  ) async {
    try {
      var response = await call;

      if (response.statusCode == 200 || response.statusCode == 201) {
        var transform = converter(response.toString());
        return BaseResult.success(transform);
      } else {
        final transform = BaseError.fromJson(response.toString());
        return BaseResult.error(
          int.parse(transform.cod ?? "0"),
          transform.cod ?? '',
          transform.message ?? '',
        );
      }

    }on FormatException catch(e){
      print("format : ${e.toString()}");
      throw BaseResult.error(1, 'There is Wrong Format', e.toString());
    } on DioException catch (e) {
      print("dio : ${e.toString()}");
      return BaseResult.error(2, 'There is Something Wrong from Server', e.toString());
    } on SocketException catch (e) {
      print("socket : ${e.toString()}");
      return BaseResult.error(3, 'There is No Internet Connection', e.toString());
      // throw NoInternetConnectionException();
    } on Exception catch(e){
      print("exception : ${e.toString()}");
      throw BaseResult.error(4, 'There is Something Wrong', e.toString());
    }
  }
}
