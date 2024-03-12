import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:weather/data/base/exception.dart';
import 'package:weather/data/local/local_data_source.dart';
import 'package:weather/data/model/foreacast_model.dart';
import 'package:weather/data/model/weather_model.dart';
import 'package:weather/data/responses/forecast_response.dart';
import 'package:weather/data/responses/weather_response.dart';
import '../../domain/repositories/main_repository.dart';
import '../base/failure.dart';
import '../cache/shared_prefs.dart';
import '../remote/base_result.dart';
import '../remote/remote_data_source.dart';

class MainRepositoryImpl extends MainRepository{
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  MainRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource
  });
  
  @override
  Future<Either<Failure, WeatherModel>> getCurrentWeather(double latitude, double longitude) async{
    try {
      WeatherModel savedWeather = await localDataSource.getWeather();

      if( savedWeather.id == null
          || DateFormat.yMd().format(savedWeather.createdAt) != DateFormat.yMd().format(DateTime.now())
      ){
        final result = await remoteDataSource.getCurrentWeather(latitude, longitude);

        if (result.status == ResponseStatus.success) {
          final data = result.data;
          WeatherModel weather = WeatherModel(
            iconUrl: data!.weather![0].iconUrl!,
            description: data.weather![0].description!,
            temp: data.main!.temp!,
            tempMax: data.main!.tempMax!,
            tempMin: data.main!.tempMin!,
            unit: SharedPrefs().unit,
            humidity: data.main!.humidity!,
            speed: data.wind!.speed!,
            createdAt: DateTime.now(),
          );

          await localDataSource.insertWeather(weather);

          return Right(weather);
        }

        return Left(ResponseFailure(result.message));
      }

      return Right(savedWeather);
    }on ServerException catch (e){
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated not valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ForecastModel>>> getForecastWeather(double latitude, double longitude) async{
    try {
      // final result = await remoteDataSource.getForecastWeather(latitude, longitude);
      // print("repository ${result}");
      // if (result.status == ResponseStatus.success) {
      //   return Right(result);
      // }
      // return Left(ResponseFailure(result.message));

      List<ForecastModel> savedForecast = await localDataSource.getForecastList();

      if( savedForecast.isEmpty
          || DateFormat.yMd().format(savedForecast[0].createdAt) != DateFormat.yMd().format(DateTime.now())
      ){
        final result = await remoteDataSource.getForecastWeather(latitude, longitude);

        if (result.status == ResponseStatus.success) {
          final data = result.data;

          // get first interval every day
          final items = [0, 8, 16, 24, 32];

          List<ForecastModel> list = [
            for (var i in items) ForecastModel(
                iconUrl: data!.list![i].weather![0].iconUrl! ?? "",
                description: data.list![i].weather![0].description ?? "",
                day: data.list![i].day! ?? "",
                temp: data.list![i].main!.temp ?? 0.0,
                unit: SharedPrefs().unit,
                createdAt: DateTime.now()),
          ];

          await localDataSource.insertForecast(list);

          return Right(list);
        }

        return Left(ResponseFailure(result.message));
      }

      return Right(savedForecast);
    }on ServerException catch (e){
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated not valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, BaseResult<WeatherResponse>>> searchWeather(String city) async{
    try {
      final result = await remoteDataSource.searchWeather(city);
      print("repository ${result}");
      if (result.status == ResponseStatus.success) {
        return Right(result);
      }
      return Left(ResponseFailure(result.message));
    }on ServerException catch (e){
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated not valid\n${e.message}'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, BaseResult<LoginModel>>> postLogin(LoginRequest request) async{
    // return getRepositoryResult(remoteDataSource.postLogin(request));
  //   try {
  //     final result = await remoteDataSource.postLogin(request);
  //     print("repository ${result}");
  //     return Right(result);
  //   }on ServerException catch (e){
  //     return Left(ServerFailure(e.message));
  //   } on SocketException {
  //     return Left(ConnectionFailure('Failed to connect to the network'));
  //   } on TlsException catch (e) {
  //     return Left(CommonFailure('Certificated not valid\n${e.message}'));
  //   } catch (e) {
  //     return Left(CommonFailure(e.toString()));
  //   }
  // }

  // @override
  // Future<Either<Failure, BaseResult<ChatModel>>> postNLP(NLPRequest request) async{
  //   try {
  //     final result = await remoteDataSource.postNLP(request);
  //     return Right(result);
  //   } on ServerException catch (e){
  //     return Left(ServerFailure(e.message));
  //   } on SocketException {
  //     return Left(ConnectionFailure('Failed to connect to the network'));
  //   } on TlsException catch (e) {
  //     return Left(CommonFailure('Certificated not valid\n${e.message}'));
  //   } catch (e) {
  //     return Left(CommonFailure(e.toString()));
  //   }
  // }

  // Future<T> requestServer(FutureOr<T> computation()) async{
  //   try {
  //     return await computation();
  //   } on SocketException catch (_) {
  //     throw ConstText.NO_CONNECTION;
  //   } on TimeoutException catch (_) {
  //     throw ConstText.TIMEOUT_EXCEPTION;
  //   } on FormatException catch (_) {
  //     throw ConstText.FORMAT_EXCEPTION;
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

  // @override
  // Future<String> getToken() {
  //   return cacheDataSource.getToken();
  // }
  //
  // @override
  // Future<bool> hasLogin() {
  //   return cacheDataSource.hasLogin();
  // }
  //
  // @override
  // void saveLogin(bool isLogin) {
  //   cacheDataSource.saveLogin(isLogin);
  // }
  //
  // @override
  // void saveToken(String token) {
  //   cacheDataSource.saveToken(token);
  // }

  // Failure handleError(Object e) {
  //   on ServerException catch (e){
  //     return Left(ServerFailure(e.message));
  //   } on SocketException {
  //     return Left(ConnectionFailure('Failed to connect to the network'));
  //   } on TlsException catch (e) {
  //     return Left(CommonFailure('Certificated not valid\n${e.message}'));
  //   } catch (e) {
  //     return Left(CommonFailure(e.toString()));
  //   }
  // }

  // Future<Either<Failure, dynamic>> getRepositoryResult(Future<dynamic> request) async{
  //   try {
  //     final result = await request;
  //     return Right(result);
  //   } on ServerException catch (e){
  //     return Left(ServerFailure(e.message));
  //   } on SocketException {
  //     return Left(ConnectionFailure('Failed to connect to the network'));
  //   } on TlsException catch (e) {
  //     return Left(CommonFailure('Certificated not valid\n${e.message}'));
  //   } catch (e) {
  //     return Left(CommonFailure(e.toString()));
  //   }
  // }

}
