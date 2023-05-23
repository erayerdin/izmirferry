part of 'station_bloc.dart';

@freezed
class StationState with _$StationState {
  const factory StationState.loading() = _LoadingState;
  const factory StationState.loaded({
    required Station startStation,
    required Iterable<Station> endStations,
    required Days day,
    required Iterable<String> schedules,
  }) = _LoadedState;
}
