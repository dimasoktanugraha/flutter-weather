import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather/data/local/database_provider.dart';

import '../model/foreacast_model.dart';
import '../model/weather_model.dart';

abstract class LocalDataSource {
  
  Future<int> insertWeather(WeatherModel weather);
  Future<WeatherModel> getWeather();

  Future<int> insertForecast(List<ForecastModel> forecasts);
  Future<List<ForecastModel>> getForecastList();
}

class LocalDatasourceImpl implements LocalDataSource{

  final DatabaseProvider provider;

  LocalDatasourceImpl({
    required this.provider,
  });
  
  @override
  Future<WeatherModel> getWeather() {
    return provider.getWeather();
  }
  
  @override
  Future<int> insertWeather(WeatherModel weather) async{
    await provider.deleteWeather();
    return provider.insertWeather(weather);
  }
  
  @override
  Future<List<ForecastModel>> getForecastList() {
    return provider.getForecastList();
  }
  
  @override
  Future<int> insertForecast(List<ForecastModel> forecasts) async{
    await provider.deleteForecasts();
    return provider.insertForecast(forecasts);
  }
}