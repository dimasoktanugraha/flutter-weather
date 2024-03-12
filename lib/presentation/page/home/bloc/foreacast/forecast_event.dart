part of 'forecast_bloc.dart';

@freezed
class ForecastEvent with _$ForecastEvent {
  const factory ForecastEvent.started() = _Started;
  const factory ForecastEvent.getForecast(double latitude, double longitude) = _GetForecast;
}