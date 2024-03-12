import 'package:dartz/dartz.dart';
import 'package:weather/data/model/foreacast_model.dart';
import 'package:weather/data/responses/forecast_response.dart';
import '../../data/base/failure.dart';
import '../../data/remote/base_result.dart';
import '../repositories/main_repository.dart';

class GetForecast {
  final MainRepository repository;

  GetForecast(this.repository);

  Future<Either<Failure, List<ForecastModel>>> execute(double latitude, double longitude) {
    return repository.getForecastWeather(latitude, longitude);
  }
}
