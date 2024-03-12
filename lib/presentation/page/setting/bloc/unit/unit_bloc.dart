import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../data/cache/cache_helper_key.dart';
import '../../../../../data/cache/shared_prefs.dart';
import '../../../../../domain/repositories/main_repository.dart';

part 'unit_event.dart';
part 'unit_state.dart';
part 'unit_bloc.freezed.dart';

class UnitBloc extends Bloc<UnitEvent, UnitState> {

  final MainRepository repository;

  UnitBloc(this.repository) : super(_Units(SharedPrefs().unit == WeatherUnits.metric.name)) {


    // on<_Started>((event, emit) {
    //   _Units(sharedPrefs.unit == WeatherUnits.metric.name);
    // });

    on<_ToogleUnit>((event, emit) {
      
      final sharedPrefs = SharedPrefs();
      
      if(sharedPrefs.unit == WeatherUnits.metric.name) {
          sharedPrefs.setUnit(WeatherUnits.imperial);
          emit(const UnitState.units(false));
      } else {
          sharedPrefs.setUnit(WeatherUnits.metric);
          emit(const UnitState.units(true));
      }
    });
  }
}
