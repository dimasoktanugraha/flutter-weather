part of 'unit_bloc.dart';

@freezed
class UnitState with _$UnitState {
  const factory UnitState.initial() = _Initial;
  const factory UnitState.units(bool isCelcius) = _Units;
}
