part of 'forecast_bloc.dart';

@freezed
class ForecastState with _$ForecastState {
  const factory ForecastState.initial() = _Initial;
  const factory ForecastState.loading() = _Loading;
  const factory ForecastState.loaded(List<ForecastModel> weather) = _Loaded;
  const factory ForecastState.error(String message) = _Error;
}
