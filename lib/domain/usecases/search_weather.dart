import 'package:dartz/dartz.dart';
import 'package:weather/data/responses/weather_response.dart';
import '../../data/base/failure.dart';
import '../../data/remote/base_result.dart';
import '../repositories/main_repository.dart';

class SearchWeather {
  final MainRepository repository;

  SearchWeather(this.repository);

  Future<Either<Failure, BaseResult<WeatherResponse>>> execute(String city) {
    return repository.searchWeather(city);
  }
}
