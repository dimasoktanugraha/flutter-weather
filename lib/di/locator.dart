import 'package:get_it/get_it.dart';
import 'package:weather/data/local/database_provider.dart';
import 'package:weather/data/local/local_data_source.dart';
import 'package:weather/domain/usecases/get_foreacast.dart';
import 'package:weather/domain/usecases/get_weather.dart';
import 'package:weather/domain/usecases/search_weather.dart';
import 'package:weather/presentation/page/home/bloc/foreacast/forecast_bloc.dart';
import 'package:weather/presentation/page/home/bloc/weather/weather_bloc.dart';
import 'package:weather/presentation/page/search/bloc/search/search_bloc.dart';
import 'package:weather/presentation/page/setting/bloc/theme/theme_bloc.dart';
import 'package:weather/presentation/page/setting/bloc/unit/unit_bloc.dart';

import '../data/remote/api_provider.dart';
import '../data/remote/remote_data_source.dart';
import '../data/repositories/main_repository_impl.dart';
import '../domain/repositories/main_repository.dart';

final locator = GetIt.instance;

void init() {
  // API
  locator.registerLazySingleton<ApiProvider>(() => ApiProvider());

  // Database
  locator.registerLazySingleton<DatabaseProvider>(() => DatabaseProvider());

  // Data Source
  locator.registerLazySingleton<RemoteDataSource>(
          () => RemoteDataSourceImpl(provider: locator()));
  locator.registerLazySingleton<LocalDataSource>(
          () => LocalDatasourceImpl(provider: locator()));
  
  // Repository
  locator.registerLazySingleton<MainRepository>(
          () => MainRepositoryImpl(
            remoteDataSource: locator(),
            localDataSource: locator(),
          ));
  
  // Use Case
  locator.registerLazySingleton(() => GetWeather(locator()));
  locator.registerLazySingleton(() => GetForecast(locator()));
  locator.registerLazySingleton(() => SearchWeather(locator()));
  
  // Bloc
  locator.registerFactory(() => UnitBloc(locator()));
  locator.registerFactory(() => ThemeBloc(locator()));
  locator.registerFactory(() => WeatherBloc(locator()));
  locator.registerFactory(() => ForecastBloc(locator()));
  locator.registerFactory(() => SearchBloc(locator()));
}