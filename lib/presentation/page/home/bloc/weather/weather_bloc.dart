import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/data/model/weather_model.dart';
import 'package:weather/domain/repositories/main_repository.dart';

import '../../../../../data/responses/weather_response.dart';

part 'weather_event.dart';
part 'weather_state.dart';
part 'weather_bloc.freezed.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final MainRepository repository;

  WeatherBloc(this.repository) : super(_Initial()) {

    on<_GetWeather>((event, emit) async{
      emit(const WeatherState.loading());

      final response = await repository.getCurrentWeather(event.latitude, event.longitude);

      response.fold(
        (l) => emit(WeatherState.error(l.message)), 
        (r) => emit(WeatherState.loaded(r))
      );
    });
  }
}
