import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/data/model/foreacast_model.dart';
import 'package:weather/data/responses/forecast_response.dart';

import '../../../../../domain/repositories/main_repository.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';
part 'forecast_bloc.freezed.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {

  final MainRepository repository;

  ForecastBloc(this.repository) : super(_Initial()) {
    on<_GetForecast>((event, emit) async{
      emit(const ForecastState.loading());

      final response = await repository.getForecastWeather(event.latitude, event.longitude);

      response.fold(
        (l) => emit(ForecastState.error(l.message)), 
        (r) {
          // get first interval every day
          // final items = [0, 8, 16, 24, 32];
          // List<WeatherForecast> data = [
          //   for (var i in items) r.data!.list![i],
          // ];
          emit(ForecastState.loaded(r));
        }
      );
    });
  }
}
