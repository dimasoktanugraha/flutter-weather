import 'package:dartz/dartz.dart';
import 'package:weather/data/model/foreacast_model.dart';
import 'package:weather/data/responses/forecast_response.dart';
import 'package:weather/data/responses/weather_response.dart';

import '../../data/base/failure.dart';
import '../../data/model/weather_model.dart';
import '../../data/remote/base_result.dart';

abstract class MainRepository {

  // Remote
  Future<Either<Failure, WeatherModel>> getCurrentWeather(double latitude, double longitude);
  Future<Either<Failure, List<ForecastModel>>> getForecastWeather(double latitude, double longitude);
  Future<Either<Failure, BaseResult<WeatherResponse>>> searchWeather(String city);
}
