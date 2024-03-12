part of 'unit_bloc.dart';

@freezed
class UnitEvent with _$UnitEvent {
  const factory UnitEvent.started() = _Started;
  const factory UnitEvent.toogleUnit() = _ToogleUnit;
}