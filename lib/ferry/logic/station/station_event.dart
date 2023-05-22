part of 'station_bloc.dart';

@freezed
class StationEvent with _$StationEvent {
  const factory StationEvent.load({
    required Station startStation,
    required Station endStation,
    required Days day,
  }) = _GetEndStationsEvent;
}
