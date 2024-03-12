import 'package:dartz/dartz.dart';
import 'package:weather/data/model/weather_model.dart';
import '../../data/base/failure.dart';
import '../repositories/main_repository.dart';

class GetWeather {
  final MainRepository repository;

  GetWeather(this.repository);

  Future<Either<Failure, WeatherModel>> execute(double latitude, double longitude) {
    return repository.getCurrentWeather(latitude, longitude);
  }
}
