part of 'station_bloc.dart';

@freezed
class StationEvent with _$StationEvent {
  const factory StationEvent.getEndStations({
    required Station startStation,
    required Days day,
  }) = _GetEndStationsEvent;
}
