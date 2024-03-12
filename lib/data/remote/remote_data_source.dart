import 'package:weather/data/remote/api_provider.dart';
import 'package:weather/data/responses/forecast_response.dart';
import 'package:weather/data/responses/weather_response.dart';

import 'base_data_source.dart';
import 'base_result.dart';

abstract class RemoteDataSource {
  Future<BaseResult<WeatherResponse>> getCurrentWeather(double latitude, double longitude);
  Future<BaseResult<ForecastResponse>> getForecastWeather(double latitude, double longitude);
  Future<BaseResult<WeatherResponse>> searchWeather(String location);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiProvider provider;

  RemoteDataSourceImpl({
    required this.provider,
  });
  
  @override
  Future<BaseResult<WeatherResponse>> getCurrentWeather(double latitude, double longitude) {
    return BaseDataSource().getResult(provider.get('/weather', {
      "lat": latitude.toString(),
      "lon": longitude.toString()
    }),(response) => WeatherResponse.fromJson(response));
  }
  
  @override
  Future<BaseResult<ForecastResponse>> getForecastWeather(double latitude, double longitude) {
    return BaseDataSource().getResult(provider.get('/forecast', {
      "lat": latitude.toString(),
      "lon": longitude.toString()
    }),(response) => ForecastResponse.fromJson(response));
  }
  
  @override
  Future<BaseResult<WeatherResponse>> searchWeather(String city) {
    return BaseDataSource().getResult(provider.get('/weather', {
      "q": city
    }),(response) => WeatherResponse.fromJson(response));
  }
}