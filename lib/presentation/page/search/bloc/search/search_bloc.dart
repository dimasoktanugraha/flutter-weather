import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/domain/repositories/main_repository.dart';

import '../../../../../data/responses/weather_response.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  MainRepository repository;
  
  SearchBloc(this.repository) : super(_Initial()) {
    on<_SearchWeather>((event, emit) async{
      emit(const SearchState.loading());

      final response = await repository.searchWeather(event.city);

      response.fold(
        (l) => emit(SearchState.error(l.message)), 
        (r) => emit(SearchState.loaded(r.data!))
      );
    });
  }
}
