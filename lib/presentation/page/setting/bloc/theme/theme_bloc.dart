import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../data/cache/shared_prefs.dart';
import '../../../../../domain/repositories/main_repository.dart';

part 'theme_event.dart';
part 'theme_state.dart';
part 'theme_bloc.freezed.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {

  final MainRepository repository;

  ThemeBloc(this.repository) : super(_Theme(SharedPrefs().theme)) {

    // final sharedPrefs = SharedPrefs();

    // on<_Started>((event, emit) {
    //   _Theme(SharedPrefs().theme);
    // });

    on<_ToogleTheme>((event, emit) {
      final sharedPrefs = SharedPrefs();

      if(sharedPrefs.theme){
        sharedPrefs.setTheme(false);
        emit(const ThemeState.theme(false));
      }else{
        sharedPrefs.setTheme(true);
        emit(const ThemeState.theme(true));
      }

      // final isDark = !sharedPrefs.theme;

      // emit(ThemeState.theme(isDark));
      // sharedPrefs.setTheme(isDark);
    });
  }
}
