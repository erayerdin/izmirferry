part of 'station_bloc.dart';

@freezed
class StationEvent with _$StationEvent {
  const factory StationEvent.started() = _Started;
}